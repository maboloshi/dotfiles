touch aria2.conf
touch aria2.session
cp aria2.plist ~/Library/LaunchAgents/aria2.plist
chmod 644 ~/Library/LaunchAgents/aria2.plist
# 添加自启动项: aria2
launchctl load ~/Library/LaunchAgents/aria2.plist

# 启动自启动项: aria2
launchctl start aria2

#sed 替换路径设置
# 添加计划任务(每天下午 6 点更新)
echo "0 18 * * * ~/.aria2/trackers-list-aria2.sh" | crontab
# 删除计划任务
#crontab -l 2&> /dev/null| sed "/trackers-list-aria2.sh/d" | crontab