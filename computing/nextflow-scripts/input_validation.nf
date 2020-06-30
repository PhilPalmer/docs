#!/usr/bin/env nextflow

if (!params.important_parameter) exit 1, "The params `--important_parameter` has not set.\n\tPlease provide a valid value for this parameter"