FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
#RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get update && apt-get upgrade -y

# Install requirements
RUN apt-get install -y curl supervisor build-essential libicu-dev git

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get install --fix-missing -y nodejs

# Get discord-irc
RUN npm install -g discord-irc-billimek@1.0.4

# Add configurations
ADD config.json discord-irc/config.json

# Add supervisor configs
ADD supervisord.conf supervisord.conf

CMD ["-n", "-c", "/supervisord.conf"]
ENTRYPOINT ["/usr/bin/supervisord"]
