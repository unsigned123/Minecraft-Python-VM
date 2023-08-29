#STORE_FAST
data modify storage pvm:myfunc localvar[2] set from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
#LOAD_GLOBAL
data modify storage pvm:myfunc stack append value {"data":{"package_name":"pvm","callee_name":"print","caller_name":"myfunc"},"type":"function","function":1}
data remove storage pvm:myfunc stack[-1].name
#LOAD_FAST
data modify storage pvm:myfunc stack append from storage pvm:myfunc localvar[2]
data remove storage pvm:myfunc stack[-1].name
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
function pvm:lib/caller with storage pvm:myfunc stack[-1].data
#POP_TOP
data remove storage pvm:myfunc stack[-1]
#JUMP
function pvm:myfunc_1
