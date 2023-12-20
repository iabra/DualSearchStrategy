process decoyfasta {
    publishDir "${params.result_dir}", mode: 'copy'
    container 'spctools/tpp:version5.2'
    
    input: 
        path fasta_file
    
    output:
        path("${fasta_file.baseName}_DECOY.fasta")

script:
"""
    decoyFASTA -t DECOY_ ${fasta_file} ${fasta_file.baseName}_DECOY.fasta
"""
}