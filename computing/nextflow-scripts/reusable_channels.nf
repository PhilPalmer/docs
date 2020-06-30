#!/usr/bin/env nextflow

inputChannel = Channel.value(file(params.input_path))

// Channel can be used multiple times
inputChannel.println()
inputChannel.println()

process test {
  tag "$input_path"
  echo true

  input:
  file(input_path) from inputChannel

  script:
  """
  echo $input_path
  """
}