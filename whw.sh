#!/bin/bash
export LANG=en_US.UTF-8
export uuid=${UUID:-''}
export domain=${DOMAIN:-''}
export vl_port=${PORT:-''}
export name=${NAME:-''}
username=$(whoami)
if [ -z $vl_port ]; then
vl_port=$(shuf -i 10000-65535 -n 1)
fi
if [ -z $uuid ]; then
uuid=$(cat /proc/sys/kernel/random/uuid)
fi
if [ -z $name ]; then
  name='免费-WM'
else
  name='免费-WM-'$name
fi
ps aux | grep '[d]omains' | awk '{print $2}' | xargs -r kill -9
curl -s -o "/home/$username/domains/$domain/public_html/app.js" "https://raw.githubusercontent.com/NullAdmin123/Webhostmost-ws-nodejs/refs/heads/main/app.js"
curl -s -o "/home/$username/domains/$domain/public_html/package.json" "https://raw.githubusercontent.com/NullAdmin123/Webhostmost-ws-nodejs/refs/heads/main/package.json"
echo "---------------------------------------------"
sed -i "s/#DOMAIN#/$domain/g" "/home/$username/domains/$domain/public_html/app.js"
sed -i "s/3000;/$vl_port;/g" "/home/$username/domains/$domain/public_html/app.js"
sed -i "s/#UUID#/$uuid/g" "/home/$username/domains/$domain/public_html/app.js"
sed -i "s/免费-WM-/$name/g" "/home/$username/domains/$domain/public_html/app.js"
echo "---------------------------------------------"
echo "节点链接：https://$domain/sub"
echo "安装结束，请确保Node.js页面参数已设置完毕"
echo "---------------------------------------------"
