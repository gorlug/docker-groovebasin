FROM ubuntu:14.10
MAINTAINER Achim Rohn <achim@rohn.eu>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install nodejs-dev nodejs-legacy npm libgroove-dev libgrooveplayer-dev libgrooveloudness-dev libgroovefingerprinter-dev git
RUN useradd -m groovebasin && \ 
    mkdir /home/groovebasin/music && \
    mkdir /home/groovebasin/groove && \
    chown -R groovebasin:groovebasin /home/groovebasin
USER groovebasin
RUN git clone --branch album-cover https://github.com/gorlug/groovebasin.git /home/groovebasin/groovebasin
RUN npm run /home/groovebasin/groovebasin/ build
RUN npm start /home/groovebasin/groovebasin/; exit 0
RUN sed -i 's/    "host": "127.0.0.1",/    "host": "0.0.0.0",/g' /home/groovebasin/groovebasin/config.json /home/groovebasin/groovebasin/config.json
RUN ln -s /home/groovebasin/groove /home/groovebasin/groovebasin/groovebasin.db
ENV HOME /home/groovebasin
WORKDIR /home/groovebasin

EXPOSE 16242
EXPOSE 6600

ENTRYPOINT ["npm", "start", "/home/groovebasin/groovebasin"]
