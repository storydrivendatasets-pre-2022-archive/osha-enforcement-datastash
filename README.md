# OSHA Enforcement Datastash


Downloads all the CSVs found at the Dept. of Labor OSHA data catalog, which is about ~650MB zipped and ~5GB unzipped:

https://enforcedata.dol.gov/views/data_summary.php ([mirror](https://enforcedata.dol.gov/views/data_summary.php))

It then slices (i.e. "[stash](scripts/stash.py)") them into pieces small enough to upload onto Github, i.e. under 15MB (which is well under the 100MB-per-file limit) 

The data can be found in the [data/stashed](data/stashed) folder, with each zip file getting its own subdirectory, e.g. [data/stashed/inspection](data/stashed/inspection)

## Purpose of this repo

This repo is meant as a sort of backup snapshot for [storydrivendatasets/osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler), which has the same `make collect` process for locally downloading the files. But if for some reason you can't run that script – or if the OSHA catalog drastically changes, then you can run the rest of [osha-enforcement-wrangler](https://github.com/storydrivendatasets/osha-enforcement-wrangler) on this repo:


```sh
mkdir worky && cd worky

git clone https://github.com/storydrivendatasets/osha-enforcement-wrangler


```

## To update the stash

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
