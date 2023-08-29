#LOAD_GLOBAL
data modify storage pvm:getnbt_single stack append value {"data":{"package_name":"pvm","callee_name":"float","caller_name":"getnbt_single"},"type":"function","function":1}
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_GLOBAL
data modify storage pvm:getnbt_single stack append value {"data":{"package_name":"pvm","callee_name":"str","caller_name":"getnbt_single"},"type":"function","function":1}
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_GLOBAL
data modify storage pvm:getnbt_single stack append value {"data":{"package_name":"pvm","callee_name":"_getnbt_single","caller_name":"getnbt_single"},"type":"function","function":1}
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_single stack append from storage pvm:getnbt_single localvar[0]
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_FAST
data modify storage pvm:getnbt_single stack append from storage pvm:getnbt_single localvar[1]
data remove storage pvm:getnbt_single stack[-1].name
#LOAD_CONST
data modify storage pvm:getnbt_single stack append value {"data":"list","type":"str","str":1}
#LOAD_FAST
data modify storage pvm:getnbt_single stack append from storage pvm:getnbt_single localvar[3]
data remove storage pvm:getnbt_single stack[-1].name
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
function pvm:lib/caller with storage pvm:getnbt_single stack[-1].data
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
function pvm:lib/caller with storage pvm:getnbt_single stack[-1].data
#PRECALL
#CALL
data modify storage pvm:argbuf buf set value []
data modify storage pvm:argbuf buf append from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
function pvm:lib/caller with storage pvm:getnbt_single stack[-1].data
#RETURN_VALUE
data modify storage pvm:getnbt_single return set from storage pvm:getnbt_single stack[-1]
data remove storage pvm:getnbt_single stack[-1]
function pvm:getnbt_single_2