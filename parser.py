import mydis
import dis
import symtable
import types

import mcvmlib
import mcvmuser

dis.dis(mcvmuser)


package_name = 'pvm'

INLINE_CALL = ['exec','print','strcat','substr','str','getnbt_single','len','print']


JUMP_INSTRUCTIONS = ['JUMP_FORWARD','JUMP_BACKWARD',
                     'POP_JUMP_FORWARD_IF_TRUE','POP_JUMP_FORWARD_IF_FALSE',
                     'POP_JUMP_BACKWARD_IF_TRUE','POP_JUMP_BACKWARD_IF_FALSE','FOR_ITER']
BACKWARD_JUMP_INSTRUCTIONS = ['JUMP_BACKWARD',
                     'POP_JUMP_BACKWARD_IF_TRUE','POP_JUMP_BACKWARD_IF_FALSE']

PROCESSED_JUMP_INSTRUCTIONS = ['JUMP','POP_AND_JE','POP_AND_JNE','FOR_ITER']

COMPARE_OPERATION_LIST = ['<','<=','=','!=','>','>=']

def locate_instruction(instructions,byte_offset):
    index = 0
    for instruction in instructions:
        if int(instruction[2]) == byte_offset:
            return index
        index += 1
        

def locate_label(instruction_sections,label_id,section_entry_map,labels,label_map):
    section_id = 0
    for section in instruction_sections:
        if label_map[section_entry_map[section_id]] == True:
            for each in labels:#[0]->label id,[1]->absolute [2]->count
                if each[0] == label_id and section_entry_map[section_id] == each[1]:
                    return section_id
        section_id += 1

def jump_wrapper(result,labels,label_map):
    count = 0
    last_critical_pos = 0
    instruction_section = []
    raw_split_result = []
    split_result = []
    section_entry_map = [0]
    for instruction in result:
        instruction_section.append(instruction)
        if result[count][0] in PROCESSED_JUMP_INSTRUCTIONS or (count != len(result) - 1 and label_map[count + 1] == True) or count == len(result) - 1:
            raw_split_result.append(instruction_section)
            if count != len(result) - 1:
                section_entry_map.append(count + 1)
            instruction_section = []
        count += 1
    count = 0
    split_result = list(raw_split_result)
    #These function sections actually share the same stack data and local variables
    for each_section in raw_split_result:
        if each_section[-1][0] == PROCESSED_JUMP_INSTRUCTIONS[0]:
            #absolute jump
            #label id to section id
            #the arg of the jump instruction is changed to section id
            split_result[count][-1][1][0] = str(locate_label(split_result,int(each_section[-1][1][0]),section_entry_map,labels,label_map))
        elif each_section[-1][0] in PROCESSED_JUMP_INSTRUCTIONS[1:]:
            split_result[count][-1][1][0] = str(locate_label(split_result,int(each_section[-1][1][0]),section_entry_map,labels,label_map))
            #conditional jump
        count += 1
    return split_result


