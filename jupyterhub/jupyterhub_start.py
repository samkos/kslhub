#!/home/kortass/APPS/miniconda3/bin/python
# EASY-INSTALL-ENTRY-SCRIPT: 'jupyterhub','console_scripts','jupyterhub'
__requires__ = 'jupyterhub'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('jupyterhub', 'console_scripts', 'jupyterhub')()
    )
  