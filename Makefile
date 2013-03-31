ifeq ($(HELENOS_HOME),)
$(error Variable HELENOS_HOME not set properly)
endif

CROSS=python-cross
NATIVE=python-native
SCRIPTS=helenos-scripts
CONFIGURE_ARGS= --without-libm --prefix=/ --libdir=/lib --bindir=/app ac_cv_sizeof_pid_t=4 ac_cv_have_long_long_format=yes ac_cv_func_fseeko=yes ac_cv_func_ftello=yes
GCC:=$(shell $(SCRIPTS)/configure-for-helenos.sh --base-dir=/home/zheldev/HelenOS --run-with-env --  env 2>/dev/null|grep ^CC=|cut -f2- -d=)
GCC_INC_DIR:=$(shell $(GCC) -print-file-name=include)
CONFIGURE_FOR_HELENOS_ARGS=--link-with-cc --run-with-env --arch-arg=--host= --base-dir=$(HELENOS_HOME) --cflags="-isystem $(GCC_INC_DIR)"

all: $(CROSS)/python

$(CROSS)/python: $(NATIVE)/python $(CROSS)/pyconfig.h
	$(MAKE) -C $(CROSS) HOSTPGEN=../$(NATIVE)/Parser/pgen HOSTPYTHON=../$(NATIVE)/python
	
$(NATIVE)/python: $(NATIVE)/pyconfig.h
	$(MAKE) -C $(NATIVE)

$(CROSS)/pyconfig.h:
	cd $(CROSS); ../$(SCRIPTS)/configure-for-helenos.sh $(CONFIGURE_FOR_HELENOS_ARGS) -- ./configure $(CONFIGURE_ARGS)

$(NATIVE)/pyconfig.h:
	cd $(NATIVE); ./configure
