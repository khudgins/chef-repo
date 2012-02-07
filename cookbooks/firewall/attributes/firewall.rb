default[:firewall][:interfaces] = [
    {
      :iface => 'eth0',
      :type => 'static',
      :attributes => {
        :address => '216.126.34.206',
        :netmask => '255.255.255.192',
        :broadcast => '216.126.34.255',
        :gateway => '216.126.34.193'
      }
    },
    {
      :iface => 'eth0:0',
      :type => 'static',
      :attributes => {
        :address => '216.88.34.207',
        :netmask => '255.255.255.192',
        :broadcast => '216.126.34.255',
        :gateway => '216.126.34.193'
      },
      :forwarding => [
        {
          :external_port => '2222',
          :target_address => '10.43.43.5',
          :target_port => '22'
        },
        {
          :external_port => '80',
          :target_address => '10.43.43.5',
          :target_port => '80'
        }
      ]
    },
    {
      :iface => 'eth1',
      :type => 'static',
      :attributes => {
        :address => '10.42.44.1',
        :netmask => '255.255.255.0',
        :broadcast => '10.42.44.255',
        :network => '10.42.44.0'
      }
    },
    {
      :iface => 'eth2',
      :type => 'dhcp',
      :attributes => {}
    }
    
]
