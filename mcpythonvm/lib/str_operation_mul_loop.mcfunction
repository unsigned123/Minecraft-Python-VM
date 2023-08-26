execute unless score vm counter = vm 0 run scoreboard players operation vm counter -= vm 1
execute unless score vm counter = vm 0 run function pvm:lib/concat with storage pvm:concat concat
execute unless score vm counter = vm 0 run data modify storage pvm:concat concat.a set from storage pvm:concat result
execute unless score vm counter = vm 0 run function pvm:lib/str_operation_mul_loop