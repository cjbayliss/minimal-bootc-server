FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        git \
        iwlwifi-mvm-firmware \
        NetworkManager \
        NetworkManager-wifi \
        openssh-server \
        wpa_supplicant \
    && dnf clean all \
    && rm -rf /var/cache

RUN systemctl enable sshd.service

RUN ln -sf /dev/null /usr/lib/systemd/system/systemd-remount-fs.service
