FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        glibc-langpack-en \
        NetworkManager \
        NetworkManager-wifi \
        nftables \
        openssh-server \
        rsync \
        wpa_supplicant

# wifi firmware
RUN dnf -y install \
        atheros-firmware \
        brcmfmac-firmware \
        iwlwifi-mvm-firmware \
        mt7xxx-firmware \
        nxpwireless-firmware \
        realtek-firmware

# needed for brew
RUN dnf -y install \
        automake \
        gcc \
        gcc-c++ \
        git \
        kernel-devel \
        make \
    && dnf clean all \
    && rm -rf /var/cache

# systemd-resolved as the mDNS responder: answers <hostname>.local (udp/5353)
RUN mkdir -p /etc/systemd/resolved.conf.d \
    && printf '[Resolve]\nMulticastDNS=yes\n' > /etc/systemd/resolved.conf.d/90-mdns.conf

COPY nftables.nft /etc/sysconfig/nftables.conf
RUN systemctl enable nftables.service

RUN systemctl enable sshd.service

RUN systemctl enable systemd-resolved.service

RUN ln -sf /dev/null /usr/lib/systemd/system/systemd-remount-fs.service
