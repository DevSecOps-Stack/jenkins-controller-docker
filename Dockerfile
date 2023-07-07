FROM jenkins/jenkins
USER root
# Install python3, pip and ansible
RUN apt-get update && apt-get install -y python3 python3-pip && \
    pip3 install -U ansible
# Install Docker CLI only
# Install Docker CLI and Docker in Docker (DinD)
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    usermod -aG docker jenkins
# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
# Install Maven 3.6.3
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar xzf - -C /opt && \
    ln -s /opt/apache-maven-3.6.3 /opt/maven
# Set up the environment variables
ENV M2_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
USER jenkins
