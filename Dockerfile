FROM debian:bullseye-slim

# Instalar dependências básicas
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    openjdk-11-jre \
    python3 \
    python3-pip \
    jq \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Adicionar a chave GPG oficial do Docker e configurar o repositório
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io && \
    rm -rf /var/lib/apt/lists/*

# Instalar SonarQube Scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip && \
    unzip sonar-scanner-cli-4.7.0.2747-linux.zip && \
    mv sonar-scanner-4.7.0.2747-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner && \
    rm -f sonar-scanner-cli-4.7.0.2747-linux.zip

# Instalar Trivy
RUN wget -qO- https://github.com/aquasecurity/trivy/releases/download/v0.58.1/trivy_0.58.1_Linux-64bit.tar.gz | tar xz && \
    mv trivy /usr/local/bin/

# Instalar Terraform
RUN wget https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip && \
    unzip terraform_1.5.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.5.5_linux_amd64.zip

# Instalar Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instalar Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && mv kubectl /usr/local/bin/

# Instalar Python Tools
RUN pip3 install --no-cache-dir \
    pytest \
    newman \
    bandit

# Adicionar variáveis de ambiente para o SonarQube Scanner
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV PATH="$SONAR_SCANNER_HOME/bin:$PATH"

ENTRYPOINT ["cat"]
