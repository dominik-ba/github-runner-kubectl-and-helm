FROM summerwind/actions-runner:latest

# install kubectl
RUN true && \
    curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl && \
    curl -L "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" -o /tmp/kubectl.sha256 && \
    echo "$(cat /tmp/kubectl.sha256) /tmp/kubectl" | sha256sum --check && \
    chmod +x kubectl && \
    mv ./kubectl /usr/bin/kubectl && \
    kubectl version --client --output=yaml && \
    true

# Install helm 3
ENV HELM_VERSION=3.6.3
ENV HELM_BASE_URL="https://get.helm.sh"
ENV HELM_TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN true && \
    curl -L ${HELM_BASE_URL}/${HELM_TAR_FILE} | tar xvz -C /tmp/ && \
    mv /tmp/linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    helm version && \
    true
