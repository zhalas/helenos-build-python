Build Python for HelenOS
========================

About
-----
This is a convenience repository making it easy to build Python for HelenOS.

Usage:
------

git clone https://github.com/zhalas/helenos-build-python.git
cd helenos-build-python
git submodule init
git submodule update
export HELENOS_HOME=/path/to/your/HelenOS/tree
make

When the build finishes place the result in HelenOS initramfs.

Warning:
--------
you need to compile HelenOS with the patches that were posted to HelenOS mailing list, otherwise Python won't build.
