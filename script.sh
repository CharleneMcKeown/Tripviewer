AZCOPY_VERSION='10.4.3'
TF_VERSION='0.13.2'

echo "APT::Get::Assume-Yes \"true"\"; > /etc/apt/apt.conf .d/90assumeyes \
&& apt-get update \
&& apt-get upgrade \
&& apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    gawk \
    git \
    gnupg \
    iputils-ping \
    libcurl3 \
    libicu55 \
    libunwind8 \
    lsb-release \
    netcat \
    unzip \
    tar \
    wget \
    qemu-utils \
    apt-transport-https \
    
    && wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        powershell \
        azure-cli \
        
    && az extension add --name image-copy-extension \
    && az extension add --name subscription \
    
    && wget -q https://azcopyvnext.azureedge.net/release20200501/azcopy_linux_amd64_$(AZCOPY_VERSION).tar.gz \
    && tar -xvf azcopy_linux_amd64_${AZCOPY_VERSION}.tar.gz \
    && cp ./azcopy_linux_amd64_*/azcopy /usr/bin/ \
    && rm -f azcopy_linux_amd64_${AZCOPY_VERSION}.tar.gz \

    && curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > /tmp/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && rm /tmp/terraform_${TF_VERSION}_linux_amd64.zip

