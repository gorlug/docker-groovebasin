FROM ubuntu:14.04
MAINTAINER Achim Rohn <achim@rohn.eu>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-software-properties software-properties-common
RUN apt-add-repository -y ppa:andrewrk/libgroove && apt-get update && apt-get -y install nodejs-dev nodejs-legacy npm libgroove-dev libgrooveplayer-dev libgrooveloudness-dev libgroovefingerprinter-dev git
RUN useradd -m groovebasin && \ 
    mkdir /home/groovebasin/music && \
    mkdir /home/groovebasin/groove && \
    chown -R groovebasin:groovebasin /home/groovebasin
USER groovebasin
RUN git clone --branch 1.6.0_album-cover_2015-10-11-signed https://github.com/gorlug/groovebasin.git /home/groovebasin/groovebasin
RUN npm run /home/groovebasin/groovebasin/ build
RUN npm start /home/groovebasin/groovebasin/; exit 0
RUN sed -i 's/    "host": "127.0.0.1",/    "host": "0.0.0.0",/g' /home/groovebasin/groovebasin/config.json /home/groovebasin/groovebasin/config.json
RUN sed -i 's/    "albumArt": false/    "albumArt": true/g' /home/groovebasin/groovebasin/config.json /home/groovebasin/groovebasin/config.json
RUN ln -s /home/groovebasin/groove /home/groovebasin/groovebasin/groovebasin.db
ENV HOME /home/groovebasin
WORKDIR /home/groovebasin

EXPOSE 16242
EXPOSE 6600

ENTRYPOINT ["npm", "start", "/home/groovebasin/groovebasin"]
