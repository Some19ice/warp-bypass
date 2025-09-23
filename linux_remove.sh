#!/bin/bash
# 🗑️ Warp Complete Removal for Linux - Standalone Script
# Completely removes Warp and all traces from your system

echo "================================================"
echo "🐧 WARP COMPLETE REMOVAL FOR LINUX"
echo "================================================"
echo "This will COMPLETELY remove Warp from your system"
echo ""

# Confirm before proceeding
read -p "⚠️  This will COMPLETELY remove Warp. Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled by user"
    exit 1
fi

echo ""
echo "🗑️ Starting complete removal..."

# Kill Warp processes
echo "🔫 Killing Warp processes..."
pkill -f -i warp 2>/dev/null || true
sleep 2

# Get home directory and XDG paths
HOME_DIR=$HOME
XDG_CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_DATA=${XDG_DATA_HOME:-$HOME/.local/share}
XDG_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}
XDG_STATE=${XDG_STATE_HOME:-$HOME/.local/state}

# Remove main application (requires sudo for system paths)
echo "🗑️ Removing Warp application..."
echo "   Note: May require sudo for system directories"

# Try to remove from common locations
if [ -f "/usr/bin/warp-terminal" ]; then
    echo "   Found at /usr/bin/warp-terminal - attempting removal..."
    sudo rm -f /usr/bin/warp-terminal 2>/dev/null || rm -f /usr/bin/warp-terminal 2>/dev/null || echo "   ⚠️ Need sudo to remove /usr/bin/warp-terminal"
fi

if [ -d "/opt/warpdotdev" ]; then
    echo "   Found at /opt/warpdotdev - attempting removal..."
    sudo rm -rf /opt/warpdotdev 2>/dev/null || rm -rf /opt/warpdotdev 2>/dev/null || echo "   ⚠️ Need sudo to remove /opt/warpdotdev"
fi

if [ -d "/opt/Warp" ]; then
    echo "   Found at /opt/Warp - attempting removal..."
    sudo rm -rf /opt/Warp 2>/dev/null || rm -rf /opt/Warp 2>/dev/null || echo "   ⚠️ Need sudo to remove /opt/Warp"
fi

if [ -f "/usr/local/bin/warp" ]; then
    echo "   Found at /usr/local/bin/warp - attempting removal..."
    sudo rm -f /usr/local/bin/warp 2>/dev/null || rm -f /usr/local/bin/warp 2>/dev/null || echo "   ⚠️ Need sudo to remove /usr/local/bin/warp"
fi

if [ -f "/usr/bin/warp" ]; then
    echo "   Found at /usr/bin/warp - attempting removal..."
    sudo rm -f /usr/bin/warp 2>/dev/null || rm -f /usr/bin/warp 2>/dev/null || echo "   ⚠️ Need sudo to remove /usr/bin/warp"
fi

if [ -f "$HOME/.local/bin/warp" ]; then
    echo "   Removing from $HOME/.local/bin/warp..."
    rm -f "$HOME/.local/bin/warp" 2>/dev/null || true
fi

# Clear configuration
echo "📁 Removing configuration..."
rm -rf "$XDG_CONFIG/warp-terminal" 2>/dev/null || true
rm -rf "$XDG_CONFIG/warp-terminal-preview" 2>/dev/null || true
rm -rf "$XDG_CONFIG/warp" 2>/dev/null || true
rm -rf "$XDG_CONFIG/Warp" 2>/dev/null || true
rm -rf "$HOME/.warp" 2>/dev/null || true

# Clear application data
echo "📁 Removing application data..."
rm -rf "$XDG_DATA/warp-terminal" 2>/dev/null || true
rm -rf "$XDG_DATA/warp-terminal-preview" 2>/dev/null || true
rm -rf "$XDG_DATA/warp" 2>/dev/null || true
rm -rf "$XDG_DATA/Warp" 2>/dev/null || true

# Clear cache
echo "🧹 Removing cache..."
rm -rf "$XDG_CACHE/warp-terminal" 2>/dev/null || true
rm -rf "$XDG_CACHE/warp-terminal-preview" 2>/dev/null || true
rm -rf "$XDG_CACHE/warp" 2>/dev/null || true
rm -rf "$XDG_CACHE/Warp" 2>/dev/null || true

# Clear state and logs
echo "📋 Removing state and logs..."
rm -rf "$XDG_STATE/warp-terminal" 2>/dev/null || true
rm -rf "$XDG_STATE/warp-terminal-preview" 2>/dev/null || true
rm -rf "$XDG_STATE/warp" 2>/dev/null || true

