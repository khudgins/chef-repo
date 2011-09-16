name "smoor_firewall"
description "Shadowmoor network firewall."
run_list(
  'recipe[avahi]',
  'recipe[firewall]'
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
        :address => '216.88.4.25',
        :netmask => '255.255.240.0',
        :broadcast => '216.88.15.255',
        :gateway => '216.88.0.1'
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
  }  
)
