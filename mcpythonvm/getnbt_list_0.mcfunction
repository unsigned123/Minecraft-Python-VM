#RESUME
data modify storage pvm:getnbt_list stack set value []
data modify storage pvm:getnbt_list localvar set value []
data modify storage pvm:getnbt_list return set value {}
data modify storage pvm:getnbt_list runtimeinfo set value {"package_name":"pvm","target_name":"getnbt_list"}
execute unless data storage pvm:global global_var[{"name":"_getnbt_single"}] run data modify storage pvm:global global_var[{"name":"_getnbt_single","value":0}]
execute unless data storage pvm:global global_var[{"name":"append"}] run data modify storage pvm:global global_var[{"name":"append","value":0}]
execute unless data storage pvm:getnbt_list localvar[{"name":"source"}] run data modify storage pvm:getnbt_list localvar append value {"name":"source","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"target"}] run data modify storage pvm:getnbt_list localvar append value {"name":"target","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"type_"}] run data modify storage pvm:getnbt_list localvar append value {"name":"type_","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"path"}] run data modify storage pvm:getnbt_list localvar append value {"name":"path","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"length"}] run data modify storage pvm:getnbt_list localvar append value {"name":"length","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"index"}] run data modify storage pvm:getnbt_list localvar append value {"name":"index","value":0}
execute unless data storage pvm:getnbt_list localvar[{"name":"result"}] run data modify storage pvm:getnbt_list localvar append value {"name":"result","value":0}
data modify storage pvm:getnbt_list localvar[0] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_list localvar[1] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_list localvar[2] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:getnbt_list localvar[3] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
#LOAD_GLOBAL
data modify storage pvm:getnbt_list stack append value {"data":{"package_name":"pvm","callee_name":"len","caller_name":"getnbt_list"},"type":"function","function":1}
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_GLOBAL
data modify storage pvm:getnbt_list stack append value {"data":{"package_name":"pvm","callee_name":"_getnbt_single","caller_name":"getnbt_list"},"type":"function","function":1}
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[0]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[1]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_CONST
data modify storage pvm:getnbt_list stack append value {"data":"list","type":"str","str":1}
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[3]
data remove storage pvm:getnbt_list stack[-1].name
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
function pvm:lib/caller with storage pvm:getnbt_list stack[-1].data
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
function pvm:lib/caller with storage pvm:getnbt_list stack[-1].data
#STORE_FAST
data modify storage pvm:getnbt_list localvar[4] set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
#LOAD_CONST
data modify storage pvm:getnbt_list stack append value {"data":0,"type":"int","int":1}
#STORE_FAST
data modify storage pvm:getnbt_list localvar[5] set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
#BUILD_LIST
data modify storage pvm:getnbt_list listbuf set value {"data":[],"type":"list","list":1}
data modify storage pvm:getnbt_list stack append value {"data":[],"type":"list","list":1}
data modify storage pvm:getnbt_list stack[-1] set from storage pvm:getnbt_list listbuf
#STORE_FAST
data modify storage pvm:getnbt_list localvar[6] set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[5]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[4]
data remove storage pvm:getnbt_list stack[-1].name
#COMPARE_OP
function pvm:lib/compare_op_normal {"operator":"<","package_name":"pvm","target_name":"getnbt_list"}
#POP_AND_JNE
execute store result storage pvm:getnbt_list_0 cmp long 1 run data get storage pvm:getnbt_list stack[-1].data
execute store result score vm cmp run data get storage pvm:getnbt_list_0 cmp
data remove storage pvm:getnbt_list stack[-1]
execute if score vm cmp = vm 0 run function pvm:getnbt_list_2
execute store result score vm cmp run data get storage pvm:getnbt_list_0 cmp
execute if score vm cmp = vm 1 run function pvm:getnbt_list_1
