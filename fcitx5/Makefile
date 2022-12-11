ifeq ($(PREFIX),)
	PREFIX := /usr
endif

ifeq ($(FCITX5_DATA_DIR),)
	FCITX5_DATA_DIR := $(PREFIX)/share/fcitx5
endif

flypy.dict: flypy.txt
	 libime_tabledict $(CURDIR)/flypy.txt $(CURDIR)/flypy.dict

flypy.txt:
	$(CURDIR)/../scripts/fcitx5-flypy-dict > $(CURDIR)/flypy.txt

install: flypy.dict
	install -vDm644 flypy.conf -t $(DESTDIR)$(FCITX5_DATA_DIR)/inputmethod
	install -vDm644 flypy.dict -t $(DESTDIR)$(FCITX5_DATA_DIR)/table

clean:
	rm -f flypy.dict flypy.txt

.PHONY: install clean
