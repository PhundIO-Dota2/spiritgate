function add_stack( event )
    local caster = event.caster
    local item = find_item(caster, "item_prosperity")
    item:ApplyDataDrivenModifier(caster, caster, "item_prosperity_stack", { })
    print(caster:GetModifierStackCount("item_prosperity_stack", caster))
    if caster:GetModifierStackCount("item_prosperity_stack", caster) < 10 then
   		item:ApplyDataDrivenModifier(caster, caster, "item_prosperity_stack_health", { })
    	caster:SetModifierStackCount("item_prosperity_stack", caster, math.min(10, caster:GetModifierStackCount("item_prosperity_stack", caster) + 1))
    end
end
function on_remove( event )
    local caster = event.caster
    local item = find_item(caster, "item_prosperity")
    if item == nil then --No prosperities in inventory, remove stacks.
        caster:RemoveModifierByName("item_prosperity_stack")
        while caster:HasModifier("item_prosperity_stack_health") do
        	caster:RemoveModifierByName("item_prosperity_stack_health")
        end
    end
end