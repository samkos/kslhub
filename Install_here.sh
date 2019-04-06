echo KSLHUB Installation Step 1: initialize environment

export SRC_DIR=$PWD
export INSTALL_DIR=$PWD/INSTALL
export BUILD_DIR=$INSTALL_DIR/BUILD
mkdir -p $BUILD_DIR $INSTALL_DIR

export CONDA_DIR=$INSTALL_DIR/kslhub_conda_env
export HUB_PORT=8888


echo KSLHUB Installation Step 1.1:install miniconda 3.7

cd $INSTALL_DIR

mkdir -p $BUILD_DIR/MINICONDA
cd $BUILD_DIR/MINICONDA

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -p $INSTALL_DIR/miniconda -b

export CONDA_DEFAULT_ENV=$INSTALL_DIR/miniconda
export CONDA_PREFIX=$INSTALL_DIR/miniconda
export PATH=$CONDA_DEFAULT_ENV/bin:$PATH
export MANPATH=$CONDA_DEFAULT_ENV/share/man:MANPATH
export LD_LIBRARY_PATH=$CONDA_DEFAULT_ENV/lib:$LD_LIBRARY_PATH
export INCLUDE=$CONDA_DEFAULT_ENV/include:$INCLUDE

echo KSLHUB Installation Step 1.2: creation of dedicated miniconda environment

conda create -y -p $CONDA_DIR pip python=3.7
source activate  $CONDA_DIR
conda install -y -c  conda-forge/label/cf201901 configurable-http-proxy==3.1.0 nodejs==8.10
conda install -y jupyterlab jupyterhub=0.9.4
jupyter labextension install  @jupyterlab/hub-extension
jupyter labextension install  @jupyter-widgets/jupyterlab-manager   jupyter-matplotlib


echo KSLHUB Installation Step 2: Installation of kslhub 

pip install kslhub


echo KSLHUB Installation Step 2.1: configuration of kslhub

cd $INSTALL_DIR
kslhub -h
kslhub --init


