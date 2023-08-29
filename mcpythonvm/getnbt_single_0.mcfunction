#RESUME
data modify storage pvm:getnbt_single stack set value []
data modify storage pvm:getnbt_single localvar set value []
data modify storage pvm:getnbt_single return set value {}
data modify storage pvm:getnbt_single runtimeinfo set value {"package_name":"pvm","target_name":"getnbt_single"}
execute unless data storage pvm:global global_var[{"name":"float"}] run data modify storage pvm:global global_var[{"name":"float","value":0}]
execute unless data storage pvm:global global_var[{"name":"_getnbt_single"}] run data modify storage pvm:global global_var[{"name":"_getnbt_single","value":0}]
execute unless data storage pvm:getnbt_single localvar[{"name":"source"}] run data modify storage pvm:getnbt_single localvar append value {"name":"source","value":0}
execute unless data storage pvm:getnbt_single localvar[{"name":"target"}] run data modify storage pvm:getnbt_single localvar append value {"name":"target","value":0}
execute unless data storage pvm:getnbt_single localvar[{"name":"type_"}] run data modify storage pvm:getnbt_single localvar append value {"name":"type_","value":0}
execute unless data storage pvm:getnbt_single localvar[{"name":"path"}] run data modify storage pvm:getnbt_single localvar append value {"name":"path","value":0}
data modify storage pvm:getnbt_single localvar[0] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_single localvar[1] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_single localvar[2] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_single localvar[3] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
#LOAD_FAST
data modify storage pvm:getnbt_single stack append from storage pvm:getnbt_single localvar[2]
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_CONST
data modify storage pvm:getnbt_single stack append value {"data":"float","type":"str","str":1}
#COMPARE_OP
function pvm:lib/compare_op_equal {"package_name":"pvm","target_name":"getnbt_single"}
#POP_AND_JNE
execute store result storage pvm:getnbt_single_0 cmp long 1 run data get storage pvm:getnbt_single stack[-1].data
execute store result score vm cmp run data get storage pvm:getnbt_single_0 cmp
data remove storage pvm:getnbt_single stack[-1]
execute if score vm cmp = vm 0 run function pvm:getnbt_single_2
execute store result score vm cmp run data get storage pvm:getnbt_single_0 cmp
execute if score vm cmp = vm 1 run function pvm:getnbt_single_1
