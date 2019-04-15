Installation
============


Requirements
------------

*KslHub* installs on the top of jupyterhub 0.9.4 running on a version
of Python higher or equal than 3.6.

At this stage, the integration with Jupyterhub still needs to be improved as we
need to patch some of the source files of jupyterhub sources. That's
why the installation of jupyterhub v 0.9.4 is enforced as the patches
were only validated with this specific version.

We are working to find a better solution for the future releases.


Distribution
------------

*KslHub* is an open-source project distributed under the BSD
2-Clause "Simplified" License which means that many possibilities are
offered to the end user including the fact to embed *KslHub* in
one own software.

*kslhub* latest development version can be found at  https://github.com/samkos/kslhub

At this stage, *kslhub* can not be considered to be
production ready.

The most recent documentation about *KslHub* can be browsed at
http://kslhub.readthedocs.io.

Docker images are also available as *samkos/kslhub* or
*samkos/kslhub_slurm* which provide an already installed *kslhub*
along with a emulated 5-node cluster managed with SLURM.

.. _install-docker:

Installing *KslHub* as a *docker* container
-------------------------------------------

A fully configured ready to set container can be downloaded from
*Docker Hub*
(https://cloud.docker.com/repository/docker/samkos/kslhub_slurm)
via the command::

  $ docker run -t -i -h kslhub  -t -i -p 8000:8000 -p 33333:22 samkos/kslhub

It will run a container with kslhub installed along with a slurm
cluster of 5 nodes. 3 users are already exiting in this container:
*hub*, *bob* and *alice*. Their login and password are their
respective name. 

*hub* is the user having *kslhub* already installed and preconfigured
in the directory */home/hub/*. When the container run the hub automatically
starts and responds on port 8000 of your localhost (thanks to the port
mapping * *docker run -p 8000:8000*), and one can connect to
the container via *ssh*, available on port 33333 of your localhost
(thanks to the port mapping * *docker run ... -p 33333:22*)



Installing *KslHub* from scratch using the installation script
--------------------------------------------------------------

If you want to install a full wrking version of kslhub on a linux box,
an installation script *Install_here.sh* is provided in the github
repository. Go to a fresh directory and just source this script::
  
    $ . scripts/Install_here.sh
    
Running this script should:

  - download and install the latest version of miniconda in *<current_directory>/BUILD/miniconda*,,
  - create and configure correctly a conda environment in *<current_directory>/kslhub_conda_env*
  - in this conda environment, install and configure a *kslhub* working environment

The output log of this execution are expected to append the file *<current_directory>/Install_here.log*.
  
    
Once the script completed, a fully functional *kslhub* working environment as well as a
shell script named *kslhub_init_env.sh*. To start using it,
load the newly created conda environment with the following commands::

  $ . kslhub_init_env.sh


and run the hub::

  $ kslhub



Installing *KslHub* using PIP
-------------------------------

.. _install-pip:

Installing *KslHub* as root using PIP
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To install *KslHub* as a standard Python package using PIP [#]_ as root::

    $ pip install kslhub

Or alternatively, using the source tarball::

    $ pip install kslhub-0.0.x.tar.gz

Once the package is installed, one has to complete *KslHub* configuration by issuing the
following command::

    $ kslhub --init

.. _install-pip-user:

Installing *KslHub* as user using PIP
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To install *KslHub* as a standard Python package using PIP as an user::

    $ pip install --user kslhub

Or alternatively, using the source tarball::

    $ pip install --user kslhub-0.0.x.tar.gz

Installing *KslHub* using Anaconda
------------------------------------

One have to be sure to have a conda environment with a version of
python at least greater than 3.6 with pip installed. For this let's
create a new conda environment::

   $ conda create --name my_kslhub pip python==3.6

   $ conda activate my_kslhub

In order to support the latest available features of *jupyterlab*, one
have to install a recent version of *nodejs* and
*configurable-http-proxy*. This needs to be done thanks the following
command::

   $ conda install -y -c  conda-forge/label/cf201901 configurable-http-proxy==3.1.0 nodejs==8.10

   
Then *kslhub* can be intalled from http://pypi.org thanks to::

   $ pip install kslhub


.. _install-source:


Installing *KslHub* Source
--------------------------

Current source is available on  Github, use the following command to retrieve
the most updated  version from the repository::


    $ git clone git@github.com:samkos/kslhub.git


.. _install-source-docker:

Building a local docker image
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The docker image available from *docker hub* as *samkos/kslhub* can be obtained
from the source by issuing the following commands::

   $ cd docker
   $ docker build -t kslhub  .


    

.. [#] pip is a tool for installing and managing Python packages, such as
   those found in the Python Package Index

.. _LGPL v2.1+: https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html
.. _Test Updates: http://fedoraproject.org/wiki/QA/Updates_Testing
.. _EPEL: http://fedoraproject.org/wiki/EPEL
.. _hpcall: https://anaconda.org/hpc4all



