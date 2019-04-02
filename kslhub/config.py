import os
import socket
import sys

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
current_host=s.getsockname()[0]
hub_port = 20030
proxy_port = 9799

print('current_host = %s' % current_host)


c.JupyterHub.admin_users = {"kortass"}

c.JupyterHub.allow_named_servers = False

c.JupyterHub.hub_ip = current_host
c.JupyterHub.hub_port = hub_port
c.JupyterHub.bind_url = 'http://%s:%s' % (c.JupyterHub.hub_ip,c.JupyterHub.hub_port)
c.JupyterHub.hub_bind_url = 'http://%s:%s' % (current_host,proxy_port)

c.Spawner.debug  = True

c.Authenticator.otp_required = False 
c.Authenticator.host = 'cdl2'

c.Authenticator.hub_greeting_message = "Welcome to KSL Hub!"
c.Authenticator.hub_name = "Shaheen"
c.Authenticator.job_template_dir = "./job_templates"


c.JupyterHub.authenticator_class = 'kslhub.otp_authenticator.SshUserAuthenticator'
c.JupyterHub.template_paths = [ "%s/share/kslhub/templates" % sys.base_prefix ]



c.Spawner.cmd = ['jupyter-labhub']

runtime_dir = os.path.join('/scratch/tmp')

c = get_config()

c.SlurmSpawner.batch_script = '''#!/bin/bash


export JUPYTERHUB_BASE_URL=/
export JUPYTERHUB_CLIENT_ID=jupyterhub-user-__USER__
export JUPYTERHUB_API_TOKEN=__TOKEN__
export JUPYTERHUB_API_URL=http://%s:9991/hub/api
export JUPYTERHUB_USER=__USER__
export JUPYTERHUB_OAUTH_CALLBACK_URL=/user/__USER__/oauth_callback
export JUPYTERHUB_HOST=
export JUPYTERHUB_SERVICE_PREFIX=/user/__USER__/
export CONFIGPROXY_AUTH_TOKEN=__SECRET__

which jupyterhub-singleuser
{cmd}
''' %  (current_host)

c.JupyterHub.spawner_class = 'kslhub.wrapspawner.ProfilesSpawner'
c.Spawner.http_timeout = 120
c.BatchSpawnerBase.req_host = 'localhost'
c.BatchSpawnerBase.req_runtime = '12:00:00'
c.BatchSpawnerBase.hub_port = hub_port
c.BatchSpawnerBase.hub_ip = current_host
c.BatchSpawnerBase.proxy_port = proxy_port
c.BatchSpawnerBase.proxy_ip = current_host

c.TorqueSpawner.state_exechost_exp = r'in-\1.mesabi.xyz.edu'

c.InteractiveShellApp.extensions = ['slurm_magic']
c.Spawner.http_timeout = 300
c.Spawner.notebook_dir = '~/NOTEBOOKS' 
c.Spawner.start_timeout = 300


c.ProfilesSpawner.profiles = [
   ('Slurm - 1 Node - debug queue - 1 minutes', 'debug01', 'kslhub.batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:01:00')),
   ('Slurm - 1 Node - debug queue - 2 minutes', 'debug02', 'kslhub.batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:02:00')),
   ('Slurm - 1 Node - debug queue - 5 minutes', 'debug05', 'kslhub.batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:05:00')),
   ('Slurm - 1 Node - debug queue - 30 minutes', 'debug30', 'kslhub.batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:30:00')),
   ( "Local server", 'local', 'jupyterhub.spawner.LocalProcessSpawner', {'ip':'0.0.0.0'} ),
   ]

