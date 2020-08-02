#!/usr/bin/env nextflow

Channel
  .fromPath(params.vcf_paths)
  .ifEmpty { exit 1, "Cannot find CSV file : ${params.vcf_paths}" }
  .splitCsv(skip:1)
  .map { sample_id,vcf,index -> [ sample_id,file(vcf),file(index) ] }
  .set { samp }
