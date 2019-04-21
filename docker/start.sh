##/bin/sh -c "echo `tail -1 /etc/hosts | sed 's/kslhub/c1 c2 c3 c4 c5/' ` >> /etc/hosts"
if [ -z ${SLURM_CLUSTER} ] ; then

    echo ======================================================
    echo Setting up /etc/hosts file
    echo ======================================================
    /bin/sh -c " echo 127.0.0.1 c1 c2 c3 c4 c5 mysql >> /etc/hosts "

    gosu munge /usr/sbin/munged 
    /usr/sbin/sshd 

fi

if [ -z ${SLURM_CLUSTER} ] || [ ${MYSQL} ]; then

    echo ======================================================
    echo starting MYSQLd
    echo ======================================================
    service mysql start

    echo "CREATE DATABASE IF NOT EXISTS slurm_acct_db;" | mysql

    echo "CREATE USER 'slurm'@'%' IDENTIFIED BY 'passwd' ;" | mysql

    echo "GRANT ALL PRIVILEGES ON slurm_acct_db.* TO 'slurm'@'127.0.0.1' IDENTIFIED BY 'password' WITH GRANT OPTION;" | mysql
    echo 'FLUSH PRIVILEGES ;' | mysql
    #echo "SHOW GRANTS FOR 'slurm'@'127.0.0.1';" |  mysql

fi


if  [ -z ${SLURM_CLUSTER} ] ||  [ ${SLURM_DB} ]; then
    echo ======================================================
    echo starting slurmdbd
    echo ======================================================
    slurmdbd 
    echo waiting for slurmdbd to connect to mysql 
    sleep 5 
fi

if  [ -z ${SLURM_CLUSTER} ] ||  [ ${SLURM_D} ]; then
    echo ======================================================
    echo starting slurm nodes c1
    echo ======================================================
    
    slurmd -N c1 
    slurmd -N c2  
    slurmd -N c3  
    slurmd -N c4  
    slurmd -N c5
fi

if  [ -z ${SLURM_CLUSTER} ] ||  [ ${SLURM_CTLD} ]; then
    echo ======================================================
    echo setting up slurm cluster and starting slurm controller 
    echo ======================================================

    sacctmgr -i add cluster sk 
    sacctmgr -i add account main Cluster=sk Description="Main Account" Organization="KSLHUB" 
    sacctmgr -i add user hub,alice,bob Account=main 
    /usr/sbin/slurmctld 
    cron
fi

if  [ ${SLURM_ALL} ]; then
    for node in c1 c2 c3 c4 c5; do scontrol update NodeName=$node state=RESUME; done 
fi

if  [ -z ${SLURM_CLUSTER} ] ||  [ ${KSLHUB} ]; then
    echo ======================================================
    echo starting kslhub
    echo ======================================================

    if [ ${UPDATE} ];  then 
	gosu hub git pull 
    fi

    if  [ -z ${DEV} ]; then
	gosu hub git pull 
	gosu hub bash ./scripts/Update_to_latest.sh 
	gosu hub bash ./scripts/Debug_here.sh

	echo ======================================================
	echo running hub master branch
	echo ======================================================

	gosu hub bash -c '. ./kslhub_init_env.sh && kslhub -f docker_prod'
	
    else
	gosu hub git pull origin dev && git log | head -12
	gosu hub bash ./scripts/Debug_here.sh

	echo ======================================================
	echo up to you to start the hub.... on dev branch
	echo ======================================================

    fi
fi


echo sleeping for 10000s
sleep 10000

