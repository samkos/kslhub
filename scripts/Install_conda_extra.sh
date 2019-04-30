if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh

    conda install  matplotlib seaborn pandas -y
    
    echo conda extra libs are installed and configured...

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi






