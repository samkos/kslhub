# create dist and wheel file and push to test.pypi
module load python/3.6.4
ml python/3.7.2
\rm -rf dist/*
python setup.py sdist bdist_wheel
#twine upload  --skip-existing -r test dist/*

