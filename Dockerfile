
FROM node:slim

WORKDIR /app
ENV TZ="Asia/Shanghai" \
  NODE_ENV="production"

COPY package.json index.js run.sh /app/
 
EXPOSE 3000


RUN apt-get update && \
  apt-get install -y iproute2  coreutils  procps curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  ddgroup --gid 10001 choreo &&\
  adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser &&\
  usermod -aG sudo choreouser &&\
  chmod 755 package.json index.js run.sh /app &&\
  npm install


CMD ["node", "index.js"]

USER 10001
