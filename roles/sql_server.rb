name "sql_server_standard"
description "SQL Server Stadard edition database master"
run_list(
  "recipe[sql_server::server]"
)
default_attributes(
  "sql_server" => {
    "accept_eula" => true
    # Optional
    # ,
    # "instance_name" => "MSSQLSERVER",
    # "product_key" => "YOUR_PRODUCT_KEY_HERE",
    # "server" => {
    #  "url" => "DOWNLOAD_LOCATION_OF_INSTALLATION_PACKAGE",
    #  "checksum" => "SHA256_OF_INSTALLATION_PACKAGE"
    # }
  }
)
