#!/usr/bin/env nextflow

process test {

  echo true

  script:
  optional_flag = params.optional_flag ? "--optional_flag $params.optional_flag" : ''
  """
  some_command.sh $optional_flag
  """
}
