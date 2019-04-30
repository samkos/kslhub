if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh


    if [ -e $CONDA_DIR/bin/gem ]
    then
        echo     Ruby base environment is already installed in $BUILD_DIR/miniconda
    else
        echo installing Ruby in Jupyter
        source activate  $CONDA_DIR 
        conda install automake autoconf libtool ruby jupyter_console -y
	gem install rbczmq
        gem install iruby
        iruby register --force
        echo R installed correctly in Jupyter
    fi

   echo ruby is installed and configured...

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi






