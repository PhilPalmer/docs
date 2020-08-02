#!/usr/bin/env nextflow

Channel
  .fromPath(params.vcf_paths)
  .ifEmpty { exit 1, "Cannot find CSV file : ${params.vcf_paths}" }
  .splitCsv(skip:1)
  .map { sample_id,vcf,index -> [ file(vcf) ] }
  .set { vcfs }

process test {

  input:
  file(vcfs) from vcfs.collect()

  script:
  """
  echo "${vcfs.join("\n")}" > vcfs.txt
  """
}