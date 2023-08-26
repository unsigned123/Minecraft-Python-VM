data modify storage pvm:concat concat set value {a:"",b:""}
$data modify storage pvm:concat concat.a set from storage $(package_name):$(target_name) stack[-2].data
$data modify storage pvm:concat concat.b set from storage $(package_name):$(target_name) stack[-1].data
function pvm:lib/concat with storage pvm:concat concat
$data remove storage $(package_name):$(target_name) stack[-1]
$data modify storage $(package_name):$(target_name) stack[-1].data set from storage pvm:concat result