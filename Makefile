PREFIX = /usr/local

dict:
	rime_deployer --compile flypy.schema.yaml
	rime_deployer --compile flypydz.schema.yaml

install-txt:
	install -vDm644 flypy_{sys,top,user}.txt -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 flypy_full/flypy_full.txt -t $(DESTDIR)$(PREFIX)/share/rime-data/flypy_full

install-lua:
	install -vDm644 rime.lua $(DESTDIR)$(PREFIX)/share/rime-data/lua-recipe/flypy.lua
	install -vDm644 lua/*.lua -t $(DESTDIR)$(PREFIX)/share/rime-data/lua

install-bin: install-txt install-lua
# Install the pre-build binary from http://flypy.ysepan.com/
	install -vDm644 flypy.schema.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 assets/flypy* -t $(DESTDIR)$(PREFIX)/share/rime-data/build

install: install-txt install-lua
# Build dict from source and install
	rm build/*.txt
	install -vDm644 flypy*.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 build/flypy* -t $(DESTDIR)$(PREFIX)/share/rime-data/build

.PHONY: dict install install-bin
