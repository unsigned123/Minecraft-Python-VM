$execute unless score vm tos matches 0 run data remove storage $(package_name):$(target_name) stack[-3].data[-1]
execute unless score vm tos matches 0 run scoreboard players operation vm tos -= vm 1