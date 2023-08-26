#RESUME
data modify storage pvm:myfunc stack set value []
data modify storage pvm:myfunc localvar set value []
data modify storage pvm:myfunc return set value {}
data modify storage pvm:myfunc runtimeinfo set value {"package_name":"pvm","target_name":"myfunc"}
execute unless data storage pvm:argbuf buf run data modify storage pvm:myfunc localvar set from storage pvm:argbuf buf
execute unless data storage pvm:myfunc localvar[{"name":"a"}] run data modify storage pvm:myfunc localvar append value {"name":"a","value":0}
execute unless data storage pvm:myfunc localvar[{"name":"b"}] run data modify storage pvm:myfunc localvar append value {"name":"b","value":0}
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"strcat","caller_name":"myfunc"}}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"b","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"c","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":2,"type":"int","int":1}
#BINARY_OP
function pvm:lib/operator_mul {"package_name":"pvm","target_name":"myfunc"}
data modify storage pvm:argbuf buf set value []
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"str","caller_name":"myfunc"}}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"a","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"myfunc"}
data modify storage pvm:argbuf buf set value []
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"str","caller_name":"myfunc"}}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":1,"type":"int","int":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#BINARY_OP
function pvm:lib/operator_add {"package_name":"pvm","target_name":"myfunc"}
data modify storage pvm:argbuf buf set value []
#RETURN_VALUE
data modify storage pvm:myfunc return set from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
