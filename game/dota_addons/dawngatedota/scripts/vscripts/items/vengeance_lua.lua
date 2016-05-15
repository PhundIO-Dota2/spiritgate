function VengeanceOnAttackLanded(event)
	function update_stacks(event)
		local caster = event.caster
		local item = event.ability
		local target = event.target
		target:SetModifierStackCount("item_vengeance_burning", caster, math.min(3, count_modifiers(target, "item_vengeance_burning_hidden")))
		if target:GetModifierStackCount("item_vengeance_burning", caster) == 0 then
			target:RemoveModifierByName("item_vengeance_burning")
			caster.vengeance_hit_table[target] = 0
		end
	end

	dofile("deal_damage")
	local item = event.ability
	local caster = event.caster
	local target = event.target
	item:ApplyDataDrivenModifier(caster, target, "item_vengeance_burning_hidden", {})
	item:ApplyDataDrivenModifier(caster, target, "item_vengeance_burning", {})
	update_stacks(event)
	if not target.has_vengeance_ticker then
		target.has_vengeance_ticker = true
		Timers:CreateTimer(function()
			if target:IsNull() or not target:IsAlive() then --Kill the vengeance ticker on respawn
				target.has_vengeance_ticker = false
				return nil
			end
			local stacks = target:GetModifierStackCount("item_vengeance_burning", caster)
			deal_damage(caster, target, 30 / 3 / 30 * stacks, 0, 2, item, true, false, false, 0)
			return 1 / 30
		end)
	end
	Timers:CreateTimer(3 + 1 / 30, function()
		update_stacks(event)
	end)

	if caster.vengeance_hit_table == nil then
		caster.vengeance_hit_table = {}
	end
	if caster.vengeance_hit_table[target] == nil then
		caster.vengeance_hit_table[target] = 0
	end
	caster.vengeance_hit_table[target] = caster.vengeance_hit_table[target] + 1
	if caster.vengeance_hit_table[target] == 3 then
		caster.vengeance_hit_table[target] = 0
		local pid = ParticleManager:CreateParticle("particles/item_vengeance/hellfire_blast_base.vpcf", PATTACH_ABSORIGIN, target)
		local targets = GetEnemiesInRadiusOf(caster, target, 410)
		for k, v in ipairs(targets) do
			deal_damage(caster, v, 70, 0.3, 2, item, false, false, true, 0)
		end
	end
end