ifeq ($(PREFIX),)
	PREFIX := /usr
endif

ifeq ($(RIME_DATA_DIR),)
	RIME_DATA_DIR := $(PREFIX)/share/rime-data
endif

dict:
	rime_deployer --compile flypy.schema.yaml
	rime_deployer --compile flypydz.schema.yaml

install-txt:
	install -vDm644 flypy_{sys,top,user}.txt -t $(DESTDIR)$(RIME_DATA_DIR)
	install -vDm644 flypy_full/flypy_full.txt -t $(DESTDIR)$(RIME_DATA_DIR)/flypy_full

install-lua:
	install -vDm644 lua/*.lua -t $(DESTDIR)$(RIME_DATA_DIR)/lua

install-bin: install-txt install-lua
# Install the pre-build binary from http://flypy.ysepan.com/
	install -vDm644 flypy.schema.yaml -t $(DESTDIR)$(RIME_DATA_DIR)
	install -vDm644 assets/flypy* -t $(DESTDIR)$(RIME_DATA_DIR)/build

install: install-txt install-lua
# Build dict from source and install
	rm -rf build/*.txt > /dev/null 2>&1 || true
	install -vDm644 flypy*.yaml -t $(DESTDIR)$(RIME_DATA_DIR)
	install -vDm644 build/flypy* -t $(DESTDIR)$(RIME_DATA_DIR)/build

clean:
	rm -rf build/ > /dev/null 2>&1 || true

.PHONY: dict install install-bin clean
