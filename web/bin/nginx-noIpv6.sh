#!/usr/bin/env bash

# Exit immediately if any command fails, or if using uninitialized variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [[ $EUID -ne 0 ]]; then
   echo "? Error: This script must be run as root or with sudo." 1>&2
   exit 1
fi

echo "?? Checking IPv6 system status..."

# Detect if IPv6 is disabled in the kernel
# 1 = disabled, 0 = enabled. If the file doesn't exist, assume disabled.
IPV6_DISABLED=$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null || echo "1")

if [ "$IPV6_DISABLED" -eq 1 ]; then
    echo "??  System status: IPv6 is DISABLED."
    echo "???  Scanning Nginx configuration files for IPv6 bindings..."

    # Find all Nginx files in /etc/nginx/ that contain 'listen' and '[::]'
    # We use -l to just get the file paths, filtering out commented lines
    NGINX_FILES=$(grep -rl "listen" /etc/nginx/ --include="*.conf" --include="default" 2>/dev/null | xargs grep -l "\[::\]" 2>/dev/null || true)

    if [ -z "$NGINX_FILES" ]; then
        echo "? No active IPv6 listen directives found in Nginx configs."
    else
        echo "?? Found IPv6 directives in the following files:"
        echo "$NGINX_FILES"
        echo "?? Commenting out IPv6 listen directives..."

        # Loop through each file and use sed to comment out the line safely
        # It targets lines containing 'listen' and '[::]' that aren't already commented
        for file in $NGINX_FILES; do
            echo "   . Patching: $file"
            # Backup the file just in case
            cp "$file" "${file}.bak_ipv6"
            # Use sed to add '#' in front of the matching pattern
            sed -i '/^[[:space:]]*listen[[:space:]].*\[::\]/s/^/#/' "$file"
        done

        echo "?? Testing patched Nginx configuration syntax..."
        if nginx -t; then
            echo "? Nginx syntax check passed!"
            echo "?? Restarting Nginx service..."
            if systemctl restart nginx 2>/dev/null || service nginx restart 2>/dev/null; then
                echo "?? Nginx successfully restarted and running on IPv4!"
            else
                echo "? Failed to restart Nginx service. Please check 'journalctl -xeu nginx'."
                exit 1
            fi
        else
            echo "? Nginx configuration test failed after edits! Restoring backups..."
            for file in $NGINX_FILES; do
                mv "${file}.bak_ipv6" "$file"
            done
            exit 1
        fi
    fi
else
    echo "? System status: IPv6 is ENABLED. No configuration changes needed."

    echo "?? Checking if Nginx is currently failing anyway..."
    if ! nginx -t >/dev/null 2>&1; then
        echo "??  Nginx has a syntax issue unrelated to IPv6. Run 'nginx -t' manually to debug."
    fi
fi
