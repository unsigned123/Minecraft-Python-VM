#NoneType:start=0
data modify storage pvm:subscr subscr_str set value {start:0,end:-1}
$execute store result score vm tos run data get storage $(package_name):$(target_name) stack[-3].data
execute store result storage pvm:subscr subscr_str.end int 1 run scoreboard players get vm tos
$execute unless data storage $(package_name):$(target_name) stack[-1].none store result storage pvm:subscr subscr_str.end int 1 run data get storage $(package_name):$(target_name) stack[-1].data
$execute unless data storage $(package_name):$(target_name) stack[-2].none store result storage pvm:subscr subscr_str.start int 1 run data get storage $(package_name):$(target_name) stack[-2].data
$data modify storage pvm:slicer slicer.str set from storage $(package_name):$(target_name) stack[-3].data
function pvm:lib/slicer with storage pvm:subscr subscr_str
$data remove storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]
data modify storage pvm:subscr subscr_str set value {"data":"","type":"str","str":1}
data modify storage pvm:subscr subscr_str.data set from storage pvm:slicer result
$data modify storage $(package_name):$(target_name) stack append from storage pvm:subscr subscr_str
