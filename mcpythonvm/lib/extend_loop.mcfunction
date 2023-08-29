execute unless score vm counter = vm 0 run data modify storage pvm:argbuf buf[1].data append from storage pvm:argbuf buf[0].data[0]
execute unless score vm counter = vm 0 run data remove storage pvm:argbuf buf[0].data[0]
execute unless score vm counter = vm 0 run scoreboard players operation vm counter -= vm 1
execute unless score vm counter = vm 0 run function pvm:lib/extend_loop

