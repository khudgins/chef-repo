name "phpserver"
    description "Systems that serve HTTP and HTTPS"
    run_list(
      "role[base]",
      "recipe[apache2]",
      "recipe[apache2::mod_ssl]",
      "recipe[php]",
      "recipe[php::module_mysql]",
      "recipe[apache2::mod_php5]",
      "recipe[mysql::client]"
    )
    default_attributes(
      "apache2" => {
        "listen_ports" => ["80", "443"]
      }
    )
