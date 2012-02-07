name "smoor_firewall"
description "Shadowmoor network firewall."
run_list(
  'recipe[avahi]',
  'role[firewall]',
  'recipe[dhcpd]'
)
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes(
  :firewall => {
    :interfaces => [
      {
       :iface => 'eth0',
        :type => 'static',
        :attributes => {
          :address => '216.126.34.206',
          :netmask => '255.255.255.192',
          :broadcast => '216.126.34.255',
          :gateway => '216.126.34.193'
        },
        :forwarding => [
          {
            :external_port => '80',
            :target_address => '10.42.43.6',
            :target_port => '80'
          },
          {
            :external_port => '25565',
            :target_address => '10.42.43.9',
            :target_port => '25565'
          }
        ]

      },
      {
        :iface => 'eth0:0',
        :type => 'static',
        :attributes => {
          :address => '216.126.34.207',
          :netmask => '255.255.255.192',
          :broadcast => '216.126.34.255',
          :gateway => '216.126.34.193'
        }
      },
      {
        :iface => 'eth1',
        :type => 'static',
        :attributes => {
          :address => '10.42.43.1',
          :netmask => '255.255.255.0',
          :broadcast => '10.42.43.255',
          :network => '10.42.43.0'
        }
      },
      {
        :iface => 'eth2',
        :type => 'dhcp',
        :attributes => {}
      }
    ]
  },
  :dhcpd => {
        :netmask => "255.255.255.0",
        :domain => "shadowmoor.org",
        :interfaces => ["eth1"],
        :nameservers => [ "8.8.8.8", "8.8.4.4" ],
        :subnet => "10.42.43.0",
        :range => [ "10.42.43.6", "10.42.43.200"],
        :routers=> "10.42.43.1",
	:max_lease_time => "7200"
      }
    
)

