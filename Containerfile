FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        glibc-langpack-en \
        iwlwifi-mvm-firmware \
        NetworkManager \
        NetworkManager-wifi \
        nftables \
        openssh-server \
        wpa_supplicant

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

COPY nftables.nft /etc/sysconfig/nftables.conf
RUN systemctl enable nftables.service

RUN systemctl enable sshd.service

RUN ln -sf /dev/null /usr/lib/systemd/system/systemd-remount-fs.service
