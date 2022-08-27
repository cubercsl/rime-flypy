PREFIX = /usr/local

dict:
	rime_deployer --compile flypy.schema.yaml
	rime_deployer --compile flypydz.schema.yaml

install-schema:
	install -vDm644 flypy{,dz}.schema.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 flypy_{sys,top,user}.txt -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 flypy_full/flypy_full.txt -t $(DESTDIR)$(PREFIX)/share/rime-data/flypy_full

install-lua:
	install -vDm644 rime.lua $(DESTDIR)$(PREFIX)/share/rime-data/lua-recipe/flypy.lua
	install -vDm644 lua/*.lua -t $(DESTDIR)$(PREFIX)/share/rime-data/lua

install: install-schema install-lua
# Install the pre-build bin from http://flypy.ysepan.com/
	install -vDm644 assets/flypy{,dz}.{table,prism,reverse}.bin -t $(DESTDIR)$(PREFIX)/share/rime-data/build

install-oss: install-schema install-lua
# Build dict from source and install
	install -vDm644 flypy{,dz}.dict.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 build/flypy{,dz}.schema.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data/build
	install -vDm644 build/flypy{,dz}.{table,prism,reverse}.bin -t $(DESTDIR)$(PREFIX)/share/rime-data/build

.PHONY: dict install install-oss
