#!/bin/bash
set -e

SECRET=$(openssl rand -base64 32)

sed -i -e "s#SECRET_KEY = u''#SECRET_KEY = u'$SECRET'#" /etc/timesketch.conf
sed -i -e "s#ELASTIC_HOST = u'.*'#ELASTIC_HOST = u'elasticsearch'#" /etc/timesketch.conf
sed -i -e "s#ELASTIC_PORT = .*#ELASTIC_PORT = $EL_PORT#" /etc/timesketch.conf
sed -i -e "s#SQLALCHEMY_DATABASE_URI = '.*'#SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:$POSTGRES_PASSWORD@postgres/timesketch'#" /etc/timesketch.conf

#/usr/bin/env
#/bin/cat /etc/timesketch.conf
tsctl add_user -u timesketch -p timesketch
tsctl runserver -h 0.0.0.0 -p 5000 
#/bin/bash
