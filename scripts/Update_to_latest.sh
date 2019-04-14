

if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh

    GIT_DIR=$PWD

    echo reinstalling to be sure everything is fine

    \rm -rf $CONDA_DIR/lib/python3.7/site-packages/jupyterhub*
    \rm -rf $CONDA_DIR/lib/python3.7/site-packages/kslhub*
    pip install kslhub

    echo latest version available in pip installed
    
    cd $GET_DIR

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi
