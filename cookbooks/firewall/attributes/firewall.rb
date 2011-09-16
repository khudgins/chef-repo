default[:firewall][:interfaces] = [
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