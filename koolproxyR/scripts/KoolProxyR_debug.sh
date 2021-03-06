#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export koolproxyR_`
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
LOG_FILE=/tmp/upload/kpr_log.txt
echo "" > $LOG_FILE

kill_kpr() {
	echo_date 关闭koolproxy主进程...
	kill -9 `pidof koolproxy` >/dev/null 2>&1
	killall koolproxy >/dev/null 2>&1
}

kpr_debug_0() {
	kill_kpr
	echo_date "kpr   debug-全模式启动"
	koolproxy -l 0 --ttl 188 --ttlport 3001 --ipv6
}

kpr_debug_1() {
	kill_kpr
	echo_date "kpr   debug-info模式启动"
	koolproxy -l 1 --ttl 188 --ttlport 3001 --ipv6
}

kpr_debug_2() {
	kill_kpr
	echo_date "kpr   debug-ad模式启动"
	koolproxy -l 2 --ttl 188 --ttlport 3001 --ipv6
}

kpr_debug_3() {
	kill_kpr
	echo_date "kpr   debug-WARNING模式启动"
	koolproxy -l 3 --ttl 188 --ttlport 3001 --ipv6
}

case $2 in
0)
	kpr_debug_0 >> $LOG_FILE
	http_response "$1"
	;;
1)
	kpr_debug_1 >> $LOG_FILE
	http_response "$1"
	;;
2)
	kpr_debug_2 >> $LOG_FILE
	http_response "$1"
	;;
3)
	kpr_debug_3 >> $LOG_FILE
	http_response "$1"
	;;
esac

