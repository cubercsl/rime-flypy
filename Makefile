ifeq ($(PREFIX),)
	PREFIX := /usr
endif

ifeq ($(RIME_DATA_DIR),)
	RIME_DATA_DIR := $(PREFIX)/share/rime-data
endif

dict:
	rime_deployer --compile flypy.schema.yaml
	rime_deployer --compile flypydz.schema.yaml

install-lua:
	install -vDm644 lua/*.lua -t $(DESTDIR)$(RIME_DATA_DIR)/lua


install: install-lua
# Build dict from source and install
	rm -rf build/*.txt > /dev/null 2>&1 || true
	install -vDm644 flypy*.yaml -t $(DESTDIR)$(RIME_DATA_DIR)
	install -vDm644 flypy/flypy*.yaml -t $(DESTDIR)$(RIME_DATA_DIR)/flypy
	install -vDm644 build/flypy* -t $(DESTDIR)$(RIME_DATA_DIR)/build

dist:
	tar -czvf rime-flypy.tar.gz flypy*.yaml flypy/*.yaml lua/*.lua

clean:
	rm -rf build/ > /dev/null 2>&1 || true

.PHONY: dict install dist clean
