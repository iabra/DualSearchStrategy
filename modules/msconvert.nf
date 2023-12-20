process msconvert {
    publishDir "${params.result_dir}", mode: 'move'
    container 'chambm/pwiz-skyline-i-agree-to-the-vendor-licenses:3.0.22335-b595b19'
    
    input:
        path raw_file 
    
    output:
       path ("*.mzXML"), emit: mzXML
    
    script:
    """ 
    wine msconvert "${raw_file}" -v --mzXML --64
    """
}