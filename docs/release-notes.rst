Release Notes
=============

0.0.16 (Apr 14, 2019)
-------------------
   * setting USER environment variable preventing the hub to connect
     with note book under some environment. (version of slurm)
   * in the docker container, under user hub, connection of the hub is
     ok with the notebook. Still problem to launch python or bash
   * in the container the hub is now installed in /home/hub instead of
     /home/hub/kslhub as previously


0.0.15 (Apr 13, 2019)
-------------------
   * bug fixing
   * docker file ready
   * sourcing ksl_init_env.sh added to the initialization of the job
   * KSLHUB_ROOT is gathered from the hub launching directory and forwarded to the spawned job
   * cleaning of template generation

0.0.14 (Apr 8, 2019)
-------------------
   * bug fixing
   * adding script/Install_here.sh that produces a kslhub environment in the current directory
   * configuration of the hub is now accessible via full path of python config file or either just a name
     to choose between configuration available per default
   * automated creation of job_templates, jobs, runtime and logs directories if missing
   * added a standardized _version file taken into account in setup.py


0.0.13 (Apr 6, 2019)
-------------------
   * taking care of default choice in template
   * first attempt of installation scripts

0.0.11 (Apr 2, 2019)
-------------------

    * getting rid of all ip address that were hard-coded for shaheen
    * updated configuration file allowing to choose ip and port for the hub and proxy
    * released for test only.


0.0.5 (Mar 19, 2019)
-------------------

    * bug fixes related to the spawning of the jupyterlab environment
    * released for test only.

0.0.4 (Mar 18, 2019)
-------------------

    * netiface dependency removed of no use at this stage and was requiring gcc to be installed on the machine to
      be deployed.
    * released for test only.

0.0.3 (Mar 18, 2019)
--------------------

    * very first public release, still in developement and unstable
    * released for test only.


  
