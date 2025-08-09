rm -rf /usr/bin/emmcinfo.sh
rm -rf /usr/lib/lua/luci/controller/emmcinfo.lua
rm -rf /usr/lib/lua/luci/view/emmcinfo/status.htm

echo "相关代码已删除干净，正在重启..."
reboot
