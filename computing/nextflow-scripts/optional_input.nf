#!/usr/bin/env nextflow

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
