#LOAD_CONST
data modify storage pvm:myfunc stack append value {"data":0,"type":"None","none":1}
#RETURN_VALUE
data modify storage pvm:myfunc return set from storage pvm:myfunc stack[-1]
data remove storage pvm:myfunc stack[-1]
