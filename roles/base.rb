name "base"
description "Baseline role - all nodes should get this."
run_list(
  'recipe[avahi]'
)