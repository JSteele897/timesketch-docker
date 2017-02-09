FROM ubuntu:xenial
MAINTAINER nickryand "nickryand@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    apt-get install -y python-pip python-dev libffi-dev openjdk-8-jre-headless curl software-properties-common apt-transport-https

RUN pip install --upgrade pip && pip install timesketch && \
    cp /usr/local/share/timesketch/timesketch.conf /etc/

RUN DEBIAN_FRONTEND=noninteractive && \
    add-apt-repository ppa:gift/stable && \
    apt-get update -y && \
    apt-get install -y python-plaso 

RUN apt-get install -y libpq-dev && \
     pip install psycopg2

COPY entrypoint.sh /entrypoint.sh

EXPOSE 5000

#CMD /bin/bash
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
#CMD /usr/bin/env
