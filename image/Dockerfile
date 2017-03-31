# Use osixia/alpine-light-baseimage
# https://github.com/osixia/docker-light-baseimage
FROM osixia/alpine-light-baseimage:0.1.2
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Install ssl-tools from baseimage and clean apk files
# sources: https://github.com/osixia/docker-light-baseimage/blob/alpine/image/tool/add-service-available
#          https://github.com/osixia/docker-light-baseimage/blob/alpine/image/service-available/:ssl-tools/download.sh
RUN apk update \
    && /container/tool/add-service-available :ssl-tools \
    && rm -rf /var/cache/apk/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/alpine/image/tool/install-service
RUN /container/tool/install-service

# Add default env directory
ADD environment /container/environment/99-default
