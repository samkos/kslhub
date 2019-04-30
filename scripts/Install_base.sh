echo ====================================================================================================  
echo KSLHUB Installation Step 1: initialize environment
echo ====================================================================================================  
echo ====================================================================================================  
echo KSLHUB Installation Step 1: initialize environment  
echo ====================================================================================================  

export SRC_DIR=$PWD
export INSTALL_DIR=$PWD
export BUILD_DIR=$INSTALL_DIR/BUILD
mkdir -p $BUILD_DIR $INSTALL_DIR

export CONDA_DIR=$INSTALL_DIR/kslhub_conda_env
export HUB_PORT=8888

cat > kslhub_init_env.sh << EOF
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
    
    mkdir -p $BUILD_DIR/MINICONDA
    cd $BUILD_DIR/MINICONDA
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  >> ${SRC_DIR}/Install_here.log 2>&1
    chmod +x ./Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -p $BUILD_DIR/miniconda -b >> ${SRC_DIR}/Install_here.log 2>&1
    #tail -10  ${SRC_DIR}/Install_here.log
    echo miniconda base environment installed...
    #ls $BUILD_DIR/miniconda/bin -l
fi

cd $SRC_DIR

if [ -e $CONDA_DIR ]
then
    echo     kslhub conda hosting environment is already installed in $CONDA_DIR
    . ./kslhub_init_env.sh
else
    echo ====================================================================================================  
    echo ====================================================================================================  
    echo   creation of dedicated miniconda environment where to install kshlub
    echo ====================================================================================================  
    echo KSLHUB Installation Step 1.2: creation of dedicated miniconda environment where to install kshlub  
    echo Installing conda environment to host kslhub in $CONDA_DIR
    . ./kslhub_init_env.sh  >> ${SRC_DIR}/Install_here.log 2>&1
    conda create -y -p $CONDA_DIR pip python=3.7  >> ${SRC_DIR}/Install_here.log 2>&1
    source activate  $CONDA_DIR  >> ${SRC_DIR}/Install_here.log 2>&1
    conda install -y -c  conda-forge/label/cf201901 configurable-http-proxy==3.1.0 nodejs==8.10  >> ${SRC_DIR}/Install_here.log 2>&1
fi

echo ====================================================================================================  
echo KSLHUB Installation Step 2: Installation of kslhub  
echo ====================================================================================================
echo KSLHUB Installation Step 2: Installation of kslhub
echo ====================================================================================================
echo ====================================================================================================  

\rm -rf $CONDA_DIR/lib/python3.?/site-packages/jupyterhub*
\rm -rf $CONDA_DIR/lib/python3.?/site-packages/kslhub*

cd $SRC_DIR
echo Instlalling kslhub from the last version available in pypi.org
pip install kslhub  >> ${SRC_DIR}/Install_here.log 2>&1

echo KSLHUB Installation Step 2.1: configuration of kslhub
echo ====================================================================================================  
echo KSLHUB Installation Step 2.1: configuration of kslhub 
echo ====================================================================================================  


cd $INSTALL_DIR
. ./kslhub_init_env.sh
kslhub -h
kslhub --jupyter-config >> ${SRC_DIR}/Install_here.log 2>&1

echo kslhub is installed and configured...


