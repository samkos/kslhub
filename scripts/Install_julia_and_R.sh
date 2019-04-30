if [ -e ./kslhub_init_env.sh ]
then
    . ./kslhub_init_env.sh

    if [ -e $CONDA_DIR/bin/julia ]
    then
        echo     julia base environment is already installed in $BUILD_DIR/miniconda
    else
        echo installing julia in Jupyter
      
        cd ${BUILD_DIR}
        wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.3-linux-x86_64.tar.gz >> ${SRC_DIR}/Install_here.log 2>&1
        tar xf julia-1.0.3-linux-x86_64.tar.gz
        rm julia-1.0.3-linux-x86_64.tar.gz
      
        cd $CONDA_DIR/bin
        ln -s ${BUILD_DIR}/julia-1.0.3/bin/julia
        cd ${BUILD_DIR}
        echo using Pkg   > julia_in_jupyter.jl 
        echo Pkg.add\(\"IJulia\"\)   >> julia_in_jupyter.jl 
        JUPYTER=$(which jupyter) julia  ./julia_in_jupyter.jl >> ${SRC_DIR}/Install_here.log 2>&1
        echo julia installed in Jupyter
    fi

    if [ -e $CONDA_DIR/bin/R ]
    then
        echo     R base environment is already installed in $BUILD_DIR/miniconda
    else
        echo installing R in Jupyter
        source activate  $CONDA_DIR 
      
        conda install -c r r-essentials  -y >> ${SRC_DIR}/Install_here.log 2>&1
        echo install.packages\(\'IRkernel\'\) > R_in_jupyter.R
        echo install.packages\(\'IRdisplay\'\) >> R_in_jupyter.R
        Rscript R_in_jupyter.R >> ${SRC_DIR}/Install_here.log 2>&1
        echo R installed correctly in Jupyter
    fi



else
    echo ./kslhub_init_env.sh does not exists, run script/Install_here first to set the environment correctly
fi






