output "cluster_config_path" {
    value = data.ibm_container_cluster_config.config.config_file_path
}