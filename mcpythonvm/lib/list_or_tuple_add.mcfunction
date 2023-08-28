$data modify storage pvm:argbuf buf append from storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]
$data modify storage pvm:argbuf buf append from storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]
function pvm:extend_0
$data modify storage $(package_name):$(target_name) stack append from storage pvm:extend return