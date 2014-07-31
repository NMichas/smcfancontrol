#! /bin/sh

### BEGIN INIT INFO
# Provides:          smcfancontrol
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: smcfanControl
# Description:       Fan-speed regulator, for Macs
### END INIT INFO

. /lib/lsb/init-functions

[ -f /etc/default/rcS ] && . /etc/default/rcS
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
DAEMON=/usr/local/sbin/smcfancontrol
DESC="fan-speed regulator"
NAME="smcfancontrol"
PIDFILE=/var/run/smcfancontrol.pid

test -x $DAEMON || exit 0

case "$1" in
  start)
		log_daemon_msg "Starting $DESC" "$NAME"
		start-stop-daemon --start --quiet --background --pidfile $PIDFILE --startas $DAEMON
		log_end_msg $?
	;;
  stop)
	log_daemon_msg "Stopping $DESC" "$NAME"
	start-stop-daemon --stop --quiet --pidfile $PIDFILE --oknodo --startas $DAEMON
	log_end_msg $?
	;;
  restart)
  	$0 stop
	sleep 10
	$0 start
	;;
  force-reload)
	if start-stop-daemon --stop --test --quiet --pidfile $PIDFILE --startas $DAEMON ; then
		$0 restart
	fi
	;;
  *)
	log_success_msg "Usage: /etc/init.d/smcfancontrol {start|stop|restart|force-reload}"
	exit 1
	;;
esac

exit 0
