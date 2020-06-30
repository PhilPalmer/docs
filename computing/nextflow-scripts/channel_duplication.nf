#!/usr/bin/env nextflow

Channel
  .fromPath(params.input_path)
  .ifEmpty { exit 1, "${params.input_path} not found"}
  .into { inputChannel; inputChannel1; inputChannel2 }

inputChannel.println()
inputChannel1.println()
inputChannel2.println()