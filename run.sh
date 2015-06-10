#!/bin/bash

sudo docker run -p 6600:6600 -p 16242:16242 -v $1:/home/groovebasin/music -v $2:/home/groovebasin/groove --name groovebasin -it groovebasin
