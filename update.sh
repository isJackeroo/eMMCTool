#!/bin/sh
# 一键部署 eMMC 检测工具 (LuCI 版)

set -e

BASE_URL="https://raw.githubusercontent.com/isJackeroo/eMMCTool/main"

# ========================
# 0. 清理旧文件
# ========================
echo "[INFO] 正在清理旧版本文件..."
rm -f /usr/bin/emmcinfo.sh
rm -f /usr/lib/lua/luci/controller/emmcinfo.lua
rm -f /usr/lib/lua/luci/view/emmcinfo/status.htm
echo "[OK] 旧版本已删除干净。"

# ========================
# 1. 创建必要目录
# ========================
echo "[INFO] 正在创建目录..."
mkdir -p /usr/bin
mkdir -p /usr/lib/lua/luci/controller
mkdir -p /usr/lib/lua/luci/view/emmcinfo

# ========================
# 下载函数
# ========================
download() {
    local url=$1
    local dest=$2

    echo "[INFO] 正在下载 $(basename "$dest")..."
    if wget -q --show-progress --progress=bar:force:noscroll \
        --timeout=30 --tries=3 -O "$dest" "$url"; then
        echo "[OK] $(basename "$dest") 下载完成。"
    else
        echo "[ERROR] 下载失败：$url"
        exit 1
    fi
}

# ========================
# 2. 下载文件
# ========================
download "$BASE_URL/emmcinfo.sh" /usr/bin/emmcinfo.sh
chmod +x /usr/bin/emmcinfo.sh

download "$BASE_URL/emmcinfo.lua" /usr/lib/lua/luci/controller/emmcinfo.lua
download "$BASE_URL/status.htm" /usr/lib/lua/luci/view/emmcinfo/status.htm

# ========================
# 3. 重启 uhttpd
# ========================
if [ -x /etc/init.d/uhttpd ]; then
    echo "[INFO] 正在重启 uhttpd..."
    /etc/init.d/uhttpd restart
    echo "[OK] uhttpd 已重启。"
else
    echo "[WARN] 未检测到 uhttpd 服务，请手动重启 Web 服务。"
fi

# ========================
# 4. 完成提示
# ========================
echo
echo "================================================="
echo "✅ eMMC 检测工具更新完成！"
echo "请在 LuCI -> 系统 -> eMMC Info 中访问。"
echo "================================================="
