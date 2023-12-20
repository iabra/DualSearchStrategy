process extract_probability_thresh { 

    input:
    file inputFile
    path rawfile

    output:
    val(value) result

    script:
    """
    start_line=\$(grep -n "<tr class='thead'><th>Error_Rate</th><th>min_prob</th><th>num_correct</th><th>num_incorrect</th></tr>" \${inputFile} | cut -d: -f1)
    value=\$(sed -n "\${start_line},/<tr><td>0\\.01/ p" \${inputFile} | awk -F"</?td>" '\$4 < 0.01 {print \$5; exit}')
    echo "\${value}" > result
    """
}