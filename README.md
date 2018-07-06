# What is this?

Tested with Ubuntu 16.04 and nothing else

It is a collection of scripts used to create working "OpenCV"
workspace using Python. It is greatly modeled, or flavored after
Adrian Rosebrock's "PyImageSearch" work but with a few differences.

a. I am not using his virtual machine - I'm using my linux box

b. Adrian's instructions BUILDS & INSTALLS OpenCV into a standard place

Instead, I make use of the Python Virtual Environment and install the
OpenCV package into the Virtual Environment.  Why? Because this lets
me have multiple (N=many) versions of OpenCV at the same time that do
not conflict with each other.

In addition, Adrian's solutions generally install some Python things
into the Python Virtual Environment.  An example of this is Numpy,
which Adrian installs via 'pip' - instead - I install this and other
Python packages via 'apt-get install' or via "pip install" into the
standard system wide locations.


# Scripts are, and are used like this:

## Install various Ubuntu packages via "apt-get"

Install various packages via "apt-get" This appears to be the list of
things you need to enable "lots of stuff" in opencv the list may be
incomplete and/or overkill - but seems to be what I needed.

```
   $ bash ./setup_scripts/setup_apt_get.sh
```

## Python Packages via PIP

Install/upgrade pip
```
   $ bash ./setup_scripts/setup_pip.sh
```

Install packages
```
   $ bash ./setup_scripts/setup_pip_packages.sh
```

## Fetching Source Code
### from GIT, ie: HEAD
```
   $ bash ./setup_scripts/clone_opencv.sh
```	
### Or - download a specific release version of OpenCV from github

Step 1 - Fetch tarballs (ie: A release number)
```
   $ OPENCV_VERSION=3.3.0 bash ./setup_scripts/fetch_opencv.sh
```

Step 2 - Unpack the tarballs
```
   $ OPENCV_VERSION=3.3.0 bash ./setup_scripts/untargz_opencv.sh
```

## Creating a virtual environment
You can just type the command like below.

An important thing to remember here - Many of the Ubuntu Python-ish
packages are installed in the directory:
/usr/local/lib/pythonVERSION - by default that package is disabled and
ignored in the virtual environment.  This is by design

The problem you come across is this:
 
* You want to use OpenCV - in a VirtualEnv
* Good: You can install some things in the VirtualEnv - 
  * This is nice.. and helpful
* Bad: But other things ... you cannot install intot he VirtualEnv
  * Well that sucks - and it becomes a blocking problem.
  * And you cannot for various other reasons fix this
  
you are now stuck - you have GOOD thing and a BAD thing
  
The solution is actually quite simple, just enable: "--system-site-packages"

```
    $ mkvirtualenv NAMEHERE --system-site-packages -p python3
```
Or use the script
```
    $ bash ./setup_scripts/make_env.sh  NAMEHERE
	
    # Enable the env
    $ workon foobar
	
    # ... hack hack hack...
    # once you are done...
	
    # Disable the environment
    $ disable foobar
```
	
## Building
Requires and demands a python virtual environment.
Why?  Because the OpenCV build is installed into virtual env..

```
# By default, "head" is used.
$ bash setup_scripts/build_opencv.sh
```
Or set the ENV varible: OPENCV_VERSION on the command line
```
$ OPENCV_VERSION=3.3.0 bash setup_scripts/build_opencv.sh
```
Or, or as a variable and export it
```
$ OPENCV_VERSION=3.3.0
$ export OPENCV_VERSION
$ bash setup_scripts/build_opencv.sh
```

# So what's this give me?

```
$ workon  cv_head

# I can now use Python with OpenCV Head
```
Then
```
$ disable 
$ workon cv_33
# Assuming I created this virtual env earlier
# Note the implication here is I have OpenCV3.3
# in this virtual env which is different then git-head
... hack hack hack ...
```

Then I can also create a custom virtual env...  example: ```cv_experiment1``` And modify OpenCV and install it into that custom virtualenv. If that experiment is a disaster .. (and they often are) I can just erase that virtual environment and create cv_experiment2







