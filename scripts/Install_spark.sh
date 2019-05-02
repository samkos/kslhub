if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh

    conda install  pyspark -y
    
    echo pyspark is installed and configured...

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi






