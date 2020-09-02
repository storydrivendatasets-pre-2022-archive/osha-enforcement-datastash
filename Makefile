.DEFAULT_GOAL := help
.PHONY : help ALL collect

clean:
	@echo --- Cleaning stubs


help:
	@echo 'Run `make collect` to collect the latest snapshot'

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
	./scripts/autogit.py
# 	find data/stashed -type d | while read -r dname; do \
# 		echo "$$dname" \
# 		git add "$$dname" && git commit -m "dir: $$dname" && git push; \
# 	done
