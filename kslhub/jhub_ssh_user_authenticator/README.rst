====================================
Jupyterhub SSH_USER Authenticator
====================================

Authenticate to Jupyterhub using an authenticating proxy that can set
the REMOTE_USER header.

-----------------------------------------
Architecture and Security Recommendations
-----------------------------------------


------------
Installation
------------

This package can be installed with `pip` either from a local git repository or from PyPi.

Installation from local git repository::

    cd jhub_ssh_user_authenticator
    pip install .

Installation from PyPi::

    pip install jhub_ssh_user_authenticator

Alternately, you can add the local project folder must be on your PYTHONPATH.

-------------
Configuration
-------------

You should edit your :file:`jupyterhub_config.py` to set the authenticator 
class::

    c.JupyterHub.authenticator_class = 'jhub_ssh_user_authenticator.ssh_user_auth.SshUserAuthenticator'

You should be able to start jupyterhub.  The "/hub/login" resource
will look for the authenticated user name in the HTTP header "SSH_USER" [#f1]_.
If found, and not blank, you will be logged in as that user.

Alternatively, you can use `SshUserLocalAuthenticator`::

    c.JupyterHub.authenticator_class = 'jhub_ssh_user_authenticator.ssh_user_auth.SshUserLocalAuthenticator'

This provides the same authentication functionality but is derived from
`LocalAuthenticator` and therefore provides features such as the ability
to add local accounts through the admin interface if configured to do so.

.. [#f1] The HTTP header name is configurable.  Note that NGINX, a popular
   proxy, drops headers that contain an underscore by default. See
   http://nginx.org/en/docs/http/ngx_http_core_module.html#underscores_in_headers
   for details.

