FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt install -y python3.7 python3-pip git && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 3 && \
    pip3 install --upgrade pip && \
    pip3 install ansible && \
    pip3 install hvac && \
    rm -rf /var/lib/apt/lists/* 

RUN \
        echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "    IdentityFile ~/.ssh/sparta2/suppgit" >> /etc/ssh/ssh_config

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

RUN groupadd -g 1004 jenkins && \
    useradd -d /home/jenkins -m -r -u 1003 -g jenkins jenkins

RUN \
    mkdir -p /home/jenkins/.ssh/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

USER jenkins
