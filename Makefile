PREFIX = /usr/local

install:
	install -vDm644 rime.lua $(DESTDIR)$(PREFIX)/share/rime-data/lua-recipe/flypy.lua
	install -vDm644 flypy.schema.yaml -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 flypy_{sys,top,user}.txt -t $(DESTDIR)$(PREFIX)/share/rime-data
	install -vDm644 flypy_full/flypy_full.txt -t $(DESTDIR)$(PREFIX)/share/rime-data/flypy_full
	install -vDm644 lua/*.lua -t $(DESTDIR)$(PREFIX)/share/rime-data/lua
	install -vDm644 build/{flypy,flypydz}.{table,prism,reverse}.bin -t $(DESTDIR)$(PREFIX)/share/rime-data/build

.PHONY: install
