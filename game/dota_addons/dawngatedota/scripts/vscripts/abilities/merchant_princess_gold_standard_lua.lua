function gold_standard_add_buff (event)
	dofile("deal_damage")
	local caster = event.caster
	local ability = caster:FindAbilityByName("ability_merchant_princess_gold_standard")

	if ability.timer ~= nil then
		Timers:RemoveTimer(ability.timer)
	end
	if ability.timer2 ~= nil then
		if ability.pid_copper ~= nil then ParticleManager:DestroyParticle(ability.pid_copper, true) ability.pid_copper = nil end
		if ability.pid_silver ~= nil then ParticleManager:DestroyParticle(ability.pid_silver, true) ability.pid_silver = nil end
		if ability.pid_gold ~= nil then   ParticleManager:DestroyParticle(ability.pid_gold, true)   ability.pid_gold = nil   end
		Timers:RemoveTimer(ability.timer2)
	end
	
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_gold_standard", { })	
	caster:SetModifierStackCount("modifier_gold_standard", caster, 3)
	ability.pid_copper = ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_copper.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ability.pid_silver = ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_silver.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ability.pid_gold   = ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_gold.vpcf"  , PATTACH_CUSTOMORIGIN, caster)
	local angle = 0

	ability.timer = Timers:CreateTimer(function()
		local did_something = false
		angle = angle + 5
		if ability.pid_copper ~= nil then
			ability.pid_copper_pos = caster:GetAbsOrigin() + Vector(math.cos(angle / 180 * math.pi) * 80, math.sin(angle / 180 * math.pi) * 80, 170)
			ParticleManager:SetParticleControl(ability.pid_copper, 0, ability.pid_copper_pos)
			did_something = true
		end
		if ability.pid_silver ~= nil then
			ability.pid_silver_pos = caster:GetAbsOrigin() + Vector(math.cos((angle + 120) / 180 * math.pi) * 80, math.sin((angle + 120) / 180 * math.pi) * 80, 170)
			ParticleManager:SetParticleControl(ability.pid_silver, 0, ability.pid_silver_pos)
			did_something = true
		end
		if ability.pid_gold ~= nil then
			ability.pid_gold_pos = caster:GetAbsOrigin() + Vector(math.cos((angle + 240) / 180 * math.pi) * 80, math.sin((angle + 240) / 180 * math.pi) * 80, 170)
			ParticleManager:SetParticleControl(ability.pid_gold, 0, ability.pid_gold_pos)
			did_something = true
		end
		if not did_something then
			ability.timer = nil
			return
		end
		return 1 / 30
	end)
	ability.timer2 = Timers:CreateTimer(5, function()
		if ability.pid_copper ~= nil then ParticleManager:DestroyParticle(ability.pid_copper, true) ability.pid_copper = nil end
		if ability.pid_silver ~= nil then ParticleManager:DestroyParticle(ability.pid_silver, true) ability.pid_silver = nil end
		if ability.pid_gold ~= nil then   ParticleManager:DestroyParticle(ability.pid_gold, true)   ability.pid_gold = nil   end
		ability.timer2 = nil
	end)
end
function gold_standard_attack(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	local ability = caster:FindAbilityByName("ability_merchant_princess_gold_standard")
	local stacks = caster:GetModifierStackCount("modifier_gold_standard", caster)
	autoattack_damage_multi(event, 0.8 - stacks * 0.2)
	stacks = stacks - 1
	if stacks == 0 then
		caster:RemoveModifierByName("modifier_gold_standard")
	end
	caster:SetModifierStackCount("modifier_gold_standard", caster, stacks)

	if stacks == 2 then
		ParticleManager:SetParticleControl(ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_use.vpcf", PATTACH_CUSTOMORIGIN, caster), 0, ability.pid_copper_pos)
		ParticleManager:DestroyParticle(ability.pid_copper, true)
		ability.pid_copper = nil
	elseif stacks == 1 then
		ParticleManager:SetParticleControl(ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_use.vpcf", PATTACH_CUSTOMORIGIN, caster), 0, ability.pid_silver_pos)
		ParticleManager:DestroyParticle(ability.pid_silver, true)
		ability.pid_silver = nil
	elseif stacks == 0 then
		ParticleManager:SetParticleControl(ParticleManager:CreateParticle("particles/merchant_princess/gold_standard_use.vpcf", PATTACH_CUSTOMORIGIN, caster), 0, ability.pid_gold_pos)
		ParticleManager:DestroyParticle(ability.pid_gold, true)
		ability.pid_gold = nil
	end
end