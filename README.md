# Docker Image: CI/CD Toolkit

Este documento descreve todas as ferramentas e dependências instaladas na imagem Docker baseada em `debian:bullseye-slim` para pipelines de CI/CD.

---

## **Sistema Base**
- **Imagem Base**: `debian:bullseye-slim`

---

## **Ferramentas Instaladas**

### **Dependências Básicas**
- `curl`: Para realizar requisições HTTP.
- `wget`: Para download de arquivos.
- `gnupg`: Para manipulação de chaves GPG.
- `lsb-release`: Para identificar a distribuição do sistema.
- `git`: Controle de versão.
- `openjdk-11-jre`: Ambiente de execução Java.
- `docker.io`: Ferramenta CLI do Docker.
- `python3`: Interpretador Python 3.
- `python3-pip`: Gerenciador de pacotes Python.
- `jq`: Manipulador de arquivos JSON.
- `unzip`: Para descompactar arquivos `.zip`.
- `nodejs` e `npm`: Ambiente de execução JavaScript e gerenciador de pacotes.

---

### **Ferramentas para CI/CD**
- **SonarQube Scanner**:
  - Versão: `4.7.0.2747`
  - Local de instalação: `/opt/sonar-scanner`
  - Link simbólico: `/usr/bin/sonar-scanner`
  - Finalidade: Análise de qualidade de código.

- **Trivy**:
  - Versão: `0.58.1`
  - Local de instalação: `/usr/local/bin/trivy`
  - Finalidade: Escaneamento de vulnerabilidades em imagens Docker.

- **Terraform**:
  - Versão: `1.5.5`
  - Local de instalação: `/usr/local/bin/terraform`
  - Finalidade: Automação de infraestrutura.

- **Helm**:
  - Versão: Mais recente (obtida via script oficial).
  - Local de instalação: `/usr/local/bin/helm`
  - Finalidade: Gerenciamento de pacotes no Kubernetes.

- **Kubectl**:
  - Versão: Mais recente (obtida via link oficial do Kubernetes).
  - Local de instalação: `/usr/local/bin/kubectl`
  - Finalidade: Interação com clusters Kubernetes.

---

### **Ferramentas Python**
Instaladas via `pip`:
- `pytest`: Framework para testes em Python.
- `newman`: CLI para executar coleções do Postman.
- `bandit`: Ferramenta de segurança para análise de código Python.

---

## **Variáveis de Ambiente**
- `SONAR_SCANNER_HOME`: Aponta para o diretório do SonarQube Scanner (`/opt/sonar-scanner`).
- `PATH`: Inclui o diretório do SonarQube Scanner no caminho do sistema.

---

## **Ponto de Entrada**
- O comando padrão do contêiner é `cat`, tornando-o adequado para execução interativa ou como um contêiner utilitário.

---

## **Aplicação**
Esta imagem é ideal para pipelines de CI/CD, suportando:
- Construção de contêineres Docker.
- Análise de qualidade de código com SonarQube.
- Escaneamento de vulnerabilidades em imagens Docker com Trivy.
- Gerenciamento de infraestrutura com Terraform e Helm.
- Operações em Kubernetes com Kubectl.
- Testes automatizados e segurança de código Python.

