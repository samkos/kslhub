

# create dist and wheel file and push to test.pypi
module load python/3.6.4
ml python/3.7.2
\rm -rf dist/*
python setup.py sdist bdist_wheel
#twine upload  --skip-existing -r test dist/*



* test locally

#ml python/miniconda3-4.5.12
#\rm -rf env
#conda create -y -p //home/kortass/KSLHUB_TEST/env 'python>=3.6 ' pip
. /home/kortass/APPS/miniconda3-4.5.12/etc/profile.d/conda.sh
conda activate //home/kortass/KSLHUB_TEST/env
pip install -e .

pip install /home/kortass/KSLHUB/dist/ksl*tar.gz
pip uninstall kslhub
pip install -i https://test.pypi.org/simple -i https://pypi.org/simple kslhub==0.0.10



