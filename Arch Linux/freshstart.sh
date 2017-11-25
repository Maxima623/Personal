#! /bin/sh

# Add check for root access
if [ $EUID != 0 ]; then echo "Root privelages required. Please run as root."; echo; exit 1; fi

# Fully upgrade system first
pacman -Syyu --noconfirm
echo

# Install bumblebee for Optimus support instead of nouveau
pacman -S --noconfirm bumblebee bbswitch-dkms mesa nvidia-dkms nvidia-settings nvidia-utils primus virtualgl xf86-video-intel
echo

# Install other recommended packages and libraries
pacman -S --noconfirm adapta-gtk-theme adapta-kde ethtool irqbalance linux-zen linux-zen-headers redshift tlp smartmontools systemd-swap wine x86_energy_perf_policy lib32-libcanberra-pulse lib32-libpulse lib32-mesa lib32-nvidia-utils lib32-primus lib32-virtualgl
echo

# Enable bumblebee at boot
gpasswd -a $USER bumblebee
gpasswd -a $USER video
echo

# Download some stuff
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-root.sh | sh
wget -P /etc/systemd/system https://raw.githubusercontent.com/Maxima623/Tweaks/master/Linux/tweak.service
wget -P /usr/local/bin https://raw.githubusercontent.com/Maxima623/Tweaks/master/Linux/tweak
wget -P /usr/local/bin https://raw.githubusercontent.com/Maxima623/Tweaks/master/Linux/xwine
chmod +x /usr/local/bin/tweak
chmod +x /usr/local/bin/xwine
echo

# Enable services at boot
systemctl enable bumblebeed.service
systemctl enable irqbalance.service
systemctl enable systemd-swap.service
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl enable tweak.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
echo

# Clear pacman cache and optimize database
yes | pacman -Scc; echo; pacman -Syyu; echo; pacman-optimize; sync

exit 0
