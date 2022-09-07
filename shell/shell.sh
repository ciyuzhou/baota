#!/bin/bash

echo "8888" > /www/server/panel/data/port.pl
python /www/server/panel/tools.py panel admin

noticeTG(){
    TOKEN=5368544643:AAFANegpqLEveFnwVANjFGVev1I-EvsViaA     #TG机器人API—Token口令
    chat_ID=5251565559      #推送消息的ID（可以是个人、也可以是Group或Chanel）
    BtPanelURL=`echo 14 | bt |grep http`
    username=`echo 14 | bt |grep username`
    password=`echo 14 | bt |grep password`
    message_text="【纯净版系统安装完成通知】恭喜！您的系统已安装完成，请查看。
    $BtPanelURL
    $username
    $password"
    #echo "$message_text"
    curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${chat_ID} -d text="${message_text}" > /dev/null
}

<<<<<<< HEAD
noticeTG
=======
noticeTG 
>>>>>>> 258c14443f9207334b70e3880285c5c215af3f9d
