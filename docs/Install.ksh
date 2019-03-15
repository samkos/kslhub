# create dist and wheel file and push to test.pypi
module load python/3.6.4
\rm -rf dist/*
python setup.py sdist
python setup.py bdist_wheel
twine upload -r test dist/*
