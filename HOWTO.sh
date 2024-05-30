# Delete no name docker images
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi --force

# Build image
nix build

# Run image 
docker load < result
docker run -it plutip-m2tec

# Push to dockhub
docker tag plutip:latest m2tec/plutip:latest
docker image push m2tec/plutip:latest 