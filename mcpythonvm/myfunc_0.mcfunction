#RESUME
data modify storage pvm:myfunc stack set value []
data modify storage pvm:myfunc localvar set value []
data modify storage pvm:myfunc return set value {}
data modify storage pvm:myfunc runtimeinfo set value {"package_name":"pvm","target_name":"myfunc"}
execute unless data storage pvm:global global_var[{"name":"append"}] run data modify storage pvm:global global_var[{"name":"append","value":0}]
execute unless data storage pvm:myfunc localvar[{"name":"a"}] run data modify storage pvm:myfunc localvar append value {"name":"a","value":0}
execute unless data storage pvm:myfunc localvar[{"name":"b"}] run data modify storage pvm:myfunc localvar append value {"name":"b","value":0}
data modify storage pvm:myfunc localvar[0] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
data modify storage pvm:myfunc localvar[1] set from storage pvm:argbuf buf[-1]
data remove storage pvm:argbuf buf[-1]
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"print","caller_name":"myfunc"}}
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"append","caller_name":"myfunc"}}
#BUILD_LIST
data modify storage pvm:myfunc listbuf set value {"data":[],"type":"list","list":1}
data modify storage pvm:myfunc stack append value {"data":[],"type":"list","list":1}
data modify storage pvm:myfunc stack[-1] set from storage pvm:myfunc listbuf
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":[],"type":"tuple","tuple":1}
data modify storage pvm:myfunc stack[-1].data append value {"data":"a","type":"str","str":1}
data modify storage pvm:myfunc stack[-1].data append value {"data":"b","type":"str","str":1}
data modify storage pvm:myfunc stack[-1].data append value {"data":"c","type":"str","str":1}
#LIST_EXTEND
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:extend_0
data modify storage pvm:myfunc stack append from storage pvm:extend return
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"d","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":1,"type":"int","int":1}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":0,"type":"None","none":1}
#BUILD_SLICE
#BINARY_SUBSCR
function pvm:lib/subscr2 {"package_name":"pvm","target_name":"myfunc"}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#POP_TOP
data remove storage pvm:myfunc stack[-1]
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"strcat","caller_name":"myfunc"}}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"abc","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"d","type":"str","str":1}
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":1,"type":"int","int":1}
#BINARY_SUBSCR
function pvm:lib/subscr {"package_name":"pvm","target_name":"myfunc"}
#RETURN_VALUE
data modify storage pvm:myfunc return set from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
