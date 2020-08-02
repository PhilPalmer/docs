#!/usr/bin/env nextflow

process test {

  echo true

  script:
  extra_flags = ''
  if ( params.optional_flag  ) { extra_flags += " --optional_flag  ${params.optional_flag}"  }
  if ( params.optional_flag2 ) { extra_flags += " --optional_flag2 ${params.optional_flag2}" }
  if ( params.optional_flag3 ) { extra_flags += " --optional_flag3 ${params.optional_flag3}" }
  """
  some_command.sh $extra_flags
  """
}