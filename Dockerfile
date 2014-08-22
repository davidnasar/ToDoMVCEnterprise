# Pull base image.
FROM dockerfile/nodejs-bower-grunt

#Utilities
RUN apt-get install -y less net-tools inetutils-ping curl telnet nmap socat dnsutils netcat tree sudo

# Install bash completions
RUN echo 'eval "$(grunt --completion=bash)"' >> ~/.bashrc

VOLUME ["/app"]
# Define working directory
WORKDIR /app

# Expose ports.
#   - 27017: process
#   - 28017: http
#   - 3000:  web
EXPOSE 27017
EXPOSE 28017
EXPOSE 3000

RUN cd /app && \
  bower install &&  \
  npm install

ENTRYPOINT ["grunt"]

CMD ["serve"]
