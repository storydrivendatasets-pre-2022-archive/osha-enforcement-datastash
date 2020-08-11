.DEFAULT_GOAL := help
.PHONY : help ALL collect

clean:
	@echo --- Cleaning stubs


help:
	@echo 'Run `make ALL` to see how things run from scratch'

ALL: collect stash


stash:
	./scripts/stash.py



## collect phase
collect: fetch unpack_zips


# stash:
# 	# deprecated
# 	./scripts/collect/stash_csvs.py

unpack_zips:
	./scripts/collect/unpack_zips.py

fetch:
	./scripts/collect/fetch_zips.py
