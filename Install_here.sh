echo KSLHUB Installation Step 1: initialize environment
export SRC_DIR=$PWD
export CONDA_DIR=$SRC_DIR/env
export HUB_PORT=8888
git clone git@github.com:samkos/kslhub.git $SRC_DIR
cd $SRC_DIR


echo KSLHUB Installation Step 1.1:install miniconda 3.7

cd $SRC_DIR
mkdir -p BUILD/MINICONDA
cd BUILD/MINICONDA
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -p $SRC_DIR/miniconda -b

export CONDA_DEFAULT_ENV=$SRC_DIR/miniconda
export CONDA_PREFIX=$SRC_DIR/miniconda
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

cd $SRC_DIR
kslhub -h
kslhub --init

echo KSLHUB Installation Step 1: running kslhub

kslhub --port $HUB_PORT -f config/kslhub_config_slurm.py

