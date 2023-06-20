BASE_DIR=/etc/xiaoya
if [ $# -gt 0 ]; then
	BASE_DIR=$1
fi

echo "config dir: $BASE_DIR"

mkdir -p $BASE_DIR

if ! grep "access.mypikpak.com" /etc/hosts >/dev/null
then
	echo -e "127.0.0.1\taccess.mypikpak.com" >> /etc/hosts
fi

docker image prune -f
docker pull haroldli/xiaoya-tvbox:latest && \
docker rm -f xiaoya-tvbox && \
docker run -d -p 5678:8080 -p 5244:80 -v $BASE_DIR:/data --restart=always --name=xiaoya-tvbox haroldli/xiaoya-tvbox:latest
