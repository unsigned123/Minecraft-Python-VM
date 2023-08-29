def getnbt_list(source,target,type_,path):
    #get_nbt(source,target,type,path)
    #arrays with TAG_Compound are not supported
    length = len(_getnbt_single(source,target,'list',path))
    index = 0
    result = []
    while index < length:
        result = append(result,getnbt_single(source,target,type_,path + '[' + str(index) + ']'))
        index += 1
    return result

def getnbt_single(source,target,type_,path):
    #_getnbt_single + float/double convert
    if type_ == 'float':
        return float(str(_getnbt_single(source,target,'list',path)))
    else:
        return _getnbt_single(source,target,'list',path)

def get_entity(selector):
    exec('data modify storage pvm:get_handle handle_list set value {type:list,list:1,data:[]}')
    exec('execute as ' + selector + ' run function pvm:lib/get_handle')
    return getnbt_single('storage','pvm:get_handle','list','handle_list.data')
#setnbt_single(source,target,type,path,value)

def myfunc():
    return '1'=='1'
