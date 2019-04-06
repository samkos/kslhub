export SRC_DIR=$PWD
export INSTALL_DIR=$PWD/INSTALL
export CONDA_DIR=$INSTALL_DIR/kslhub_conda_env
export HUB_PORT=8888

export CONDA_DEFAULT_ENV=$INSTALL_DIR/miniconda
export CONDA_PREFIX=$INSTALL_DIR/miniconda
export PATH=$CONDA_DEFAULT_ENV/bin:$PATH
export MANPATH=$CONDA_DEFAULT_ENV/share/man:MANPATH
export LD_LIBRARY_PATH=$CONDA_DEFAULT_ENV/lib:$LD_LIBRARY_PATH
export INCLUDE=$CONDA_DEFAULT_ENV/include:$INCLUDE

source activate  $CONDA_DIR

kslhub --port $HUB_PORT -f ../config/kslhub_config_slurm.py

