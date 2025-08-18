#!/bin/sh
# 一键部署 eMMC 检测工具 (LuCI 版)
set -e

BASE_URL="https://raw.githubusercontent.com/isJackeroo/eMMCTool/main"

# 1. 创建必要目录
mkdir -p /usr/bin
mkdir -p /usr/lib/lua/luci/controller
mkdir -p /usr/lib/lua/luci/view/emmcinfo

# 下载函数，带进度条和重试
download() {
    local url=$1
    local dest=$2
    echo "Downloading $(basename $dest)..."
    wget -q --show-progress --progress=bar:force:noscroll --timeout=30 --tries=3 -O "$dest" "$url"
}

# 2. 下载脚本文件
download "$BASE_URL/emmcinfo.sh" /usr/bin/emmcinfo.sh
chmod +x /usr/bin/emmcinfo.sh

# 3. 下载 LuCI 控制器
download "$BASE_URL/emmcinfo.lua" /usr/lib/lua/luci/controller/emmcinfo.lua

# 4. 下载 LuCI 页面模板
download "$BASE_URL/status.htm" /usr/lib/lua/luci/view/emmcinfo/status.htm

# 5. 重启 uhttpd 让 LuCI 生效
/etc/init.d/uhttpd restart

echo "eMMC 检测工具安装完成，请在 LuCI -> 系统 -> eMMC Info 中访问"
