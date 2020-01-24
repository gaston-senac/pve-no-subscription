/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js



echo "DPkg::Post-Invoke {\"dpkg -V pve-manager | grep -q '/pvemanagerlib\.js$' || sed -i 's/if (data.status !== \x27Active\x27)/if (false)/' /usr/share/pve-manager/js/pvemanagerlib.js\";};" > /etc/apt/apt.conf.d/99pveman

# create dpkg pre/post install hooks for persistence
cat <<'EOF' >/etc/apt/apt.conf.d/86pve-nags
DPkg::Pre-Install-Pkgs {
    "while read -r pkg; do case $pkg in *proxmox-widget-toolkit* | *pve-manager*) touch /tmp/.pve-nag-buster && exit 0; esac done < /dev/stdin";
};
DPkg::Post-Invoke {
    "[ -f /tmp/.pve-nag-buster ] && /usr/share/pve-nag-buster.sh && rm -f /tmp/.pve-nag-buster; exit 0";
};
EOF