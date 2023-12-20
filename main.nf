#!/usr/bin/env nextflow

//modules
include { msconvert } from "./modules/msconvert"
include { decoyfasta } from "./modules/decoyfasta"
include { comet } from "./modules/comet"
include { create_library } from "./modules/spectra_st"
include { library_search } from "./modules/spectra_st"

//workflow
workflow {
    //check and make output dir if necessary
    if(!file(params.result_db_dir).exists()){
        file(params.result_db_dir).mkdir()
    }

    //data processing 
    mzXML_files = msconvert(Channel.fromList(files(params.raw)))
    fasta = decoyfasta(file(params.fasta))
    
    //comet database search
    //instead of using 'mzXML' or 'fasta' as input, search for files ending in relevant extension (because I have to manually run one process at a time right now)
    comet_results = comet(Channel.fromList(files("${params.result_db_dir}/*.mzXML")),file(params.comet_params),file("${params.result_db_dir}/*_DECOY.fasta"))

    //manually filter comet results for 1% FDR confidence
    //add filtered comet results to specified directory with specified file ending, as per nextflow.config

    //create spectral library
    create_library(files(${params.fdr_filtered}))

    //run library search
    spectral_search = library_search(file("${params.result_spectrast_dir}/*.splib"), Channel.fromList(files("${params.result_db_dir}/*.mzXML")),file("${params.result_db_dir}/*_DECOY.fasta"))

    //manually filter spectrast results for 1% FDR confidence

    //open PaCOM and load 1% FDR database (comet) results vs 1% FDR library (spectrast) results
    //manually copy results to summary table

}