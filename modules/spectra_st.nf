process create_library{
    publishDir "${params.result_spectrast_dir}", mode: 'move'
    container 'spctools/tpp:version5.2'
     
     input:
        path pepxml_files
        
    output:
        path ("*.pepidx"), emit: pepidx
        path ("*.spidx"), emit: spidx
        path ("*.splib"), emit: splib
        path ("*.sptxt"), emit: sptxt
        
    script:
    """
    spectrast -cNpooled_lib -cJU -cAC -cAQ -cAD -cc -cy1 -cP0.9 ${pepxml_files}
    """
}

process library_search{
    publishDir "${params.result_spectrast_dir}", mode: 'move'
    container 'spctools/tpp:version5.2'
     
     input:
        path splib_file
        path mzxml_file
        path fasta

    output:
        path ("*.pep.xml"), emit: pep_xml
    script:
    """
    spectrast  -sL${splib_file} -sD${fasta} -sTAA -sM0.05 -sA! -s_HOM4 -sR! -sEpep.xml -sO${params.results_spectrast_dir} ${mzxml_file}
    xinteract  -N${mzxml_file.baseName}.spectrast.pep.xml  -p0.05 -l7 -PPM -OAp -dDECOY_ -ipP ${mzxml_file.baseName}.pep.xml

    """

}