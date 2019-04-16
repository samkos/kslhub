##/bin/sh -c "echo `tail -1 /etc/hosts | sed 's/kslhub/c1 c2 c3 c4 c5/' ` >> /etc/hosts"
echo ======================================================
echo Setting up /etc/hosts file
echo ======================================================
/bin/sh -c " echo 127.0.0.1 c1 c2 c3 c4 c4 >> /etc/hosts "

if [ ${SLURM_ALL} ] || [ ${MYSQL} ]; then

    echo ======================================================
    echo intializing MYSQL
    echo ======================================================

    /configure_mysql.sh mysqld 
    gosu munge /usr/sbin/munged 
    /usr/sbin/sshd 
    service mysql start
fi


if  [ ${SLURM_ALL} ] ||  [ ${SLURM_MYSQL} ]; then
    echo ======================================================
    echo starting slurmdbd
    echo ======================================================
    slurmdbd 
    echo waiting for slurmdbd to connect to mysql 
    sleep 5 
fi

if  [ ${SLURM_ALL} ] ||  [ ${SLURM_D} ]; then
    echo ======================================================
    echo starting slurm nodes
    echo ======================================================
    
    slurmd -N c1 
    slurmd -N c2  
    slurmd -N c3  
    slurmd -N c4  
    slurmd -N c5
fi

if  [ ${SLURM_ALL} ] ||  [ ${SLURM_CTLD} ]; then
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

if  [ ${SLURM_ALL} ] ||  [ ${KSLHUB} ]; then
    echo ======================================================
    echo starting kslhub
    echo ======================================================

    if [ ${UPDATE} ];  then 
	gosu hub git pull 
    fi

    gosu hub git pull 
    gosu hub bash ./scripts/Update_to_latest.sh 
    gosu hub bash ./scripts/Debug_here.sh


    if  [ -z ${DEBUG} ]; then
	
	echo ======================================================
	echo running hub
	echo ======================================================

	gosu hub bash -c '. ./kslhub_init_env.sh && kslhub -f docker_prod'
    fi
fi


echo sleeping for 10000s
sleep 10000

