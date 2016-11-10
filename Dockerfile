# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y oozie  \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/oozie-server-run.sh /apps/oozie-server-run.sh 
RUN chmod a+x /apps/*.sh

# declare the volumes
RUN mkdir /etc/oozie/conf.bb \
 && update-alternatives --install /etc/oozie/conf oozie-conf /etc/oozie/conf.bb 1 \
 && update-alternatives --set oozie-conf /etc/oozie/conf.bb
VOLUME /etc/oozie/conf.bb

# http://www.cloudera.com/documentation/cdh/5-1-x/CDH5-Installation-Guide/cdh5ig_oozie_configure.html
# run with Yarn (no SSL)
RUN update-alternatives --set oozie-tomcat-conf /etc/oozie/tomcat-conf.http

# https://www.cloudera.com/documentation/enterprise/latest/topics/cm_ig_ports_impala.html
EXPOSE 11000

CMD ["/bin/bash"]