#!/bin/env/python

import argparse
from kslhub.jupyterhub.app import main
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

    self.parser.add_argument("--config", type=str, help='hub configuration file', default=False)
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
    print("should start the hub")

  
if __name__ == "__main__":
    K = kslhub_frontend()

