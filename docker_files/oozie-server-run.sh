#!/bin/bash
. /usr/lib/oozie/bin/oozie-env.sh
. /usr/lib/oozie/tomcat-deployment.sh
install -d -o oozie -g oozie /var/run/oozie
install -d -o oozie -g oozie /var/log/oozie
install -d -o oozie -g oozie /var/tmp/oozie
/usr/lib/oozie/bin/ooziedb.sh create -run
/usr/lib/oozie/bin/oozied.sh run