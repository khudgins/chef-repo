name "masterchef"
description "Role for master chef server"
run_list(
  'role[base]',
  'recipe[nginx]',
  'recipe[dhcpd]'
)
override_attributes(
  :dhcpd => {
        :netmask => "255.255.255.0",
        :interfaces => ["eth0"],
        :subnet => "10.42.45.0",
        :range => [ "10.42.45.6", "10.42.45.200"],
        "nameservers" => [ "8.8.8.8", "8.8.4.4" ]
 
      }
)

