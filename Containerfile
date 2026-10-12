FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        git \
        glibc-langpack-en \
        iwlwifi-mvm-firmware \
        NetworkManager \
        NetworkManager-wifi \
        openssh-server \
        wpa_supplicant

# needed for brew
RUN dnf -y install \
        automake \
        gcc \
        gcc-c++ \
        kernel-devel \
        make \
    && dnf clean all \
    && rm -rf /var/cache

RUN systemctl enable sshd.service

RUN ln -sf /dev/null /usr/lib/systemd/system/systemd-remount-fs.service
