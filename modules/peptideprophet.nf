process peptideprophet {
    publishDir "${params.result_dir}", mode: 'move'
    container 'spctools/tpp:version5.2'
    
    input:
        path pepxml
        path fasta_decoy

    output:
        path ("*.interact.pep.xml")
        path ("*.interact.prot.xml")
        path ("*.interact.ipro.pep.xml")
        path ("*.interact.ipro.prot.xml")

    script:
    """
    xinteract -N${pepxml.simpleName}.interact.pep.xml -D${decoy_fasta} -p0.05 -l7 -PPM -OAp -dDECOY_ -ipP ${pepxml}
    ProteinProphet ${pepxml.simpleName}.interact.pep.xml ${pepxml.simpleName}.proteinprophet.prot.xml IPROPHET
    """
}
