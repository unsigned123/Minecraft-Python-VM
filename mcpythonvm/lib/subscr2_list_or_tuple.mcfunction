#start(NoneType is seen as 0)
$execute if data storage $(package_name):$(target_name) stack[-2].none run data modify storage $(package_name):$(target_name) stack[-2].data set value 0
$execute store result score vm counter run data get storage $(package_name):$(target_name) stack[-2].data
#len(TOS2)
$execute store result score vm tos run data get storage $(package_name):$(target_name) stack[-3].data
#process negative indexes:+=len(TOS2)
execute if score vm counter < vm 0 run scoreboard players operation vm counter += vm tos
#end(NoneType is seen as -1)
$execute if data storage $(package_name):$(target_name) stack[-1].none run data modify storage $(package_name):$(target_name) stack[-1].data set value -1
$execute store result score vm tos1 run data get storage $(package_name):$(target_name) stack[-1].data
execute if score vm tos1 < vm 0 run scoreboard players operation vm tos1 += vm tos

#now:counter=start tos1=end tos=len(TOS2)

#if start >= end
$execute if score vm counter >= vm tos1 run data remove storage $(package_name):$(target_name) stack[-1]
$execute if score vm counter >= vm tos1 run data remove storage $(package_name):$(target_name) stack[-1]
$execute if score vm counter >= vm tos1 run data modify storage $(package_name):$(target_name) stack[-1].data set value []
execute if score vm counter >= vm tos1 run return 0

#head-erase loop
$function pvm:lib/subscr2_corehloop {"package_name":"$(package_name)","target_name":"$(target_name)"}

#end-earse loop
#earse (len(TOS2) - end) items
#now:counter=0 tos1=end tos=len(TOS2)
scoreboard players operation vm tos -= vm tos1
#now tos serves as the counter
$function pvm:lib/subscr2_coreeloop {"package_name":"$(package_name)","target_name":"$(target_name)"}

$data remove storage $(package_name):$(target_name) stack[-1]
$data remove storage $(package_name):$(target_name) stack[-1]