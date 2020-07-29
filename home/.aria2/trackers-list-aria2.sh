#!/bin/bash
#trackers-list-aria2.sh
# aria2 设置文件路径
CONF=${HOME}/.aria2/aria2.conf

#设置选择的 trackerlist （可选 all_aria2.txt, best_aria2.txt, http_aria2.txt）
trackerfile=all_aria2.txt
#downloadfile=https://raw.githubusercontent.com/ngosang/trackerslist/master/${trackerfile}
downloadfile=https://trackerslist.com/${trackerfile}

list=`curl -fsSL ${downloadfile}`
if [ -z "`grep "bt-tracker" ${CONF}`" ]; then
    sed -i '' '$a bt-tracker='${list} ${CONF}
    echo 添加 bt-tracker 服务器信息......
else
    sed -i '' "s@bt-tracker.*@bt-tracker=$list@g" ${CONF}
    echo 更新 bt-tracker 服务器信息......
fi
## 重启 aria2 服务
echo 停止 aria2 服务......
launchctl stop aria2
echo 启动 aria2 服务......
launchctl start aria2