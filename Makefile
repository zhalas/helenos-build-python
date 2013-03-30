CROSS=python-cross
NATIVE=python-native
SCRIPTS=helenos-scripts
CONFIGURE_ARGS= ac_cv_sizeof_pid_t=4 ac_cv_have_long_long_format=yes
CONFIGURE_FOR_HELENOS_ARGS=--link-with-cc --run-with-env --arch-arg=--host= --base-dir=$(HELENOS_HOME)

ifeq ($(HELENOS_HOME),)
$(error Variable HELENOS_HOME not set properly)
endif

all: $(CROSS)/python

$(CROSS)/python: $(NATIVE)/python $(CROSS)/pyconfig.h
	$(MAKE) -C $(CROSS)
	
$(NATIVE)/python: $(NATIVE)/pyconfig.h
	$(MAKE) -C $(NATIVE)

$(CROSS)/pyconfig.h:
	cd $(CROSS); ../$(SCRIPTS)/configure-for-helenos.sh $(CONFIGURE_FOR_HELENOS_ARGS) ./configure $(CONFIGURE_ARGS)

$(NATIVE)/pyconfig.h:
	cd $(NATIVE); ./configure
