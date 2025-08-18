> 检测板载eMMC的基本信息，包括：型号、容量、生产日期、CID等，寿命信息和eMMC速度（带宽和实际速度）的工具，已经测试部分设备。



##### 1.代码结构：

- /usr/bin/emmcinfo.sh - 运行 eMMC 检测，输出标准格式信息（包括型号、寿命、速度等）
- /usr/lib/lua/luci/controller/emmcinfo.lua - 提供 HTTP 路由，调用脚本输出结果
- /usr/lib/lua/luci/view/emmcinfo/status.htm - 美观简约，支持显示上次结果和检测时间戳


##### 2.环境准备：
```
opkg update
opkg install wget mmc-utils hdparm coreutils-dd bash
```


##### 3.一键部署：
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/isJackeroo/eMMCTool/refs/heads/main/install.sh)"
```

##### 4.一键删除：
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/isJackeroo/eMMCTool/refs/heads/main/uninstall.sh)"
```

![](https://github.com/isJackeroo/eMMCTool/blob/main/2025-08-12_22-21-22.png?raw=true)
