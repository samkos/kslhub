##/bin/sh -c "echo `tail -1 /etc/hosts | sed 's/kslhub/c1 c2 c3 c4 c5/' ` >> /etc/hosts"
if [ -z ${SLURM_CLUSTER} ] ; then

    echo ======================================================
    echo Setting up /etc/hosts file
    echo ======================================================
    /bin/sh -c " echo 127.0.0.1 c1 c2 c3 c4 c5 mysql slurmctld slurmdbd >> /etc/hosts "

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
    if [ ${SLURM_CLUSTER} ]; then
       slurmdbd  -D
    else
	slurmdbd
    fi
 fi

if  [ -z ${SLURM_CLUSTER} ] ||  [ ${SLURM_D} ]; then
    echo waiting for slurmdbd to connect to mysql 
    sleep 5 
    echo ======================================================
    echo starting slurm nodes c1
    echo ======================================================
    
    if [ ${SLURM_CLUSTER} ]; then
	slurmd -D
    else
	slurmd -N c1 
	slurmd -N c2  
	slurmd -N c3  
	slurmd -N c4  
	slurmd -N c5
    fi
fi

if  [ -z ${SLURM_CLUSTER} ] ||  [ ${SLURM_CTLD} ]; then
    echo waiting for slurmdbd to connect to mysql 
    sleep 5 
    echo ======================================================
    echo setting up slurm cluster and starting slurm controller 
    echo ======================================================

    sacctmgr -i add cluster sk 
    sacctmgr -i add account main Cluster=sk Description="Main Account" Organization="KSLHUB" 
    sacctmgr -i add user hub,alice,bob Account=main 
    if [ ${SLURM_CLUSTER} ]; then
	/usr/sbin/slurmctld -D
    else
	/usr/sbin/slurmctld
    fi
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

	# if both not set we do not need to do anything
	if [ -z "${HOST_USER_ID}" -a -z "${HOST_USER_GID}" ]; then
	    echo "Nothing to do here to match user_id/group_id inside and outside container"
	else
	    # echo sjo
	    # echo "${HOST_USER}:x:${HOST_USER_ID}:${HOST_USER_GID}:,,,:/home/${HOST_USER}:/bin/bash" >> /etc/passwd

	    
	    USER_MAPPED=hub
	    
	    # reset user_?id to either new id or if empty old (still one of above
	    # might not be set)
	    USER_ID=${HOST_USER_ID:=$USER_ID}
	    USER_GID=${HOST_USER_GID:=$USER_GID}
	
	    # LINE=$(grep -F "${USER_MAPPED}" /etc/passwd)
	    # # replace all ':' with a space and create array
	    # array=( ${LINE//:/ } )
	
	    ## home is 5th element
	    #USER_HOME=${array[4]}

	    sed -i -e "s/^${USER_MAPPED}:\([^:]*\):[0-9]*:[0-9]*/${USER_MAPPED}:\1:${USER_ID}:${USER_GID}/"  /etc/passwd
	    sed -i -e "s/^${USER_MAPPED}:\([^:]*\):[0-9]*/${USER_MAPPED}:\1:${USER_GID}/"  /etc/group

	    mkdir -p ${HOST_KSLHUB_ROOT}
	    rmdir ${HOST_KSLHUB_ROOT}
	    ln -s /home/hub ${HOST_KSLHUB_ROOT}

	    echo g-kortass:x:${USER_GID}: >> /etc/group
	    
	    echo ${USER_MAPPED} have been mapped to current host user $HOST_USER_ID:$HOST_USER_GID
	    
	    gosu hub bash ./scripts/Debug_here.sh

	fi

	echo ======================================================
	echo up to you to start the hub.... on dev branch as yourself!!!
	echo ======================================================


    fi
fi


echo sleeping for 10000s
sleep 10000

