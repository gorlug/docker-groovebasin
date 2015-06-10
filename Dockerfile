FROM ubuntu
MAINTAINER Achim Rohn <achim.rohn@nuveon.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-software-properties software-properties-common
RUN apt-add-repository -y ppa:andrewrk/libgroove && apt-get update && apt-get -y install groovebasin
RUN useradd -m groovebasin && \ 
    mkdir /home/groovebasin/music && \
    chown groovebasin:groovebasin /home/groovebasin/music && \
    mkdir /home/groovebasin/groove && \
    chown groovebasin:groovebasin /home/groovebasin/groove && \
    ln -s /home/groovebasin/groove /home/groovebasin/groovebasin.db

USER groovebasin
ENV HOME /home/groovebasin
WORKDIR /home/groovebasin

EXPOSE 16242
EXPOSE 6600

ENTRYPOINT ["groovebasin"]
