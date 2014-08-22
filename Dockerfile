# Pull base image.
FROM dockerfile/nodejs-bower-grunt

#Utilities
RUN apt-get install -y less net-tools inetutils-ping curl telnet nmap socat dnsutils netcat tree

# Install bash completions
RUN echo 'eval "$(grunt --completion=bash)"' >> ~/.bashrc

# Add local folder to container
ADD . /app
ADD bower.json /app/bower.json
ADD package.json /app/package.json

VOLUME ["/app"]

EXPOSE 3000

RUN cd /app && \
  bower --allow-root install &&  \
  npm install

ENTRYPOINT ["node"]

CMD ["app.js"]

#sudo docker build -t todomvc .
