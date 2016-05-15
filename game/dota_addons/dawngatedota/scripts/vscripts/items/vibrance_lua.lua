function equip(event)
	local caster = event.caster
	local item = event.ability
	if caster.isWellspringing then
		return
	end
	item.isActive = true
	caster.isWellspringing = true
	Timers:CreateTimer(function()
		if not item.isActive then return end
		if caster:IsAlive() then
			local base_regen = caster:GetHealthRegen() - count_modifiers(caster, "item_vibrance_regen_modifier") * 0.1
			local regen_mult = 1 - caster:GetHealth() / caster:GetMaxHealth()
			local new_regen = base_regen * regen_mult
			item:ApplyDataDrivenModifier(caster, caster, "item_vibrance_regen_modifier", { })
			caster:SetModifierStackCount("item_vibrance_regen_modifier", caster, new_regen * 10 + 1)
		end
		return 0.1
	end)
end

function unequip(event)
	local caster = event.caster
	local item = event.ability
	item.isActive = false
	caster.isWellspringing = false
	local other_vibrance = find_item(caster, "item_vibrance")
	if other_vibrance ~= nil then
		equip({
			caster = caster,
			ability = other_vibrance
		})
	end
end