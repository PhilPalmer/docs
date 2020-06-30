#!/usr/bin/env nextflow

Channel
  .fromPath(params.regions)
  .ifEmpty { exit 1, "Cannot find file : ${params.regions}" }
  .splitText()
  .map { it -> it.trim() }
  .set { regions }

regions.println()