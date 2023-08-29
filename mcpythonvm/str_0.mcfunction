data modify storage pvm:to_str to_str set value {data:0}
data modify storage pvm:to_str to_str.data set from storage pvm:argbuf buf[0].data
function pvm:lib/to_str with storage pvm:to_str to_str
data modify storage pvm:str return set value {data:"[str() ERROR]",str:1,"type":"str"}
#data modify storage pvm:str return.data set from storage pvm:to_str result
execute if data storage pvm:argbuf buf[0].int run data modify storage pvm:str return.data set from storage pvm:to_str result
#to remove "d"
execute if data storage pvm:argbuf buf[0].float run data modify storage pvm:str return.data set string storage pvm:to_str result 0 -1
execute if data storage pvm:argbuf buf[0].str run data modify storage pvm:str return.data set from storage pvm:argbuf buf[0].data