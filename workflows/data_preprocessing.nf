#!/usr/bin/env nextflow

//modules
include { msconvert } from "../modules/msconvert"
include { decoyfasta } from "../modules/decoyfasta"

workflow data_preprocessing{
    emit: 
        done

    main: 
        msconvert(Channel.fromList(files(params.raw)))
        decoyfasta(files(params.fasta))
        done = "done"
}