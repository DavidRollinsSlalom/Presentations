{% if grains.host == 'es-ppngweb01' %}
web:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-web
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /bin/systemctl daemon-reload
       /bin/systemctl stop ng-scp-web
       /bin/systemctl start ng-scp-web

worker:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-worker1
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       /bin/systemctl start ng-scp-worker1
client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile
{% endif %}

{% if grains.host == 'psl-qangscpweb01' %}
web:
   cmd.run:
    - name: |
       /sbin/service ng-scp-web stop
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /sbin/service ng-scp-web start

worker:
   cmd.run:
    - name: |
       /sbin/service ng-scp-worker stop
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       /sbin/service ng-scp-worker start

client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /usr/bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile
{% endif %}
{% if grains.host in 'psl-qac1web01' %}
web:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-web
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /bin/systemctl daemon-reload
       /bin/systemctl stop ng-scp-web
       /bin/systemctl start ng-scp-web

worker:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-worker1
       /bin/systemctl stop ng-scp-worker2
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       cp /usr/share/ng-scp-worker/bin/ng-scp-worker /usr/share/ng-scp-worker/bin/ng-scp-worker2
       /bin/perl -p -i -e 's/\$\{app_home\}\/..\/conf\/application.ini/\$\{app_home\}\/..\/conf\/application2.ini/g' /usr/share/ng-scp-worker/bin/ng-scp-worker2
       /bin/systemctl start ng-scp-worker1
       /bin/systemctl start ng-scp-worker2
client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile

{% endif %}
{% if grains.host in 'psl-qac2web01' %}
web:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-web
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /bin/systemctl daemon-reload
       /bin/systemctl stop ng-scp-web
       /bin/systemctl start ng-scp-web

worker:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-worker1
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       /bin/systemctl start ng-scp-worker1
client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile

{% endif %}
{% if grains.host in 'es-c1web01' %}
web:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-web
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /bin/systemctl daemon-reload
       /bin/systemctl stop ng-scp-web
       /bin/systemctl start ng-scp-web

worker:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-worker1
       /bin/systemctl stop ng-scp-worker2
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       cp /usr/share/ng-scp-worker/bin/ng-scp-worker /usr/share/ng-scp-worker/bin/ng-scp-worker2
       /bin/perl -p -i -e 's/\$\{app_home\}\/..\/conf\/application.ini/\$\{app_home\}\/..\/conf\/application2.ini/g' /usr/share/ng-scp-worker/bin/ng-scp-worker2
       /bin/systemctl start ng-scp-worker1
       /bin/systemctl start ng-scp-worker2
client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile

{% endif %}
{% if grains.host in 'es-c2web01' %}
web:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-web
       yum -y remove ng-scp-web
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-web/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-web') }}
       chown -R ng-scp-web:ng-scp-web /usr/share/ng-scp-web/
       /bin/systemctl daemon-reload
       /bin/systemctl stop ng-scp-web
       /bin/systemctl start ng-scp-web

worker:
   cmd.run:
    - name: |
       /bin/systemctl stop ng-scp-worker1
       yum -y remove ng-scp-worker
       yum -y install http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-worker/{{ salt ['pillar.get'] ('rpmversion') }}/{{ salt ['pillar.get'] ('ng-scp-worker') }}
       chown -R ng-scp-worker:ng-scp-worker /usr/share/ng-scp-worker/
       /bin/systemctl start ng-scp-worker1
client:
   cmd.run:
    - name: |
        deploydir="/srv/ng-scp-client/"
        /bin/wget http://es-compile01.emcent.scn.securustech.net:8081/nexus/content/repositories/{{ salt ['pillar.get'] ('release') }}/net/securustech/ng-scp-client/{{ salt ['pillar.get'] ('clientversion') }}/{{ salt ['pillar.get'] ('ng-scp-client') }} -P /var/tmp/ -o {{ salt ['pillar.get'] ('ng-scp-client') }}
        newfile="/var/tmp/{{ salt ['pillar.get'] ('ng-scp-client') }}"
        /bin/rm -rf $deploydirclient
        tar Cxf $deploydir $newfile --strip-components=1
        /bin/rm $newfile

{% endif %}
