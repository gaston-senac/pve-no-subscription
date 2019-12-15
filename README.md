# pve-no-subscription
Scripts to configure Proxmox VE with no subscription licence

sed -i '1s/^/# /' /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list

LIC_FILE='/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js'
LIC_LINE="data.status !== 'Active'"
sed -i.orig "s/$LIC_LINE/false/g" "$LIC_FILE"