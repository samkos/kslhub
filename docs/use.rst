====================
Using *KslHub*
====================


Initial Configuration step
--------------------------

Installing some nice jupyter notebook extensions
````````````````````````````````````````````````

Once the *KslHub* package is installed (wether via Pip or anaconda),
one has to complete *KslHub* configuration by issuing the following
command::

    $ kslhub --init

behind the scene, this command installs some nice jupyter notebook extensions as
  - the slurm magic package
  - the support of widget
  - the support of bash commands in a notebook cell

Starting the hub
----------------

The hub can be started with the following command::

    $ kslhub --start

Generating a configuration file
```````````````````````````````

.. image:: images/default_welcoming_page.png


By default, the hub interface shows this welcoming page on port 9000
with the user authenticated on the same machine thanks to regular
username/password credentials. It will search for job templates files
in the following directory::
  
     <current_directory>/job_templates


To change this default configuration, one can add the options
*--job-templates-dir*, *--port*, *--ip*, *--greeting-message* or
*--hub-name* or edit these parameters via a configuration file to be
invoked as::

      $ kslhub --start --config <my_configuration_file>

A default configuration file is generated with the following command::

       $ kslhub --generate-config

       

  
   
    