#RESUME
data modify storage pvm:myfunc stack set value []
data modify storage pvm:myfunc localvar set value []
data modify storage pvm:myfunc return set value {}
data modify storage pvm:myfunc runtimeinfo set value {"package_name":"pvm","target_name":"myfunc"}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"1","type":"str","str":1}
#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":"1","type":"str","str":1}
#COMPARE_OP
function pvm:lib/compare_op_equal {"package_name":"pvm","target_name":"myfunc"}
#RETURN_VALUE
data modify storage pvm:myfunc return set from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
