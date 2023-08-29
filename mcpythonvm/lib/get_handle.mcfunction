scoreboard players add vm handle 1
execute unless score @s handle matches 0.. store result score @s handle run scoreboard players get vm handle
data modify storage pvm:get_handle handle_buf set value {type:"int",int:1,data:-1}
execute store result storage pvm:get_handle handle_buf.data int 1 run scoreboard players get @s handle
data modify storage pvm:get_handle handle_list.data append from storage pvm:get_handle handle_buf