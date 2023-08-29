#LOAD_FAST
data modify storage pvm:getnbt_list stack append from storage pvm:getnbt_list localvar[6]
data remove storage pvm:getnbt_list stack[-1].name
#RETURN_VALUE
data modify storage pvm:getnbt_list return set from storage pvm:getnbt_list stack[-1]
data remove storage pvm:getnbt_list stack[-1]
