$execute store result score vm tos run data get storage $(package_name):$(target_name) stack[-1].data 10000
$data remove storage $(package_name):$(target_name) stack[-1]
$execute store result score vm tos1 run data get storage $(package_name):$(target_name) stack[-1].data 10000
$data remove storage $(package_name):$(target_name) stack[-1]
$execute if score vm tos1 $(operator) vm tos run data modify storage $(package_name):$(target_name) stack append value {"data":1}
$execute unless score vm tos1 $(operator) vm tos run data modify storage $(package_name):$(target_name) stack append value {"data":0}