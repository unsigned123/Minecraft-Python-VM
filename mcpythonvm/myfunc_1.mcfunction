#FOR_ITER
execute store result score vm counter run data get storage pvm:myfunc stack[-1].data.index
scoreboard players operation vm counter += vm 1
data modify storage pvm:iter iter set value {"index":-1,"package_name":"pvm","target_name":"myfunc"}
execute store result storage pvm:iter iter.index int 1 run scoreboard players get vm counter
execute store result storage pvm:myfunc stack[-1].data.index int 1 run scoreboard players get vm counter
execute store result score vm tos run data get storage pvm:myfunc stack[-1].data.index
execute store result score vm tos1 run data get storage pvm:myfunc stack[-1].data.length
execute if score vm tos < vm tos1 run data modify storage pvm:myfunc_1 cmp set value 1
execute if score vm tos >= vm tos1 run data modify storage pvm:myfunc_1 cmp set value 0
execute store result score vm cmp run data get storage pvm:myfunc_1 cmp
execute if score vm cmp = vm 0 run data remove storage pvm:myfunc stack[-1]
execute if score vm cmp = vm 0 run function pvm:myfunc_3
execute store result score vm cmp run data get storage pvm:myfunc_1 cmp
execute if score vm cmp = vm 1 run function pvm:lib/iter_next with storage pvm:iter iter
execute if score vm cmp = vm 1 run function pvm:myfunc_2
