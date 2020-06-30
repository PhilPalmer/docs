---
title: Nextflow
linktitle: Nextflow
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

![nextflow_logo](../images/nextflow_logo.png)

*Nextflow is a workflow management system that allows you to build highly parallelizable & scalable computational pipelines*

# Advatanges

Advantages of using Nextflow (and workflow managers in general) is that they help make workflows more:
- Portable
  - Thanks in part to it's built-in support of containers Nextflow pipelines can be run in a portable manner across different instructure be it Cloud, local or HPC
- Reproducible
  - Thanks in part to it's built-in support of containers such as Docker & Singularity
- Scalable
  - Thanks in part to Nextflow's built-in parallelism as it's built on the data flow programming model

There are other workflow management systems such as [Snakemake](https://snakemake.readthedocs.io/en/stable/), [CWL](https://www.commonwl.org/) and [WDL](https://github.com/openwdl/wdl#getting-started-with-wdl), however, I am by far more familiar with [Nextflow](https://www.nextflow.io/index.html). Some of the main advantages of each are that Nextflow benefits from lots of community support (see [nf-core](https://nf-co.re/)), Snakemake is written in [Python](../python) and CWL/WDL benefits from support from the [Broad Institute](https://www.broadinstitute.org/).

# Basics

The basic pipeline structure is as follows:
1) Pipeline (main script)
    - Channels
    - Processes
        - Input
        - Output
        - Script
2) Configuration

See the [Official documentation](https://www.nextflow.io/docs/latest/index.html) & [Nextflow tutorial](https://github.com/lifebit-ai/jax-tutorial)


# Patterns

You can find Nextflow scripts for each of the examples here: https://github.com/PhilPalmer/docs/tree/master/computing/nextflow-scripts

*Inspired by [Nextflow patterns](http://nextflow-io.github.io/patterns/index.html)*

## Inputs

### Split text input
Create a channel from a plain text file split line by line
```
Channel
  .fromPath(params.regions)
  .ifEmpty { exit 1, "Cannot find file : ${params.regions}" }
  .splitText()
  .map { it -> it.trim() }
  .set { regions }
```

Run it:
```bash
nextflow run split_text_input.nf
```

### CSV input
Create a channel from a CSV file input
```
Channel
  .fromPath(params.vcf_paths)
  .ifEmpty { exit 1, "Cannot find CSV file : ${params.vcf_paths}" }
  .splitCsv(skip:1)
  .map { sample_id,vcf,index -> [sample_id,file(vcf),file(index)] }
  .set { vcfs }
```

Run it:
```bash
nextflow run csv_input.nf
```

### Reusable channels
Nextflow consumes (queue) channels meaning that they are consumed on use. However, it is possible to prevent needing to duplicate channels by creating value channels instead like so!
```
inputChannel = Channel.value(file(params.input_path))

// Channel can be used multiple times
inputChannel.println()
inputChannel.println()
```

Run it:
```bash
nextflow run reusable_channels.nf
```

### Channel duplication
Sometimes you may need to duplicate a channel. This is espeically true if it's a channel which contains multiple values (and/or is a queue channel) because these are consumed by Nextflow on use
```
Channel
  .fromPath(params.input_path)
  .ifEmpty { exit 1, "${params.input_path} not found"}
  .into { inputChannel; inputChannel1; inputChannel2 }
```

Run it:
```bash
nextflow run channel_duplication.nf
```

### Get basename
Get the basename (i.e. the name filename minus the file extension) of a file in a channel. *You can also use `simpleName` to get everything prior to the first period (`.`)*
```
Channel
  .fromPath(params.input_path)
  .map { file -> [file.baseName, file] }
  .ifEmpty { exit 1, "${params.input_path} not found"}
  .set { inputChannel }
```

Run it:
```bash
nextflow run get_basename.nf
```

### Input validation
```
if (!params.important_parameter) exit 1, "The params `--important_parameter` has not been set.\n\tPlease provide a valid value for this parameter"
```

Run it:
```bash
nextflow run input_validation.nf
```

---

## Processes

### Conditional input files
Nextflow does not like having conditional input files for processes. Fortunately you can use optional input files like so
```
optional_input_path = params.optional_input_path ? params.optional_input_path : 'data/no_file.txt'

Channel
  .fromPath(optional_input_path)
  .ifEmpty { exit 1, "${optional_input_path} not found"}
  .set { optionalInputChannel }

process test {

  echo true

  input:
  file(optional_input) from optionalInputChannel

  script:
  optional_flag = optional_input != 'no_file.txt' ? "--optional_input $optional_input" : ''
  """
  some_command.sh $optional_flag
  """
}
```

Run it:
```bash
nextflow run optional_input.nf
```

### Conditional flags
Here the `optional_flag` will only be present if the user has set the `optional_flag` Nextflow parameter
```
process test {

  echo true

  script:
  optional_flag = params.optional_flag ? "--optional_flag $params.optional_flag" : ''
  """
  some_command.sh $optional_flag
  """
}
```

Run it:
```bash
nextflow run optional_input.nf
```

### Extra flags

### Last index of

---

## Transforming operators

### Reduce channel

https://github.com/lifebit-ai/genetic-traits/blob/master/main.nf#L157

### Complex mapping

---

## Debugging

### Printing channel

### Touch files

---

## Output

### PublishDir

https://github.com/lifebit-ai/genetic-traits/blob/master/main.nf#L204-L210

---

## Groovy

### Helper functions
```
// define helper functions
def isMode(mode) {
  params.mode.toLowerCase().contains(mode)
}
def isTsv() {
  params.reads.endsWith('tsv')
}
def get_pairs_simplename(simplename) {
  simplename = simplename.endsWith('_1') ? simplename.substring(0, simplename.length() - 2) : simplename
  simplename = simplename.endsWith('_R1') ? simplename.substring(0, simplename.length() - 3) : simplename
  return simplename
}
```

---

## Configuration

### Genomes config

### Cloud create

You can use Nextflow to launch an AWS instance (in this case one to run [Dragen](https://aws.amazon.com/marketplace/pp/Illumina-Inc-DRAGEN-Complete-Suite/B07CZ3F5HY))

`cloud-spot.config`:
```
aws {
  accessKey = ''
  secretKey = ''
  region = 'eu-west-1'
}
cloud {
  imageId = 'ami-0ba4b94467989e99a'
  instanceType = 'f1.4xlarge'
  userName = 'centos'
  keyName = 'dragen'
  bootStorageSize = '100 GB'
}
```

Run it:
```bash
nextflow -c cloud-spot.config cloud create cluster_name -c 1
```

# Tips
- `nextflow console`
- `log.info`

# Useful operators

`groupTuple()`

`combine()` (by)

`map()`
Swiss army knife
Re-order or reduce channels (although Nextflow also provides a `reduce` function)

`set()`

`into()`

`.set()`

[`collect()`](https://www.nextflow.io/docs/latest/operator.html#collect)

`splitCsv()`

`merge()`

`flatten()`

`choice()`
