# Linux Script Fixes for Warp Terminal

## Problem Analysis
The original scripts were failing on Linux because they were looking for Warp in incorrect locations. On Linux, Warp Terminal uses different directory names and package names compared to macOS and Windows.

## Key Changes Made

### 1. Fixed Directory Names
According to the official Warp documentation, Linux uses `warp-terminal` as the directory name, not just `warp`:

- **Configuration**: `$XDG_CONFIG_HOME/warp-terminal` (not `/warp`)
- **Application Data**: `$XDG_DATA_HOME/warp-terminal` (not `/warp`)
- **Cache**: `$XDG_CACHE_HOME/warp-terminal` (not `/warp`)
- **State/Logs**: `$XDG_STATE_HOME/warp-terminal` (not `/warp`)

Also added support for preview versions:
- `warp-terminal-preview` directories

### 2. Fixed Binary Detection
Updated the scripts to check for the correct binary names:
- Primary: `warp-terminal` (official Linux binary name)
- Secondary: `warp` (for backward compatibility)
- Added check for `/usr/bin/warp-terminal`
- Added check for `/opt/warpdotdev` directory

### 3. Fixed Package Manager Detection
Updated package removal instructions for all major Linux package managers:

#### APT (Debian/Ubuntu)
- Now checks for both `warp-terminal` and `warp` packages
- Correct removal command: `sudo apt remove warp-terminal`

#### DNF/YUM (Fedora/RHEL)
- Checks for both `warp-terminal` and `warp` packages
- Correct removal command: `sudo dnf remove warp-terminal`

#### Added Support for More Package Managers:
- **Zypper (openSUSE)**: `sudo zypper remove warp-terminal`
- **Pacman (Arch Linux)**: `sudo pacman -R warp-terminal`

### 4. Fixed Desktop Entry Files
Updated to remove the correct desktop entry files:
- `warp-terminal.desktop` (primary)
- `warp.desktop` (fallback)

## Files Modified
1. `linux_reset.sh` - Identity reset script
2. `linux_remove.sh` - Complete removal script

## Testing
Both scripts have been validated for syntax errors using `bash -n` and should now work correctly on Linux systems.

## Usage
After these fixes, Linux users should be able to:
1. Reset their Warp identity without the "not detected" error
2. Completely remove Warp with proper detection of package manager installations
3. Clean all correct configuration directories

The scripts now properly handle both the standard Warp Terminal installation and preview versions on Linux.