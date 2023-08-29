#LOAD_GLOBAL
data modify storage pvm:getnbt_list stack append value {"data":{"package_name":"pvm","callee_name":"append","caller_name":"getnbt_list"},"type":"function","function":1}
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[6]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_GLOBAL
data modify storage pvm:getnbt_list stack append value {"data":{"package_name":"pvm","callee_name":"getnbt_single","caller_name":"getnbt_list"},"type":"function","function":1}
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[0]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[1]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[2]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[3]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_CONST
data modify storage pvm:getnbt_list stack append value {"data":"[","type":"str","str":1}
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"getnbt_list"}
#LOAD_GLOBAL
data modify storage pvm:getnbt_list stack append value {"data":{"package_name":"pvm","callee_name":"str","caller_name":"getnbt_list"},"type":"function","function":1}
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[5]
data remove storage pvm:getnbt_list stack[-1].name
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
function pvm:lib/caller with storage pvm:getnbt_list stack[-1].data
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"getnbt_list"}
#LOAD_CONST
data modify storage pvm:getnbt_list stack append value {"data":"]","type":"str","str":1}
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"getnbt_list"}
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
data modify storage pvm:argbuf buf append from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
function pvm:lib/caller with storage pvm:getnbt_list stack[-1].data
#STORE_FAST
data modify storage pvm:getnbt_list localvar[6] set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[5]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_CONST
data modify storage pvm:getnbt_list stack append value {"data":1,"type":"int","int":1}
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"getnbt_list"}
#STORE_FAST
data modify storage pvm:getnbt_list localvar[5] set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[5]
data remove storage pvm:getnbt_list stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[4]
data remove storage pvm:getnbt_list stack[-1].name
#COMPARE_OP
function pvm:lib/compare_op_normal {"operator":"<","package_name":"pvm","target_name":"getnbt_list"}
#POP_AND_JE
execute store result storage pvm:getnbt_list_1 cmp long 1 run data get storage pvm:getnbt_list stack[-1].data
execute store result score vm cmp run data get storage pvm:getnbt_list_1 cmp
data remove storage pvm:getnbt_list stack[-1]
execute if score vm cmp = vm 1 run function pvm:getnbt_list_1
execute store result score vm cmp run data get storage pvm:getnbt_list_1 cmp
execute if score vm cmp = vm 0 run function pvm:getnbt_list_2
