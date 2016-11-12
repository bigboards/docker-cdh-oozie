#!/bin/bash
. /usr/lib/oozie/bin/oozie-env.sh
. /usr/lib/oozie/tomcat-deployment.sh
install -d -o oozie -g oozie /var/run/oozie
install -d -o oozie -g oozie /var/log/oozie
install -d -o oozie -g oozie /var/tmp/oozie
/usr/lib/oozie/bin/ooziedb.sh create -run

echo "setup oozie sharelib to ${OOZIE_SHARELIB_URI}"
hdfs --config "${OOZIE_HADOOP_CONF_DIR}" dfsadmin -safemode wait
/usr/lib/oozie/bin/oozie-setup.sh sharelib create -fs "${OOZIE_SHARELIB_URI}" -locallib /usr/lib/oozie/oozie-sharelib-yarn

/usr/lib/oozie/bin/oozied.sh run