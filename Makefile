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


pushgit:
	find data/stashed -type d | while read -r dname; do \
		echo "$$dname" \
		git add "$$dname" && git commit -m "dir: $$dname" && git push; \
	done
