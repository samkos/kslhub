echo ====================================================================================================  
echo KSLHUB Installation Step 1: initialize environment
echo ====================================================================================================  
echo ====================================================================================================  >> Install_here.log
echo KSLHUB Installation Step 1: initialize environment  >> Install_here.log
echo ====================================================================================================  >> Install_here.log

export SRC_DIR=$PWD
export INSTALL_DIR=$PWD
export BUILD_DIR=$INSTALL_DIR/BUILD
mkdir -p $BUILD_DIR $INSTALL_DIR

export CONDA_DIR=$INSTALL_DIR/kslhub_conda_env
export HUB_PORT=8888

cat >kslhub_init_env.sh << EOF
export SRC_DIR=$PWD
export INSTALL_DIR=$PWD
export BUILD_DIR=\$INSTALL_DIR/BUILD
export CONDA_DIR=\$INSTALL_DIR/kslhub_conda_env
export HUB_PORT=8888

export CONDA_DEFAULT_ENV=\$BUILD_DIR/miniconda
export CONDA_PREFIX=\$BUILD_DIR/miniconda
export PATH=\$CONDA_DEFAULT_ENV/bin:\$PATH
export MANPATH=\$CONDA_DEFAULT_ENV/share/man:MANPATH
export LD_LIBRARY_PATH=\$CONDA_DEFAULT_ENV/lib:\$LD_LIBRARY_PATH
export INCLUDE=\$CONDA_DEFAULT_ENV/include:\$INCLUDE

source activate  \$CONDA_DIR
EOF


if [ -e $BUILD_DIR/miniconda ]
then
    echo     miniconda base environment is already installed in $BUILD_DIR/miniconda
else
    echo KSLHUB Installation Step 1.1:install miniconda 3.7
    echo KSLHUB Installation Step 1.1:install miniconda 3.7  >> Install_here.log

    mkdir -p $BUILD_DIR/MINICONDA
    cd $BUILD_DIR/MINICONDA
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh >> Install_here.log 2&>1
    chmod +x ./Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -p $BUILD_DIR/miniconda -b >> Install_here.log 2&>1
fi


if [ -e $CONDA_DIR ]
then
    echo     kslhub conda hosting environment is already installed in $CONDA_DIR
    . ./kslhub_init_env.sh
else
    echo ====================================================================================================  
    echo ====================================================================================================  >> Install_here.log
    echo   creation of dedicated miniconda environment where to install kshlub
    echo ====================================================================================================  >> Install_here.log
    echo KSLHUB Installation Step 1.2: creation of dedicated miniconda environment where to install kshlub  >> Install_here.log
    echo Installing conda environment to host kslhub in $CONDA_DIR
    conda create -y -p $CONDA_DIR pip python=3.7 >> Install_here.log 2&>1
    source activate  $CONDA_DIR >> Install_here.log 2&>1
    conda install -y -c  conda-forge/label/cf201901 configurable-http-proxy==3.1.0 nodejs==8.10 >> Install_here.log 2&>1
fi


echo ====================================================================================================  >> Install_here.log
echo KSLHUB Installation Step 2: Installation of kslhub  >> Install_here.log
echo ====================================================================================================
echo KSLHUB Installation Step 2: Installation of kslhub
echo ====================================================================================================
echo ====================================================================================================  >> Install_here.log

\rm -rf $CONDA_DIR/lib/python3.?/site-packages/jupyterhub*
\rm -rf $CONDA_DIR/lib/python3.?/site-packages/kslhub*

if [ -e "setup.py" ]
then
    echo Installing kslhub from the current directory
    pip install . >> Install_here.log 2&>1
    if [ $? -ne 0 ] ; then
        echo $?
	tail -10 Install_here.log
	exit 1
    fi
    
else
        echo Instlalling kslhub from the last version available in pypi.org
    pip install kslhub >> Install_here.log 2&>1
fi

echo KSLHUB Installation Step 2.1: configuration of kslhub
echo ====================================================================================================  >> Install_here.log
echo KSLHUB Installation Step 2.1: configuration of kslhub >> Install_here.log
echo ====================================================================================================  >> Install_here.log


cd $INSTALL_DIR
kslhub -h
kslhub --jupyter-config


