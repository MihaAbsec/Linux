#!/usr/bin/env python3
"""Show or hide a persistent Kitty scratchpad on the current workspace."""
import fcntl
import json
import os
import subprocess
import time
from pathlib import Path


def find_terminal(node):
    if node.get("window_properties", {}).get("class") == "kitty-dropdown":
        return node
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        found = find_terminal(child)
        if found is not None:
            return found
    return None


def terminal():
    tree = subprocess.check_output(["i3-msg", "-t", "get_tree"])
    return find_terminal(json.loads(tree))


runtime = Path(os.environ.get("XDG_RUNTIME_DIR", f"/tmp/dropdown-{os.getuid()}"))
runtime.mkdir(mode=0o700, parents=True, exist_ok=True)
with (runtime / "kitty-dropdown.lock").open("w") as lock:
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except BlockingIOError:
        raise SystemExit(0)
    window = terminal()
    if window is not None:
        subprocess.run(
            ["i3-msg", f'[con_id={window["id"]}] scratchpad show'], check=True
        )
    else:
        subprocess.run(
            ["i3-msg", 'exec --no-startup-id kitty --class kitty-dropdown --title "Terminal"'],
            check=True,
        )
        # Ignore repeated key presses while the first window is opening.
        for _ in range(60):
            window = terminal()
            if window is not None and window.get("scratchpad_state") in ("fresh", "changed"):
                # Show only in response to F12, never from a for_window rule
                # which i3 can reapply when it restarts.
                subprocess.run(
                    ["i3-msg", f'[con_id={window["id"]}] scratchpad show, move position center'],
                    check=True,
                )
                break
            time.sleep(0.05)
