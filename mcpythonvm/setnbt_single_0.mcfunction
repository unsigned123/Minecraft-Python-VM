data modify storage pvm:set_nbt path set value ""
data modify storage pvm:set_nbt type set value ""
data modify storage pvm:set_nbt target set value ""
data modify storage pvm:set_nbt source set value ""

#set_nbt(source,target,type,path,value)

data modify storage pvm:set_nbt source set from storage pvm:argbuf buf[4].data
data modify storage pvm:set_nbt target set from storage pvm:argbuf buf[3].data
data modify storage pvm:set_nbt type set from storage pvm:argbuf buf[2].data
data modify storage pvm:set_nbt path set from storage pvm:argbuf buf[1].data
function pvm:lib/set_nbt with storage pvm:set_nbt
data modify storage pvm:print return set value {"data":0,"none":1,type:"none"}