def convert(target,sections,local_var,global_var_conames,global_var,module_name,consts,argcount):
    stack = []
    target_name = target.__name__
    section_id = 0
    var_global = [None] + list(target.__code__.co_names)
    local_var_typelist = []
    for section in sections:
        filename = package_name + target_name + str(section_id)
        command_chain = ''
        index = 0
        for instruction in section:
            command_chain += '#' + instruction[0] + '\n'
            if instruction[0] == 'RESUME':#the start of a function
                #count = 0
                command_chain += 'data modify storage %s:%s stack set value []\n' % (package_name,
                                                                         target_name)
                command_chain += 'data modify storage %s:%s localvar set value []\n' % (package_name,
                                                                         target_name)
                command_chain += 'data modify storage %s:%s return set value {}\n' % (package_name,
                                                                         target_name)
                command_chain += 'data modify storage %s:%s runtimeinfo set value {"package_name":"%s","target_name":"%s"}\n' % (package_name,
                                                                         target_name,package_name,
                                                                         target_name)
                for each in global_var_conames:
                    if each not in INLINE_CALL:
                        try:
                            eval(module_name + '.' + each)
                        except AttributeError:#not a function
                            command_chain += 'execute unless data storage %s:global global_var[{"name":"%s"}] run data modify storage %s:global global_var[{"name":"%s","value":0}]\n' % (package_name,
                                                                                     each,package_name,
                                                                                     each)
                        else:#function
                            pass
                #pass the arg
                #argbuf will be erased upon calling by the caller,not the callee
                
                #command_chain += 'data modify storage %s:%s localvar set from storage %s:argbuf buf\n' % (package_name,target_name,package_name)
                for each in local_var:
                    command_chain += 'execute unless data storage %s:%s localvar[{"name":"%s"}] run data modify storage %s:%s localvar append value {"name":"%s","value":0}\n' % (package_name,target_name,
                                                                                     each,package_name,target_name,
                                                                                     each)
                for each in range(0,argcount):
                    command_chain += 'data modify storage %s:%s localvar[%d] set from storage pvm:argbuf buf[-1]\n' % (package_name,target_name,each)
                    command_chain += 'data remove storage %s:argbuf buf[-1]\n'% (package_name)
                

            elif instruction[0] == 'LOAD_CONST':
                const_id = int(instruction[1][0])
                if type(consts[const_id]) == float:
                    command_chain += 'data modify storage %s:%s stack append value {"data":%f,"type":"float","float":1}\n' % (package_name,
                                                                         target_name,
                                                                    consts[const_id])
                elif type(consts[const_id]) == str:
                    command_chain += 'data modify storage %s:%s stack append value {"data":"%s","type":"str","str":1}\n' % (package_name,
                                                                         target_name,
                                                                    consts[const_id].replace('"','\\\"'))
                elif type(consts[const_id]) == int:
                    command_chain += 'data modify storage %s:%s stack append value {"data":%d,"type":"int","int":1}\n' % (package_name,
                                                                         target_name,
                                                                    consts[const_id])
                elif consts[const_id] == None:
                    command_chain += 'data modify storage %s:%s stack append value {"data":0,"type":"None","none":1}\n' % (package_name,
                                                                         target_name)
                elif type(consts[const_id]) == tuple:#LOAD_CONST only loads one layer tuples,and tuples in tuples are generated dynamically with BUILD_TUPLE.Additionally,const one-layer lists are also built with tuples
                    command_chain += 'data modify storage %s:%s stack append value {"data":[],"type":"tuple","tuple":1}\n' % (package_name,
                                                                         target_name)
                    for each in consts[const_id]:
                        if type(each) == int:
                            command_chain += 'data modify storage %s:%s stack[-1].data append value {"data":%d,"type":"int","int":1}\n' % (package_name,
                                                                             target_name,
                                                                             each)
                        elif type(each) == str:
                            command_chain += 'data modify storage %s:%s stack[-1].data append value {"data":"%s","type":"str","str":1}\n' % (package_name,
                                                                             target_name,
                                                                             each)
                        elif type(each) == float:
                            command_chain += 'data modify storage %s:%s stack[-1].data append value {"data":%f,"type":"float","float":1}\n' % (package_name,
                                                                             target_name,
                                                                             each)
                
            elif instruction[0] == 'LOAD_FAST':
                command_chain += 'data modify storage %s:%s stack append from storage %s:%s localvar[%d]\n' % (package_name,
                                                                                               target_name,
                                                                                                package_name,
                                                                                               target_name,
                                                                    int(instruction[1][0]))
                command_chain += 'data remove storage %s:%s stack[-1].name\n' % (package_name,target_name)
                #stack.append(local_var[int(instruction[1][0])])
            elif instruction[0] == 'LOAD_GLOBAL':
                if int(instruction[1][0]) %2 == 0:#var
                    command_chain += 'data modify storage %s:%s stack append value {"data":"None"}'
                    command_chain += 'data modify storage %s:%s stack[-1].data set from storage %s:global global_var[{"name":"%s"}].data\n' % (package_name,
                                                                                                        target_name,
                                                                                                         package_name,
                                                                        global_var_conames[int(instruction[1][0]) // 2])
                else:#function
                    command_chain += 'data modify storage %s:%s stack append value {"data":{"package_name":"%s","callee_name":"%s","caller_name":"%s"},"type":"function","function":1}\n'% (package_name,
                                                                                                        target_name,package_name,
                                                                                                        global_var_conames[int(instruction[1][0]) // 2],
                                                                                                        target_name)
                command_chain += 'data remove storage %s:%s stack[-1].name\n' % (package_name,target_name)
                #stack.append(var_global[int(instruction[1][0])])
            elif instruction[0] == 'STORE_GLOBAL':
                command_chain += 'data modify storage %s:global global_var[{"name":"%s"}].data from storage %s:%s stack[-1].data\n' % (package_name,
                                                                                 global_var_conames[int(instruction[1][0])],
                                                                                 package_name,
                                                                                 target_name)
                command_chain += 'data remove storage %s:%s stack[-1]\n' % (package_name,
                                                        target_name)
            elif instruction[0] == 'POP_TOP':
                command_chain += 'data remove storage %s:%s stack[-1]\n'% (package_name,
                                                                                                    target_name)
                #stack.pop()
            elif instruction[0] == 'BINARY_OP':
                if instruction[1][1][1] == '+':
                    command_chain += 'function pvm:lib/operator_add {"package_name":"%s","target_name":"%s"}\n'% (package_name,
                                                                                                    target_name)
                elif instruction[1][1][1] == '-':
                    command_chain += 'function pvm:lib/operator_sub {"package_name":"%s","target_name":"%s"}\n'% (package_name,
                                                                                                    target_name)
                elif instruction[1][1][1] == '*':
                    command_chain += 'function pvm:lib/operator_mul {"package_name":"%s","target_name":"%s"}\n'% (package_name,
                                                                                                    target_name)
                elif instruction[1][1][1] == '/':
                    command_chain += 'function pvm:lib/operator_div {"package_name":"%s","target_name":"%s"}\n'% (package_name,
                                                                                                    target_name)
                #...
            elif instruction[0] == 'CALL':
                new_local_var = []
                number_of_args = int(instruction[1][0])
                #command_chain += 'function pvm:caller storage %s:%s stack[%d]' % (package_name,target_name.-int(instruction[1][0])-1)
                #argbuf is reversed!!!
                command_chain += 'data modify storage %s:argbuf buf set value []\n'%(package_name)
                for i in range(len(stack)-1,len(stack)-1-int(instruction[1][0]),-1):
                    command_chain += 'data modify storage %s:argbuf buf append from storage %s:%s stack[-1]\n'%(package_name,
                                                         package_name,
                                                         target_name)
                    command_chain += 'data remove storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name)
                
                #the cleaning the function object is implemented by the caller
                command_chain += 'function pvm:lib/caller with storage %s:%s stack[-1].data\n' % (package_name,target_name)
                
            elif instruction[0] == 'RETURN_VALUE':
                #print(stack)
                command_chain += 'data modify storage %s:%s return set from storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name,
                                                         package_name,
                                                         target_name)
                command_chain += 'data remove storage %s:%s stack[-1]\n' % (package_name,
                                                        target_name)
            elif instruction[0] == 'STORE_FAST':
                command_chain += 'data modify storage %s:%s localvar[%d] set from storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name,
                                                         int(instruction[1][0]),
                                                         package_name,
                                                         target_name)
                command_chain += 'data remove storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name)
            elif instruction[0] == 'JUMP':
                command_chain += 'function %s:%s_%d\n' % (package_name,
                                                        target_name,
                                                        int(instruction[1][0]))
            elif instruction[0] == 'POP_AND_JE':
                command_chain += 'execute store result storage %s:%s_%d cmp long 1 run data get storage %s:%s stack[-1].data\n' % (package_name,target_name,section_id,package_name,target_name)
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                command_chain += 'data remove storage %s:%s stack[-1]\n' % (package_name,target_name)
                command_chain += 'execute if score vm cmp = vm 1 run function %s:%s_%d\n' % (package_name,target_name,int(instruction[1][0]))
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                command_chain += 'execute if score vm cmp = vm 0 run function %s:%s_%d\n' % (package_name,target_name,section_id + 1)
            elif instruction[0] == 'POP_AND_JNE':
                command_chain += 'execute store result storage %s:%s_%d cmp long 1 run data get storage %s:%s stack[-1].data\n' % (package_name,target_name,section_id,package_name,target_name)
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                command_chain += 'data remove storage %s:%s stack[-1]\n' % (package_name,target_name)
                command_chain += 'execute if score vm cmp = vm 0 run function %s:%s_%d\n' % (package_name,target_name,int(instruction[1][0]))
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                command_chain += 'execute if score vm cmp = vm 1 run function %s:%s_%d\n' % (package_name,target_name,section_id + 1)

            elif instruction[0] == 'COMPARE_OP':
                operation = int(instruction[1][0])
                if operation == 2:#==
                    command_chain += 'function pvm:lib/compare_op_equal {"package_name":"%s","target_name":"%s"}\n' %(package_name,
                                                                                                    target_name)
                elif operation == 3:#!=
                    command_chain += 'function pvm:lib/compare_op_unequal {"package_name":"%s","target_name":"%s"}\n' %(package_name,
                                                                                                    target_name)
                else:
                    command_chain += 'function pvm:lib/compare_op_normal {"operator":"%s","package_name":"%s","target_name":"%s"}\n' %(COMPARE_OPERATION_LIST[operation],
                                                                                                    package_name,
                                                                                                    target_name)
            elif instruction[0] == 'BUILD_LIST':
                command_chain += 'data modify storage %s:%s listbuf set value {"data":[],"type":"list","list":1}\n'% (package_name,
                                                                                        target_name)
                length = int(instruction[1][0])
                for each in range(0,length):
                    command_chain += 'data modify storage %s:%s listbuf set from storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name,
                                                         package_name,
                                                         target_name)
                    command_chain += 'data remove storage %s:%s stack[-1]\n'% (package_name,
                                                            target_name)
                command_chain += 'data modify storage %s:%s stack append value {"data":[],"type":"list","list":1}\n'% (package_name,
                                                                                        target_name)
                
                command_chain += 'data modify storage %s:%s stack[-1] set from storage %s:%s listbuf\n' % (package_name,
                                                         target_name,
                                                         package_name,
                                                         target_name)

            elif instruction[0] == 'LIST_EXTEND':#combines TOS1 and TOS
                command_chain += 'data modify storage %s:argbuf buf append from storage %s:%s stack[-1]\n'%(package_name,
                                                         package_name,
                                                         target_name)
                command_chain += 'data remove storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name)
                command_chain += 'data modify storage %s:argbuf buf append from storage %s:%s stack[-1]\n'%(package_name,
                                                         package_name,
                                                         target_name)
                command_chain += 'data remove storage %s:%s stack[-1]\n'%(package_name,
                                                         target_name)
                command_chain += 'function %s:extend_0\n' % (package_name)
                command_chain += 'data modify storage %s:%s stack append from storage pvm:extend return\n' % (package_name,
                                                                         target_name)
                
            elif instruction[0] == 'BINARY_SUBSCR':
                if section[index - 1][0] != 'BUILD_SLICE':
                    command_chain += 'function pvm:lib/subscr {"package_name":"%s","target_name":"%s"}\n' % (package_name,target_name)
                elif section[index - 1][0] == 'BUILD_SLICE' and int(section[index - 1][1][0]) == 2:
                    command_chain += 'function pvm:lib/subscr2 {"package_name":"%s","target_name":"%s"}\n' % (package_name,target_name)

            elif instruction[0] == 'GET_ITER':
                command_chain += 'function pvm:lib/get_iter {"package_name":"%s","target_name":"%s"}\n'% (package_name,
                                                                                                        target_name)
            elif instruction[0] == 'FOR_ITER':
                #index++
                command_chain += 'execute store result score vm counter run data get storage %s:%s stack[-1].data.index\n'% (package_name,
                                                                                                        target_name)
                command_chain += 'scoreboard players operation vm counter += vm 1\n'
                command_chain += 'data modify storage pvm:iter iter set value {"index":-1,"package_name":"%s","target_name":"%s"}\n' % (package_name,
                                                                                                        target_name)
                command_chain += 'execute store result storage pvm:iter iter.index int 1 run scoreboard players get vm counter\n'
                command_chain += 'execute store result storage %s:%s stack[-1].data.index int 1 run scoreboard players get vm counter\n'% (package_name,
                                                                                                        target_name)


                #check if exhausted
                command_chain += 'execute store result score vm tos run data get storage %s:%s stack[-1].data.index\n' % (package_name,
                                                                                                    target_name)
                command_chain += 'execute store result score vm tos1 run data get storage %s:%s stack[-1].data.length\n' % (package_name,
                                                                                                    target_name)
                #true=continue
                command_chain += 'execute if score vm tos < vm tos1 run data modify storage %s:%s_%d cmp set value 1\n'% (package_name,
                                                                                                    target_name,section_id)
                #false=break
                command_chain += 'execute if score vm tos >= vm tos1 run data modify storage %s:%s_%d cmp set value 0\n'% (package_name,
                                                                                                    target_name,section_id)
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                
                command_chain += 'execute if score vm cmp = vm 0 run data remove storage %s:%s stack[-1]\n'% (package_name,
                                                                                                    target_name)
                command_chain += 'execute if score vm cmp = vm 0 run function %s:%s_%d\n' % (package_name,target_name,int(instruction[1][0]))
                
                command_chain += 'execute store result score vm cmp run data get storage %s:%s_%d cmp\n' % (package_name,target_name,section_id)
                
                #if the index is not out of range,push stack[-2].data.target[index] into the stack
                command_chain += 'execute if score vm cmp = vm 1 run function pvm:lib/iter_next with storage pvm:iter iter\n'

                command_chain += 'execute if score vm cmp = vm 1 run function %s:%s_%d\n' % (package_name,target_name,section_id + 1)
                
            index += 1
        if section_id != len(sections) - 1 and instruction[0] not in PROCESSED_JUMP_INSTRUCTIONS:
            command_chain += 'function %s:%s_%d' % (package_name,target_name,section_id + 1)
            
        with open('mcpythonvm/%s_%d.mcfunction' % (target_name,section_id),'w') as f:
            f.write(command_chain)
        section_id += 1

