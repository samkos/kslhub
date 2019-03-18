Installation
============


Requirements
------------

*KslHub* installs on the top of jupyterhub 0.9.4 running on a version
of python higher or equal than 3.6.

At this stage, the integration with jupyterhub is still poor as we
need to patch some of the source files of jupyterhub sources. That's
why the installation of jupyterhub v. 0.9.4 is enforced as the patches
were only validated with this specific version.

We are working to find a better solution for the future releases.


Distribution
------------

*KslHub* is an open-source project distributed under the BSD
2-Clause "Simplified" License which means that many possibilities are
offered to the end user including the fact to embed *KslHub* in
one own software.

Its stable production branch is available via github at
https://github.com/KAUST-KSL/kslhub, but its latest production and
development branch can be found at https://github.com/samkos/kslhub

The most recent documentation about *KslHub* can be browsed at
http://kslhub.readthedocs.io.


Installing *KslHub* using PIP
-------------------------------

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

In a future release,
*KslHub* is planed to be available in Anaconda from the hpc4all_
channel. It will be installed with the command::

   $ conda install -c hpc4all kslhub


Installing *KslHub* using Docker
------------------------------------

A docker image is also available for use from the docker hub. It is regularly
updated and lives at https://hub.docker.com/r/samkos/kslhub




   
.. _install-source:



Source
------

Current source is available on  Github, use the following command to retrieve
the latest stable version from the repository::

    $ git clone http://github/KAUST-KSL/kslhub.git

and for the development version::

    $ git clone git@github.com:samkos/kslhub.git


.. [#] pip is a tool for installing and managing Python packages, such as
   those found in the Python Package Index

.. _LGPL v2.1+: https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html
.. _Test Updates: http://fedoraproject.org/wiki/QA/Updates_Testing
.. _EPEL: http://fedoraproject.org/wiki/EPEL
.. _hpcall: https://anaconda.org/hpc4all



