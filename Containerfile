FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        NetworkManager \
        NetworkManager-wifi \
        wpa_supplicant \
        iwlwifi-mvm-firmware \
        openssh-server \
    && dnf clean all \
    && rm -rf /var/cache

RUN systemctl enable sshd.service

RUN ln -sf /dev/null /usr/lib/systemd/system/systemd-remount-fs.service