def parse_function(target,local_var,global_var_conames,global_var,module_name,consts,argcount):
    raw_result = mydis.dis(target)[0]
    #insert labels
    count = 0
    label_id = 0
    result = list(raw_result)
    labels = []
    label_map = list([False] * len(raw_result))
    for instruction in raw_result:
        absolute = 0
        if instruction[0] in JUMP_INSTRUCTIONS:
            #byte delta to instruction absolute position
            byte_delta = int(instruction[1][0])
            jump_backward = False
            if instruction[0] in BACKWARD_JUMP_INSTRUCTIONS:
                byte_delta = -byte_delta
                jump_backward = True
            absolute = locate_instruction(raw_result,byte_delta * 2 + int(instruction[2]) + 2)
        if instruction[0] == 'JUMP_FORWARD':
            result[count][0] = 'JUMP'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            labels.append([label_id,count])
            label_map[absolute] = True
        elif instruction[0] == 'JUMP_BACKWARD':            
            result[count][0] = 'JUMP'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        elif instruction[0] == 'POP_JUMP_FORWARD_IF_TRUE':            
            result[count][0] = 'POP_AND_JE'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        elif instruction[0] == 'POP_JUMP_BACKWARD_IF_TRUE':            
            result[count][0] = 'POP_AND_JE'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        elif instruction[0] == 'POP_JUMP_FORWARD_IF_FALSE':         
            result[count][0] = 'POP_AND_JNE'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        elif instruction[0] == 'POP_JUMP_BACKWARD_IF_FALSE':
            result[count][0] = 'POP_AND_JNE'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        elif instruction[0] == 'FOR_ITER':
            result[count][0] = 'FOR_ITER'
            result[count][1][0] = str(label_id)
            labels.append([label_id,absolute,count])
            label_map[absolute] = True
        #notice that label ids don't monotonically increase
        if instruction[0] in PROCESSED_JUMP_INSTRUCTIONS:
            label_id += 1
        count += 1
    return convert(target,jump_wrapper(result,labels,label_map),local_var,global_var_conames,global_var,module_name,consts,argcount)

global_var_conames = []
global_var = dict()

def generate_initializer(global_var):
    pass

def symbol_preparation(module):
    global_var = vars(module)
    items = sorted(module.__dict__.items())
    for name,x in items:
        if isinstance(x,types.FunctionType):
            print((x.__code__.co_consts))
            #global_var[x.__code__.co_names]
            #prepare global vars...
            module_name = 'mcvmuser'
            parse_function(x,list(x.__code__.co_varnames),list(x.__code__.co_names),global_var,module_name,list(x.__code__.co_consts),x.__code__.co_argcount)


symbol_preparation(mcvmuser)

