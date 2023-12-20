process comet {
    publishDir "${params.result_dir}", mode: 'move'
    container 'spctools/tpp:version5.2'
    
    input:
        path mzXML_file
        path comet_params
        path decoy_fasta
        

    output:
        path ("*.pep.xml"), emit: pepxml
        path ("*.interact.pep.xml"), emit: interact_pep_xml
        path ("*.interact.prot.xml"), emit: interact_prot_xml
        path ("*.interact.ipro.pep.xml"), emit: interact_ipro_pep_xml
        path ("*.interact.ipro.prot.xml"), emit: interact_ipro_prot_xml
        path ("*.interact.pep-MODELS.html"), emit: interact_pep_models
        path ("*.interact.prot-MODELS.html"), emit: interact_prot_models
        path ("*.interact.ipro.pep-MODELS.html"), emit: interact_ipro_pep_models
        path ("*.interact.ipro.prot-MODELS.html"), emit: interact_ipro_prot_models
    
    script:
    """
    comet -P${comet_params} -D${decoy_fasta} ${mzXML_file.simpleName}.mzXML
    xinteract -N${mzXML_file.simpleName}.interact.pep.xml -p0.05 -l7 -PPM -OAp -dDECOY_ -ipP ${mzXML_file.simpleName}.pep.xml

    """

}