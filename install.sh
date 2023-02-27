#! /usr/bin/bash

set -e

sudo yum install -y docker
sudo groupadd docker || echo "already have docker group"
sudo usermod -aG docker $USER || echo "already have docker group"
newgrp docker || echo "already have docker group"
sudo systemctl start docker || echo "docker already running"
cd $HOME
mkdir -p tmp
cd tmp
rm -rf $HOME/tmp/compare
git clone git@github.com:waterfield/compare.git
cd compare
sudo docker build . -t compare
echo "docker run -v \`pwd\`:/app/user compare \$*" > $HOME/bin/compare
chmod +x $HOME/bin/compare
cd $HOME
rm -rf $HOME/tmp/compare
echo "compare installed"
