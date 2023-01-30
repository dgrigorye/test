## Simple workflow to do single cell sequencing

version 1.0

workflow ScatterSingleCell {
    input {
        String docker_image
        Array[File] input_h5s
    }

    scatter(input_h5 in input_h5s) {
    call ProcessOneH5 {
        input:
            docker_image = docker_image,
            input_h5 = input_h5
        }
    }
    output {
        Array[File] count_matrix_h5ad = ProcessOneH5.count_matrix
        Array[File] umap_png = ProcessOneH5.umap
        Array[File] gene_rank_png = ProcessOneH5.rank_genes
    }
}

task ProcessOneH5 {
    input {
        String docker_image
        File input_h5
    }

    String base_filename = basename(input_h5, ".h5")

    command {
        cp ${input_h5} .
        python /reporting/process_scanpy.py ${input_h5}
    }

    output {
        File count_matrix = "count_matrix_~{base_filename}.h5"
        File umap = "figures/umap_~{base_filename}.png"
        File rank_genes = "figures/rank_genes_groups_leiden_~{base_filename}.png"
    }

    runtime {
        docker: docker_image
    }
}
