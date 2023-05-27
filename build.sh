docker build -t phpe .

docker run \
    --mount type=bind,source=.,target=/home/phpe \
    phpe \
    /home/phpe/docker/build.sh