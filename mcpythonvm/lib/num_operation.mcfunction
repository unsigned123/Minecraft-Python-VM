$execute store result score vm tos run data get storage $(package_name):$(target_name) stack[-1].data 10000
$data remove storage $(package_name):$(target_name) stack[-1]
$execute store result score vm tos1 run data get storage $(package_name):$(target_name) stack[-1].data 10000
$scoreboard players operation vm tos $(operation) vm tos1
$execute store result storage $(package_name):$(target_name) stack[-1].data int 0.0001 run scoreboard players get vm tos