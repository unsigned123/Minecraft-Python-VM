#RESUME
data modify storage pvm:get_entity stack set value []
data modify storage pvm:get_entity localvar set value []
data modify storage pvm:get_entity return set value {}
data modify storage pvm:get_entity runtimeinfo set value {"package_name":"pvm","target_name":"get_entity"}
execute unless data storage pvm:get_entity localvar[{"name":"selector"}] run data modify storage pvm:get_entity localvar append value {"name":"selector","value":0}
data modify storage pvm:get_entity localvar[0] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
#LOAD_GLOBAL
data modify storage pvm:get_entity stack append value {"data":{"package_name":"pvm","callee_name":"exec","caller_name":"get_entity"}}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"data modify storage pvm:get_handle handle_list set value {type:list,list:1,data:[]}","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
function pvm:lib/caller with storage pvm:get_entity stack[-1].data
#POP_TOP
data remove storage pvm:get_entity stack[-1]
#LOAD_GLOBAL
data modify storage pvm:get_entity stack append value {"data":{"package_name":"pvm","callee_name":"exec","caller_name":"get_entity"}}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"execute as ","type":"str","str":1}
#LOAD_FAST
data modify storage pvm:get_entity stack append from storage pvm:get_entity localvar[0]
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"get_entity"}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":" run function pvm:lib/get_handle","type":"str","str":1}
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"get_entity"}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
function pvm:lib/caller with storage pvm:get_entity stack[-1].data
#POP_TOP
data remove storage pvm:get_entity stack[-1]
#LOAD_GLOBAL
data modify storage pvm:get_entity stack append value {"data":{"package_name":"pvm","callee_name":"getnbt_single","caller_name":"get_entity"}}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"storage","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"pvm:get_handle","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"list","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:get_entity stack append value {"data":"handle_list.data","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
function pvm:lib/caller with storage pvm:get_entity stack[-1].data
#RETURN_VALUE
data modify storage pvm:get_entity return set from storage pvm:get_entity stack[-1]
data remove storage pvm:get_entity stack[-1]
