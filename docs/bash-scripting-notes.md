# Bash Scripting Notes (Day 6)

Date: 2026-02-12
Script: `scripts/install-common-packages.sh`
VM: `vm-day3-ssh-temp`

## Script Features
- Uses strict error mode:
  - `set -Eeuo pipefail`
  - `trap` for error line/command visibility
- Uses variables and arrays:
  - default package list: `git curl jq unzip`
  - optional package override via script args
- Uses loop automation:
  - iterates package list
  - skips already-installed packages
  - installs missing packages
- Detects package manager:
  - `apt`, `dnf`, `yum`

## Execution Summary
- Script detected package manager: `apt`
- Results:
  - Skipped: `git`, `curl`
  - Installed: `jq`, `unzip`

## Validation Output
- `git --version` -> `git version 2.34.1`
- `curl --version` -> `curl 7.81.0 ...`
- `jq --version` -> `jq-1.6`
- `unzip -v | head -n 1` -> `UnZip 6.00 ...`

## Notes
- `debconf` warnings appeared because execution was non-interactive over SSH; installs still completed successfully.
- VM was deallocated after completion for cost control.
