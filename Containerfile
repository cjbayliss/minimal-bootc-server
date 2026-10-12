FROM quay.io/fedora/fedora-bootc:44

RUN dnf -y install \
        NetworkManager \
        openssh-server \
    && dnf clean all \
    && rm -rf /var/cache

RUN systemctl enable sshd.service
