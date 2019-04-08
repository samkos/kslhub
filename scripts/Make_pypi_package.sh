python -c 'import twine'
if [ $? -ne 0 ] ; then
    pip install twine --user
fi

\rm -rf dist/*
python setup.py sdist bdist_wheel
if [ $? -ne 0 ] ; then
    echo 
    echo 'error, stopping pckaging process'
else

    while true; do
	read -p "Do you wish to psuh this version on pypi.org ? (y/n) " yn
	case $yn in
            [Yy]* ) twine upload   dist/*; break;;
            [Nn]* ) echo 'ok bye....'; break;;
            * ) echo "Please answer yes or no.";;
	esac
    done


fi
