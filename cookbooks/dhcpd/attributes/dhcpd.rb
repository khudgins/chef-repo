default[:dhcpd][:version] = FALSE

default[:dhcpd][:interfaces] = [ 'eth0' ]
default[:dhcpd][:next_server] = nil
default[:dhcpd][:routers] = nil
default[:dhcpd][:netmask] = "255.255.254.0"
default[:dhcpd][:subnet] = '10.0.198.0'
default[:dhcpd][:range] = [ '10.0.199.201', '10.0.199.250' ]
default[:dhcpd][:default_leaser_time] = "600"
default[:dhcpd][:max_lease_time] = "7200"
default[:dhcpd][:filename] = nil
default[:dhcpd][:nameservers] = [ '10.0.198.11' ]
default[:dhcpd][:domain] = [ 'internal.mydomain.net' ]

