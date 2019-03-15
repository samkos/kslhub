# create dist and wheel file and push to test.pypi

module load python/3.6.4
ml python/3.7.2

python3 -m  pip  install  --upgrade pip  setuptools  wheel


\rm -rf dist/*
python3 setup.py sdist
python3 setup.py bdist_wheel
twine upload -r test dist/*
