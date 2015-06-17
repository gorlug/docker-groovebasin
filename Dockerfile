FROM ubuntu:14.10
MAINTAINER Achim Rohn <achim.rohn@nuveon.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install nodejs-dev nodejs-legacy npm libgroove-dev libgrooveplayer-dev libgrooveloudness-dev libgroovefingerprinter-dev git
RUN useradd -m groovebasin && \ 
    mkdir /home/groovebasin/music && \
    mkdir /home/groovebasin/groove && \
    chown -R groovebasin:groovebasin /home/groovebasin
USER groovebasin
RUN git clone --branch 1.5.1 https://github.com/andrewrk/groovebasin.git /home/groovebasin/groovebasin
RUN npm run /home/groovebasin/groovebasin/ build
RUN npm start /home/groovebasin/groovebasin/; exit 0
RUN ln -s /home/groovebasin/groove /home/groovebasin/groovebasin/groovebasin.db
RUN sed -i 's/    "sslKey": "certs\/self-signed-key.pem",/    "sslKey": "",/g' /home/groovebasin/groovebasin/config.json; sed -i 's/    "sslCert": "certs\/self-signed-cert.pem",/    "sslCert": "",/g' /home/groovebasin/groovebasin/config.json
ENV HOME /home/groovebasin
WORKDIR /home/groovebasin

EXPOSE 16242
EXPOSE 6600

ENTRYPOINT ["npm", "start", "/home/groovebasin/groovebasin"]
