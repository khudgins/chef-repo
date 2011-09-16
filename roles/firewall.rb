name "firewall"
description "Basic network firewall."
run_list(
  'recipe[avahi]',
  'recipe[firewall]',
  'recipe[dhcpd]'
)
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes(
#  :firewall => {
#    :interfaces => [
#      {
#       :iface => 'eth0',
#        :type => 'static',
#        :attributes => {
#          :address => '216.88.4.25',
#          :netmask => '255.255.240.0',
#          :broadcast => '216.88.15.255',
#          :gateway => '216.88.0.1'
#        }
#      },
#      {
#        :iface => 'eth0:0',
#        :type => 'static',
#        :attributes => {
#          :address => '216.88.4.26',
#          :netmask => '255.255.240.0',
#          :broadcast => '216.88.15.255',
#          :gateway => '216.88.0.1'
#        },
#        :forwarding => [
#          {
#            :external_port => '2222',
#            :target_address => '10.43.43.5',
#            :target_port => '22'
#          },
#          {
#            :external_port => '80',
#            :target_address => '10.43.43.5',
#            :target_port => '80'
#          }
#        ]
#      },
#      {
#        :iface => 'eth1',
#        :type => 'static',
#        :attributes => {
#          :address => '10.42.43.1',
#          :netmask => '255.255.255.0',
#          :broadcast => '10.42.43.255',
#          :network => '10.42.43.0'
#        }
#      },
#      {
#        :iface => 'eth2',
#        :type => 'dhcp',
#        :attributes => {}
#      }
#    ]
#  },
#  "dhcpd": {
#        "netmask": "255.255.255.0",
#        "domain": "shadowmoor.org",
#        "interfaces": [
#          "eth1"
#        ],
#        "nameservers": [
#          "8.8.8.8",
#          "8.8.4.4"
#        ],
#        "subnet": "10.42.43.0",
#        "range": [
#          "10.42.43.6",
#          "10.42.43.200"
#        ]
#      }
#    
#)

