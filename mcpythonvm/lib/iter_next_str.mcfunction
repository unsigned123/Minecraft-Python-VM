$data modify storage pvm:subscr subscr_str set value {start:$(index),end:0}
$scoreboard players set vm tos $(index)
scoreboard players operation vm tos += vm 1
execute store result storage pvm:subscr subscr_str.end int 1 run scoreboard players get vm tos
$data modify storage pvm:slicer slicer.str set from storage $(package_name):$(target_name) stack[-1].data.target
function pvm:lib/slicer with storage pvm:subscr subscr_str
data modify storage pvm:subscr subscr_str set value {"data":"","type":"str","str":1}
data modify storage pvm:subscr subscr_str.data set from storage pvm:slicer result
$data modify storage $(package_name):$(target_name) stack append from storage pvm:subscr subscr_str