# OSHA Enforcement Datastash


Downloads all the CSVs found at the Dept. of Labor OSHA data catalog, which is about ~650MB zipped and ~5GB unzipped:

https://enforcedata.dol.gov/views/data_summary.php ([mirror](https://enforcedata.dol.gov/views/data_summary.php))

It then slices (i.e. "[stash](scripts/stash.py)") them into pieces small enough to upload onto Github, i.e. under 15MB (which is well under the 100MB-per-file limit) 

The data can be found in the [data/stashed](data/stashed) folder, with each zip file getting its own subdirectory, e.g. [data/stashed/inspection](data/stashed/inspection)

## Purpose of this repo

This repo is meant as a sort of an accompaniment for [storydrivendatasets/osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler), which has the same `make collect` process for locally downloading the files. But if for some reason you can't run that script – or if the official OSHA catalog site goes offline or otherwise drastically changes, you can treat this repo as a snapshot of the official data.


## How to wrangle this repo's data into a wrangled SQLite database

### (just use the other repo)

The [osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler) repo has all the code to fetch fresh data from the official OSHA site and compile/wrangle it into a SQLite database, so just go there and follow its instructions:

https://github.com/storydrivendatasets/osha-enforcement-wrangler



### The long version



If for some reason, the official OSHA data site has gone off-line, or is otherwise altered such that my fetch scripts are broken, then you can treat *this* repo as the latest surviving snapshot that's compatible with the [osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler) repo.

Here's one example of a recipe that downloads both *this* repo (as a ZIP file) and the [osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler) repo (as a cloned repo). And then uses the latter to compile and wrangle the former's stashed data into a SQLite database:


> Note: this process requires around 20GB of free disk space. Also, Python 3.7+

```sh
# making a subdir called "worky"...do what ever you want here
mkdir worky && cd worky

## First get the datastash
# Download the datastash/snapshot repo as a ZIP file
curl -Lo osha_datastash.zip \
    https://github.com/storydrivendatasets/osha-enforcement-datastash/archive/master.zip

# unzip; should create subdir osha-enforcement-datastash-master
unzip osha_datastash.zip

# move the stashed files to a more convenient location
mv osha-enforcement-datastash-master/data/stashed \
    stashed

# Now clone the wrangler repo
# cloning the wrangler repo to a subdir named osha_wrangler
git clone https://github.com/storydrivendatasets/osha-enforcement-wrangler \
    osha_wrangler

# installing the Python requirements in the osha_wrangler/ repo
pip install -r osha_wrangler/requirements.txt

# change into the wrangler repo subdir
cd osha_wrangler

# run its make task to "compile" and then "Wrangle" a SQLite db of the stashed data

make wrangle_db SRC_DIR=../stashed

# this actually runs 2 major tasks, and produces two separate SQLite databases
# First, a compiled intermediary at:
#   data/compiled/osha_compiled.sqlite
# Then, the wrangled "final" version at:
#   data/wrangled/osha_wrangled.sqlite
```

## To update the stash

If you want to make your own mirror of the OSHA data, which officially updates every day/week, here's how you'd collect the data and then re-stash it:

```sh
make collect stash
```

Or:

```sh
make ALL
```


## Helpful references

- [Metadata for OSHA Enforcement Catalog (GSheets mirror)](https://docs.google.com/spreadsheets/d/1aHcSXSkPfUITRHE7Khsi-WuHbH2heYFXkb64DCRBiMo/edit#gid=1891906742)
- [Data dictionary for OSHA enforcement](https://docs.google.com/spreadsheets/d/1aHcSXSkPfUITRHE7Khsi-WuHbH2heYFXkb64DCRBiMo/edit#gid=0)

OSHA reference for accident/violation/inspection definitions:
https://www.osha.gov/data/inspection-detail-definitions#tab2

Accident search: https://www.osha.gov/pls/imis/AccidentSearch.search
https://www.osha.gov/pls/imis/accidentsearch.html
