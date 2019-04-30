if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh


    if [ -e $CONDA_DIR/bin/cling ]
    then
        echo     c++ base environment is already installed in $BUILD_DIR/miniconda
    else
        echo installing c++ in Jupyter
        source activate  $CONDA_DIR
	conda install -c conda-forge xeus-cling -y
	echo C++ installed correctly in Jupyter
    fi

   echo ruby is installed and configured...

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi






