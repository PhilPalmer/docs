#!/usr/bin/env nextflow

Channel
  .fromPath(params.input_path)
  .map { file -> [file.baseName, file] }
  .ifEmpty { exit 1, "${params.input_path} not found"}
  .set { inputChannel }

inputChannel.println()