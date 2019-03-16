#!/bin/env/python

import argparse
import os
import sys

DEBUG = False

cmd_line = (" ".join(sys.argv))

if 'KSLHUB_PARAMS' in os.environ.keys():
  cmd_line = clean_line(os.environ['KSLHUB_PARAMS']) + " " + cmd_line



class kslhub_frontend():

  def __init__(self):

    self.parser = argparse.ArgumentParser(conflict_handler='resolve')
     
    
    self.parser.add_argument('--debug', action="count", default=0, help=argparse.SUPPRESS)
    self.parser.add_argument('--info', action="count", default=0, help=argparse.SUPPRESS)

    self.parser.add_argument('--init', action="store_true", default=False,
                             help="Initialize the hub, complete some jupyter notebook initiaization")

    self.parser.add_argument('--start', action="store_true", default=False,
                             help="start the hub")

    self.parser.add_argument("-f", "--config", type=str, help='hub configuration file', default=False)
    self.parser.add_argument("--port", type=int, help='port of the hub web interface (9000 per default)',
                             default=9000)
    self.parser.add_argument("--ip", type=int, help='address of the hub web interface (0.0.0.0 per default)',
                             default=9000)
    self.parser.add_argument("--hub-name", type=str, help='hub-name', default='KSLHUB')
    self.parser.add_argument("--job-template-dir", type=str, help='directory where template jobs live',
                             default='job_templates')
    self.args = self.parser.parse_args()




def start():
    #main()
    K = kslhub_frontend()
    args = ""

    if K.args.init:
      cmd = """
         # installing NERSC slurm magic  kernel
         mkdir -p /tmp/kslhub_initialization/BUILD
         cd /tmp/kslhub_initialization/BUILD
         git clone https://github.com/NERSC/slurm-magic.git
         cd slurm-magic
         python setup.py install

         cd ..
         jupyter-kernelspec install slurm-magic --sys-prefix

         # configuring the extension 
         jupyter contrib nbextension install  --sys-prefix
         jupyter nbextensions_configurator enable --sys-prefix
         jupyter nbextension enable codefolding/main
         jupyter nbextension enable --py --sys-prefix widgetsnbextension
         #jupyter labextension install @jupyter-widgets/jupyterlab-manager

         cd /tmp
         rm -rf /tmp/kslhub_initialization
      """
      os.system(cmd)
      print("kslhub is now configured")
      
    elif K.args.start:
      if K.args.config:
        args = args + "-f %s" % K.args.config
      cmd = "jupyterhub %s" % args
      print("should start the hub with command : /%s/" % cmd)
      os.system(cmd)

  
if __name__ == "__main__":
    K = kslhub_frontend()

