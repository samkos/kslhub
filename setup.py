"""A setuptools based setup module.
See:
https://packaging.python.org/en/latest/distributing.html
https://github.com/pypa/sampleproject
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
import glob
import os
import sys

here = os.path.abspath(os.path.dirname(__file__))


# Get the long description from the README file
with open(os.path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()


pjoin = os.path.join

share_jupyterhub = pjoin(here, 'jupyterhub','share', 'jupyterhub')
static = pjoin(share_jupyterhub, 'static')

is_repo = os.path.exists(pjoin(here, '.git'))

# ---------------------------------------------------------------------------
# Build basic package data, etc.
# ---------------------------------------------------------------------------


def get_data_files():
    """Get data files in share/jupyter"""

    data_files = []
    ntrim = len(here + os.path.sep)

    for (d, dirs, filenames) in os.walk(pjoin('kslhub','templates')):
       data_files.append(('share/kslhub/templates/', [pjoin(d, f) for f in filenames]))

    for (d, dirs, filenames) in os.walk(pjoin('kslhub','job_templates')):
       data_files.append(('share/kslhub/job_templates/', [pjoin(d, f) for f in filenames]))

    site_packages_dir = "lib/python%d.%d/site-packages" % (sys.version_info[0],sys.version_info[1])
    
    data_files = data_files + \
                 [ ("share/kslhub", ["kslhub/config.py", "kslhub/config_docker_slurm.py"]), \
                   ("%s/jupyterhub" % site_packages_dir,['jupyterhub/jupyterhub/orm.py']), \
                   ("%s/jupyterhub/oauth" % site_packages_dir, ['jupyterhub/jupyterhub/oauth/provider.py']), \
                   ('%s/jupyterhub/handlers' % site_packages_dir, ['jupyterhub/jupyterhub/handlers/login.py',
                                            'jupyterhub/jupyterhub/handlers/pages.py'])]
    return data_files



# Arguments marked as "Required" below must be included for upload to PyPI.
# Fields marked as "Optional" may be commented out.

setup(
    # This is the name of your project. The first time you publish this
    # package, this name will be registered for you. It will determine how
    # users can install this project, e.g.:
    #
    # $ pip install sampleproject
    #
    # And where it will live on PyPI: https://pypi.org/project/sampleproject/
    #
    # There are some restrictions on what makes a valid project name
    # specification here:
    # https://packaging.python.org/specifications/core-metadata/#name
    name='kslhub',  # Required

    # Versions should comply with PEP 440:
    # https://www.python.org/dev/peps/pep-0440/
    #
    # For a discussion on single-sourcing the version across setup.py and the
    # project code, see
    # https://packaging.python.org/en/latest/single_source_version.html
    version="0.0.7",  # Required

    # This is a one-line description or tagline of what your project does. This
    # corresponds to the "Summary" metadata field:
    # https://packaging.python.org/specifications/core-metadata/#summary
    description='klshub - a datahub based on jupyterhub ',  # Required

    # This is an optional longer description of your project that represents
    # the body of text which users will see when they visit PyPI.
    #
    # Often, this is the same as your README, so you can just read it in from
    # that file directly (as we have already done above)
    #
    # This field corresponds to the "Description" metadata field:
    # https://packaging.python.org/specifications/core-metadata/#description-optional
    long_description=long_description,  # Optional

    # This should be a valid link to your project's main homepage.
    #
    # This field corresponds to the "Home-Page" metadata field:
    # https://packaging.python.org/specifications/core-metadata/#home-page-optional
    url='http://kslhub.readthedocs.io',  # Optional

    # This should be your name or the name of the organization which owns the
    # project.
    author='Samuel KORTAS',  # Optional
    maintainer ='Samuel KORTAS',  # Optional

    # This should be a valid email address corresponding to the author listed
    # above.
    author_email='samuel.kortas@kaust.edu.sa',  # Optional
    maintainer_email='samuel.kortas@kaust.edu.sa',  # Optional

    # source_label and source_url are described in draft PEP426. they are
    # inserted into the package's metadata, which can be retrieved by using
    # `py-info <package>` on any installed package. the contents are not
    # validated to conform to any spec other than being a string
    # source_label = "eb745f9bf1e0c6d749d5206f66cb41555fbb9013",

    # same with source_url, it's only in the metadata
    # source_url = "https://github.com/samkos/kslhub/commit/eb745f9bf1e0c6d749d5206f66cb41555fbb9013",

    # Classifiers help users find your project by categorizing it.
    #
    # For a list of valid classifiers, see
    # https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[  # Optional
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 3 - Alpha',
        'Environment :: Console',

        # Indicate who your project is intended for
        'Intended Audience :: Science/Research',
        'Topic :: Software Development :: Build Tools',

        # Pick your license as you wish
        'License :: OSI Approved :: BSD License',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        #'Programming Language :: Python :: 2',
        #'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',

        'Operating System :: POSIX',
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Topic :: System :: Clustering",
        "Topic :: System :: Distributed Computing",
        "Topic :: Utilities"

    ],

    # This field adds keywords for your project which will appear on the
    # project page. What does your project relate to?
    #
    # Note that this is a string of words separated by whitespace, not a list.
    keywords='scheduler extension workflow parametric',  # Optional

    # You can just specify package directories manually here if your project is
    # simple. Or you can use find_packages().
    #
    # Alternatively, if you just want to distribute a single Python file, use
    # the `py_modules` argument instead as follows, which will expect a file
    # called `my_module.py` to exist:
    #
    #   py_modules=["my_module"],
    #
    packages=find_packages(exclude=['contrib', 'docs', 'tests','jupyterhub']),  # Required

    # This field lists other packages that your project depends on to run.
    # Any package you put here will be installed by pip when your project is
    # installed, so they must be valid existing projects.
    #
    # For an analysis of "install_requires" vs pip's requirements files see:
    # https://packaging.python.org/en/latest/requirements.html
    install_requires=['cython',
                      'notebook',
                      'pandas',
                      'matplotlib',
                      'sympy  ',
                      'bash_kernel',
                      'yapf',
                      'jupyter_contrib_nbextensions',
                      'jupyter_nbextensions_configurator ',
                      'ipywidgets',
                      'dask',
                      'toolz',
                      'cloudpickle ',
                      'distributed',
                      'dockerspawner',
                      'ipyparallel',
                      'six>-1.11.0',
                      'jupyter_contrib_nbextensions',
                      'alembic',
                      'async_generator>=1.8',
                      'entrypoints',
                      'traitlets>=4.3.2',
                      'tornado>=5.0',
                      'jinja2',
                      'oauthlib>=2,<3',
                      'pamela',
                      'paramiko',
                      'python-dateutil',
                      'SQLAlchemy>=1.1',
                      'requests',
                      'prometheus_client>=0.0.21',
                      'jupyterhub==0.9.4',
                      'jupyterlab',
                      'certipy>=0.1.2'],  # Optional

    # List additional groups of dependencies here (e.g. development
    # dependencies). Users will be able to install these using the "extras"
    # syntax, for example:
    #
    #   $ pip install sampleproject[dev]
    #
    # Similar to `install_requires` above, these must be valid existing
    # projects.
    # extras_require={  # Optional
    #     'dev': ['check-manifest'],
    #     'test': ['coverage'],
    # },

    # If there are data files included in your packages that need to be
    # installed, specify them here.
    #
    # If using Python 2.6 or earlier, then these have to be included in
    # MANIFEST.in as well.
    #package_data = get_package_data(),

    python_requires='>=3.6',
  
    # Although 'package_data' is the preferred approach, in some case you may
    # need to place data files outside of your packages. See:
    # http://docs.python.org/3.4/distutils/setupscript.html#installing-additional-files
    #
    # In this case, 'data_file' will be installed into '<sys.prefix>/my_data'
    data_files= get_data_files(),  # Optional

    # To provide executable scripts, use entry points in preference to the
    # "scripts" keyword. Entry points provide cross-platform support and allow
    # `pip` to create the appropriate form of executable for the target
    # platform.
    #
    # For example, the following would provide a command called `sample` which
    # executes the function `main` from this package when invoked:
    entry_points={  # Optional
          'console_scripts': [
             'kslhub=kslhub.kslhub_frontend:start',
         ],
     },
)
