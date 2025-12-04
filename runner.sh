#!/bin/bash

# -----------------------------------------
# runner.sh
#
# Purpose: Recursively locate and execute every shell script under a
#          given root directory.
# Usage:   ./runner.sh [root‑dir]
#          If no argument is supplied, the current directory (.) is used.
# -----------------------------------------

set -euo pipefail   # safety – abort on errors, unset vars or pipeline failures

# --------------- 1️⃣ Determine the root directory -------------------
ROOT="${1:-.}"           # default to current directory
if [[ ! -d "$ROOT" ]]; then
    echo "Error: '$ROOT' is not a directory." >&2
   exit 1
fi

# ------------ 2️⃣ Find candidate scripts ----------------------
#   * Regular files ending with .sh
#   * Files that are already executable (user‑x) – they may not have .sh
#   * Files whose first line is a shebang pointing at bash/sh
#
# The find command builds a list, then we filter with grep to keep only
# those that contain a shebang for a POSIX/Bash shell.
#
mapfile -t scripts < <(
    find "$ROOT" -type f \( -name "*.sh" -o -perm -u=x \) \
    -exec awk 'NR==1 && /^#!.*(bash|sh)/ {exit 0} {exit 1}' {} \; -print |
    sort   # alphabetical order for reproducibility
)

# If nothing was found, exit gracefully.
if (( ${#scripts[@]} == 0 )); then
    echo "No shell scripts detected under '$ROOT'."
    exit 0
fi

# ----------------- 3️⃣ Execute each script ---------------------------
echo "Found ${#scripts[@]} shell script(s) under '$ROOT'."
echo "Starting execution…"
echo "------------------------------------------------------------"

for script in "${scripts[@]}"; do
  echo "▶️  Running: $script"
    # Run in a subshell so a failure in one script does not abort the loop.
    (
      set -euo pipefail
        bash "$script"
    )
    rc=$?
    if (( rc != 0 )); then
        echo "⚠️  Script exited with status $rc: $script"
    else
       echo "✅  Completed successfully: $script"
    fi
    echo "----------------------------------------------------------"
done

echo "All done. Processed ${#scripts[@]} script(s)."