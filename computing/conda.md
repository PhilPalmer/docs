---
title: Conda
linktitle: Conda
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  computing:
    parent: Bioinformatics
    weight: 2

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 2
---

![conda_logo](../images/conda_logo.svg)

*Conda is a package management system that makes installing tools trivial by installing all of their dependencies.* See the [official documentation](https://docs.conda.io/en/latest/) and [installation details](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)

## Install conda package
```bash
conda install -c $channel ${package}=${version}
conda install -c bioconda fastqc=0.11.8 # example
```

## Create conda environment
```bash
conda env create --name $env_name --file environment.yml 
```

## Save conda environment
```bash
conda env export --no-builds | grep -v "^prefix: " > environment.yml
```


## Activate conda environment
```bash
source activatate $env_name
```