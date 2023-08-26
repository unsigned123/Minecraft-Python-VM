data modify storage pvm:concat concat set value {a:"",b:""}
data modify storage pvm:concat concat.a set from storage pvm:argbuf buf[1].data
data modify storage pvm:concat concat.b set from storage pvm:argbuf buf[0].data
function pvm:concat with storage pvm:concat concat
data modify storage pvm:concat return set value {"data":""}
data modify storage pvm:strcat return.data set from storage pvm:concat result