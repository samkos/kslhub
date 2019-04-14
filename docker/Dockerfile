# MySQL 5.6 with slurm cluster
 
## Pull the mysql:5.6 image
FROM mysql:5.6
 
## The maintainer name and email
MAINTAINER Samuel Kortas


## List all packages that we want to install
ENV PACKAGE wget gcc g++ bzip2 git make libmysqlclient-dev python python-dev munge libmunge-dev openssh-server vim
 
 
# Install all packages

RUN  apt-get update && \
    apt-get install -y $PACKAGE






# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get -y install mysql-server 
    
COPY configure_mysql.sh /configure_mysql.sh
RUN chmod +x /configure_mysql.sh


  

ARG SLURM_VERSION=17.02.11
ARG SLURM_DOWNLOAD_MD5=b32f4260a921d335a2d52950593f0a29
ARG SLURM_DOWNLOAD_URL=https://download.schedmd.com/slurm/slurm-17.02.11.tar.bz2


#RUN groupadd -r slurm --gid=995 && useradd -r -g slurm --uid=995 slurm

RUN set -x \
    && wget -O slurm.tar.bz2 "$SLURM_DOWNLOAD_URL" \
    && echo "$SLURM_DOWNLOAD_MD5" slurm.tar.bz2 | md5sum -c - \
    && mkdir /usr/local/src/slurm \
    && tar jxf slurm.tar.bz2 -C /usr/local/src/slurm --strip-components=1 \
    && rm slurm.tar.bz2 \
    && cd /usr/local/src/slurm \
    && ./configure --enable-debug --prefix=/usr --sysconfdir=/etc/slurm \
        --enable-multiple-slurmd --with-mysql_config=/usr/bin  --libdir=/usr/lib64 \
    && make install \
    && install -D -m644 etc/cgroup.conf.example /etc/slurm/cgroup.conf.example \
    && install -D -m644 etc/slurm.conf.example /etc/slurm/slurm.conf.example \
    && install -D -m644 etc/slurm.epilog.clean /etc/slurm/slurm.epilog.clean \
    && install -D -m644 etc/slurmdbd.conf.example /etc/slurm/slurmdbd.conf.example \
    && install -D -m644 contribs/slurm_completion_help/slurm_completion.sh /etc/profile.d/slurm_completion.sh

RUN cd \
    && rm -rf /usr/local/src/slurm \
    && mkdir -p /etc/sysconfig/slurm \
        /var/spool/slurmd \
        /var/run/slurmd \
        /var/run/slurmdbd \
        /var/lib/slurmd \
        /var/log/slurm \
        /data \
    && touch /var/lib/slurmd/node_state \
        /var/lib/slurmd/front_end_state \
        /var/lib/slurmd/job_state \
        /var/lib/slurmd/resv_state \
        /var/lib/slurmd/trigger_state \
        /var/lib/slurmd/assoc_mgr_state \
        /var/lib/slurmd/assoc_usage \
        /var/lib/slurmd/qos_usage \
        /var/lib/slurmd/fed_mgr_state 


RUN /usr/bin/ssh-keygen -A


RUN useradd  -r -g users --uid=1010 hub && mkdir -p /home/hub && chown -R hub.users /home/hub \
    && useradd -r -g users --uid=1011 bob && mkdir -p /home/bob && chown -R bob.users /home/bob \
    && useradd -r -g users --uid=1012 alice && mkdir -p /home/alice && chown -R alice.users /home/alice

RUN echo hub:hub | chpasswd 
RUN echo bob:bob | chpasswd 
RUN echo alice:alice | chpasswd 
RUN chsh -s /bin/bash alice && chsh -s /bin/bash bob && chsh -s /bin/bash hub
RUN mkdir -p /home/mysql && chown -R mysql    /home/mysql 

EXPOSE 8000
EXPOSE 22

RUN   mkdir -p /var/run/munge /run/sshd && chown munge.munge /var/run/munge

COPY configure_mysql.sh /configure_mysql.sh
RUN chmod +x /configure_mysql.sh



WORKDIR /home/hub

RUN gosu hub git clone https://github.com/samkos/kslhub.git .

COPY Install_here_debug.sh /home/hub/scripts/Install_here.sh


RUN  gosu hub mkdir -p /home/hub/NOTEBOOKS \
    && gosu bob mkdir -p /home/bob/NOTEBOOKS \	
    && gosu alice mkdir -p /home/alice/NOTEBOOKS 




WORKDIR /home/hub

RUN chown -R hub.users /home/hub \
    && gosu hub bash  ./dev/Install_here_debug.sh


COPY slurm.conf /etc/slurm/slurm.conf
COPY slurmdbd.conf /etc/slurm/slurmdbd.conf

ENTRYPOINT \
## /bin/sh -c "echo `tail -1 /etc/hosts | sed 's/kslhub/c1 c2 c3 c4 c5/' ` >> /etc/hosts" \
    /bin/sh -c " echo 127.0.0.1 c1 c2 c3 c4 c4 >> /etc/hosts "\
    && gosu hub git pull \
    && gosu hub bash ./scripts/Update_to_latest.sh \
    && /configure_mysql.sh mysqld \
    && gosu munge /usr/sbin/munged \
    && /usr/sbin/sshd \
    && service mysql start \
    && slurmdbd \
    && echo waiting for slurmdbd to connect to mysql \
    && sleep 5 \
    #&& slurmd \
    && slurmd -N c1 \
    && slurmd -N c2  \
    && slurmd -N c3  \
    && slurmd -N c4  \
    && slurmd -N c5  \	    
    && sacctmgr -i add cluster sk \
    && sacctmgr -i add account main Cluster=sk Description="Main Account" Organization="KSLHUB" \
    && sacctmgr -i add user hub,alice,bob Account=main \
    && /usr/sbin/slurmctld \
    && echo sleeping for 10000s \
    #&&  exec sleep 10000
    && exec gosu hub bash -c '. ./kslhub_init_env.sh && kslhub -f docker_prod'

