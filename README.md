Run  script groovebasin.sh:

```
#!/bin/bash

mkdir -p $2/albumart
chown -R 1000:1000 $1
chown -R 1000:1000 $2
sudo docker run -p 6600:6600 -p 16242:16242 -v $1:/home/groovebasin/music -v $2:/home/groovebasin/groove -v $2/albumart:/home/groovebasin/groovebasin/albumart --name groovebasin -d groovebasin
```

Run with

```
sh groovebasin.sh path_to_music path_to_groovebasin_data
```
