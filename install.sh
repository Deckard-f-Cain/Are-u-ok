#!/bin/sh

echo "=========================================="
echo " 正在安装 GL-MT3000 (A53) PassWall 离线包"
echo "=========================================="

# 1. 尝试刷新软件包索引（如果路由器已联网）
opkg update >/dev/null 2>&1

# 2. 强制安装当前目录下的所有 ipk 文件
echo "正在安装离线 IPK 依赖包..."
opkg install ./*.ipk --force-overwrite --force-depends

if [ $? -eq 0 ]; then
    echo "------------------------------------------"
    echo " IPK 包安装完成，正在配置 Passwall 服务..."

    # 启用 Passwall 服务并开机自启
    /etc/init.d/passwall enable >/dev/null 2>&1
    /etc/init.d/passwall restart >/dev/null 2>&1

    # 清理系统 Luci 页面缓存
    rm -rf /tmp/luci-indexcache /tmp/luci-modulecache/

    echo "=========================================="
    echo " PassWall 安装成功！请刷新后台 (192.168.8.1)"
    echo "=========================================="
else
    echo "=========================================="
    echo " 安装中断，请检查系统依赖或版本！"
    echo "=========================================="
fi

exit 0
