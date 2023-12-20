#!/usr/bin/env nextflow

//modules
include { comet } from "../modules/comet"

workflow run_db_search{
    fasta = files("${params.result_dir}/*_DECOY.fasta")
    mzXML_files = files("${params.result_dir}/*.mzXML")
    
    comet(Channel.fromList(mzXML_files), file(params.comet_params), fasta)
}