# Remove desktop entries
echo "🗂️ Removing desktop entries..."
rm -f "$HOME/.local/share/applications/warp-terminal.desktop" 2>/dev/null || true
rm -f "$HOME/.local/share/applications/warp.desktop" 2>/dev/null || true
sudo rm -f /usr/share/applications/warp-terminal.desktop 2>/dev/null || rm -f /usr/share/applications/warp-terminal.desktop 2>/dev/null || true
sudo rm -f /usr/share/applications/warp.desktop 2>/dev/null || rm -f /usr/share/applications/warp.desktop 2>/dev/null || true

# Clear temporary/runtime files
echo "🗑️ Removing temporary files..."
rm -rf /tmp/warp-$USER 2>/dev/null || true
rm -rf /run/user/$(id -u)/warp 2>/dev/null || true

# Check for package manager installations
echo ""
echo "📦 Checking for package manager installations..."

# Snap
if command -v snap &> /dev/null && snap list 2>/dev/null | grep -q warp; then
    echo "   ⚠️ Warp is installed via Snap. To remove: sudo snap remove warp"
fi

# Flatpak
if command -v flatpak &> /dev/null && flatpak list 2>/dev/null | grep -qi warp; then
    echo "   ⚠️ Warp is installed via Flatpak. To remove: flatpak uninstall dev.warp.Warp"
fi

# Zypper (openSUSE)
if command -v zypper &> /dev/null; then
    if zypper se -i 2>/dev/null | grep -qi "warp-terminal"; then
        echo "   ⚠️ Warp Terminal is installed via Zypper. To remove: sudo zypper remove warp-terminal"
    elif zypper se -i 2>/dev/null | grep -qi "warp"; then
        echo "   ⚠️ Warp is installed via Zypper. To remove: sudo zypper remove warp"
    fi
fi

# Pacman (Arch Linux)
if command -v pacman &> /dev/null; then
    if pacman -Q 2>/dev/null | grep -qi "warp-terminal"; then
        echo "   ⚠️ Warp Terminal is installed via Pacman. To remove: sudo pacman -R warp-terminal"
    elif pacman -Q 2>/dev/null | grep -qi "warp"; then
        echo "   ⚠️ Warp is installed via Pacman. To remove: sudo pacman -R warp"
    fi
fi

# APT (Debian/Ubuntu)
if command -v apt &> /dev/null; then
    if dpkg -l 2>/dev/null | grep -qi "warp-terminal"; then
        echo "   ⚠️ Warp Terminal is installed via APT. To remove: sudo apt remove warp-terminal"
    elif dpkg -l 2>/dev/null | grep -qi "warp"; then
        echo "   ⚠️ Warp is installed via APT. To remove: sudo apt remove warp"
    fi
fi

# DNF/YUM (Fedora/RHEL)
if command -v dnf &> /dev/null; then
    if dnf list installed 2>/dev/null | grep -qi "warp-terminal"; then
        echo "   ⚠️ Warp Terminal is installed via DNF. To remove: sudo dnf remove warp-terminal"
    elif dnf list installed 2>/dev/null | grep -qi "warp"; then
        echo "   ⚠️ Warp is installed via DNF. To remove: sudo dnf remove warp"
    fi
elif command -v yum &> /dev/null; then
    if yum list installed 2>/dev/null | grep -qi "warp-terminal"; then
        echo "   ⚠️ Warp Terminal is installed via YUM. To remove: sudo yum remove warp-terminal"
    elif yum list installed 2>/dev/null | grep -qi "warp"; then
        echo "   ⚠️ Warp is installed via YUM. To remove: sudo yum remove warp"
    fi
fi

# Verify removal
echo ""
echo "🔍 Verifying removal..."
FOUND=0

# Check for any remaining warp files
for dir in "$HOME/.config" "$HOME/.local/share" "$HOME/.cache" "$HOME/.local/state" "/opt" "/usr/local/bin" "/usr/bin"; do
    if [ -d "$dir" ] && find "$dir" -iname "*warp*" 2>/dev/null | grep -q .; then
        FOUND=1
        echo "   ⚠️ Found remaining files in $dir"
    fi
done

if [ $FOUND -eq 0 ]; then
    echo "   ✅ No Warp traces found - clean removal!"
fi

echo ""
echo "================================================"
echo "✅ WARP REMOVAL COMPLETE!"
echo "🔄 Your system will appear as a NEW MACHINE to Warp"
echo "⬇️ You can safely reinstall Warp now"
echo "================================================"
