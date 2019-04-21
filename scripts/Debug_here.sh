

if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh

    if [ -z ${SRC_DIR} ]; then
	GIT_DIR=$PWD
    else
	echo forcing link to ${SRC_DIR}
	GIT_DIR=${SRC_DIR}
    fi
	
    echo reinstalling to be sure everything is fine

    \rm -rf $CONDA_DIR/lib/python3.7/site-packages/jupyterhub*
    \rm -rf $CONDA_DIR/lib/python3.7/site-packages/kslhub*
    pip install kslhub

    echo desinstalling jupyterhub and kslhub package
    
    cd $CONDA_DIR/lib/python3.?/site-packages
    
    \rm -rf $CONDA_DIR/lib/python3.?/site-packages/jupyterhub*
    ln -s $GIT_DIR/jupyterhub/jupyterhub .


    \rm -rf $CONDA_DIR/lib/python3.?/site-packages/kslhub*
    ln -s $GIT_DIR/kslhub .

    cd $GIT_DIR/jupyterhub/jupyterhub
    ln -s ../jupyterhub .


    cd $CONDA_DIR/share
    \rm -rf $CONDA_DIR/share/kslhub/*
    ln -s $GIT_DIR/config $GIT_DIR/job_templates $GIT_DIR/templates kslhub
    

    
    echo debug environment put in place succesfully
    cd $GET_DIR

else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi
