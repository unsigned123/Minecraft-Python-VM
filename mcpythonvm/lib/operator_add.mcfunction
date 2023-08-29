$execute if data storage $(package_name):$(target_name) stack[-1].str if data storage $(package_name):$(target_name) stack[-2].str run function pvm:lib/str_operation_add {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}

$execute if data storage $(package_name):$(target_name) stack[-1].list if data storage $(package_name):$(target_name) stack[-2].list run function pvm:lib/list_or_tuple_add {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}
$execute if data storage $(package_name):$(target_name) stack[-1].tuple if data storage $(package_name):$(target_name) stack[-2].tuple run function pvm:lib/list_or_tuple_add  {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}

$execute if data storage $(package_name):$(target_name) stack[-1].int if data storage $(package_name):$(target_name) stack[-2].int run function pvm:lib/num_operation {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}
$execute if data storage $(package_name):$(target_name) stack[-1].int if data storage $(package_name):$(target_name) stack[-2].float run function pvm:lib/num_operation {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}
$execute if data storage $(package_name):$(target_name) stack[-1].float if data storage $(package_name):$(target_name) stack[-2].int run function pvm:lib/num_operation {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}
$execute if data storage $(package_name):$(target_name) stack[-1].float if data storage $(package_name):$(target_name) stack[-2].float run function pvm:lib/num_operation {"operation":"+=","package_name":$(package_name),"target_name":$(target_name)}
