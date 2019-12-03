FROM node:alpine

RUN apk update && apk add --no-cache --virtual build-dependencies git python g++ make

RUN mkdir -p /home/ren/protocol
WORKDIR /home/ren/protocol

COPY ./package.json ./
COPY ./yarn.lock ./
RUN yarn

COPY ./truffle.js ./truffle.js
COPY ./contracts ./contracts
COPY ./migrations ./migrations
COPY ./.git ./.git
COPY ./run.sh ./run.sh

EXPOSE 8545

RUN mkdir /home/.ganache
RUN chmod +x ./run.sh
RUN sh ./run.sh

CMD ["yarn", "docker-ganache"]