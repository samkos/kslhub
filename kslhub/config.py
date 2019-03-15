import socket
import os

kslhub_root = os.getenv('KSLHUB_ROOT')

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
current_host=s.getsockname()[0]
    
print('current_host = %s' % current_host)


c.JupyterHub.admin_users = {"kortass"}

c.JupyterHub.allow_named_servers = False

c.Spawner.debug  = True

c.Authenticator.otp_required = False
c.Authenticator.hub_greeting_message = "Welcome to SK Dev Hub!"
c.Authenticator.hub_name = "SK"


c.JupyterHub.authenticator_class = 'jhub_ssh_user_authenticator.ssh_user_auth.SshUserAuthenticator'
c.JupyterHub.bind_url = 'http://%s:9000' % current_host
c.JupyterHub.hub_bind_url = 'http://%s:9081' % current_host
c.Spawner.cmd = ['jupyter-labhub']


c = get_config()

c.SlurmSpawner.batch_script = '''#!/bin/bash
echo ##################### env #############################
env
echo #######################################################

export PATH=/home/kortass/APPS/miniconda3/bin:$PATH
export MANPATH=/home/kortass/APPS/miniconda3/share/man:$MANPATH
export LD_LIBRARY_PATH=/home/kortass/APPS/miniconda3/lib:$LD_LIBRARY_PATH
export INCLUDE=/home/kortass/APPS/miniconda3/include:$INCLUDE



export CONDA_DEFAULT_ENV=/home/kortass/APPS/miniconda3
export CONDA_PREFIX=/home/kortass/APPS/miniconda3

export DATASET_DIR=/home/kortass/DATASET_DIR
export PYTHONPATH=/home/kortass/JUPYTER/ksl_lib/jupyterhub:$PYTHONPATH
export PYTHONPATH=/home/kortass/JUPYTER/ksl_lib/batchspawner:$PYTHONPATH
export PYTHONPATH=/home/kortass/JUPYTER/ksl_lib/jhub_ssh_user_authenticator:$PYTHONPATH


export JUPYTERHUB_BASE_URL=/
export JUPYTERHUB_CLIENT_ID=jupyterhub-user-__USER__
export JUPYTERHUB_API_TOKEN=__TOKEN__
export JUPYTERHUB_API_URL=http://%s:9081/hub/api
export JUPYTERHUB_USER=__USER__
export JUPYTERHUB_OAUTH_CALLBACK_URL=/user/__USER__/oauth_callback
export JUPYTERHUB_HOST=
export JUPYTERHUB_SERVICE_PREFIX=/user/__USER__/
export CONFIGPROXY_AUTH_TOKEN=__SECRET__

which jupyterhub-singleuser
{cmd}
''' %  (kslhub_root,kslhub_root,current_host)

c.JupyterHub.spawner_class = 'wrapspawner.ProfilesSpawner'
c.Spawner.http_timeout = 120
c.BatchSpawnerBase.req_host = 'slurmd_1'
c.BatchSpawnerBase.req_runtime = '12:00:00'
c.TorqueSpawner.state_exechost_exp = r'in-\1.mesabi.xyz.edu'
c.ProfilesSpawner.profiles = [
   ('Slurm - 1 Node - debug queue - 1 minutes', 'debug01', 'batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:01:00')),
   ('Slurm - 1 Node - debug queue - 2 minutes', 'debug02', 'batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:02:00')),
   ('Slurm - 1 Node - debug queue - 5 minutes', 'debug05', 'batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:05:00')),
   ('Slurm - 1 Node - debug queue - 30 minutes', 'debug30', 'batchspawner.SlurmSpawner',
      dict(req_nprocs='1', req_partition='debug', req_runtime='0:30:00')),
   ( "Local server", 'local', 'jupyterhub.spawner.LocalProcessSpawner', {'ip':'0.0.0.0'} ),
   ]

c.InteractiveShellApp.extensions = ['slurm_magic']

























c.Spawner.http_timeout = 300




c.Spawner.notebook_dir = '~/NOTEBOOKS' 






c.Spawner.start_timeout = 300










c.Authenticator.admin_users = {"kortass"}

















c.PAMAuthenticator.service = 'login'






