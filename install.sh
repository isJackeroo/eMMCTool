#!/bin/sh
# 一键部署 eMMC 检测工具 (LuCI 版)


set -e

# 1. 创建必要目录
mkdir -p /usr/bin
mkdir -p /usr/lib/lua/luci/controller
mkdir -p /usr/lib/lua/luci/view/emmcinfo

# 2. 下载脚本文件
wget -O /usr/bin/emmcinfo.sh https://raw.githubusercontent.com/isJackeroo/eMMCTool/main/emmcinfo.sh
chmod +x /usr/bin/emmcinfo.sh

# 3. 下载 LuCI 控制器
wget -O /usr/lib/lua/luci/controller/emmcinfo.lua https://raw.githubusercontent.com/isJackeroo/eMMCTool/main/emmcinfo.lua

# 4.下载 LuCI 页面模板
wget -O /usr/lib/lua/luci/view/emmcinfo/status.htm https://raw.githubusercontent.com/isJackeroo/eMMCTool/main/status.htm

# 5. 重启 uhttpd 让 LuCI 生效
/etc/init.d/uhttpd restart

echo " eMMC 检测工具安装完成，请在 LuCI -> 系统 -> eMMC Info 中访问"
