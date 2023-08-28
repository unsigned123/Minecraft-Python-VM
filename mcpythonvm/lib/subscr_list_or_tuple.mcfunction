$data modify storage pvm:subscr subscr set value {index:0,list:[],package_name:"$(package_name)",target_name:"$(target_name)"}
$data modify storage pvm:subscr subscr.index set from storage $(package_name):$(target_name) stack[-1].data
$data remove storage $(package_name):$(target_name) stack[-1]
$data modify storage pvm:subscr subscr.list set from storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]
function pvm:lib/subscr_core with storage pvm:subscr subscr