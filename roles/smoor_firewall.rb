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

)