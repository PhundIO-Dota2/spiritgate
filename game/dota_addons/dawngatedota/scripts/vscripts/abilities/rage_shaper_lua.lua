function tick(event)
	local caster = event.caster
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_rage_stack", {})
	local stacks = caster:GetModifierStackCount("modifier_rage_stack", caster)
	if stacks < 50 then stacks = stacks + 1 end
	if stacks > 50 then stacks = stacks - 1 end
	caster:SetModifierStackCount("modifier_rage_stack", caster,	stacks)
end

function attack_landed(event)
	local caster = event.caster
	local ability = event.ability
	caster:SetModifierStackCount("modifier_rage_stack", caster,	math.min(100, caster:GetModifierStackCount("modifier_rage_stack", caster) + 5))
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_rage_mounting_fury_hidden", {})
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_rage_mounting_fury", {})
	local stacks = caster:GetModifierStackCount("modifier_rage_mounting_fury", caster)
	if event.target:IsHero() then stacks = stacks + 2 else stacks = stacks + 1 end
	stacks = math.min(6, stacks)
	caster:SetModifierStackCount("modifier_rage_mounting_fury", caster, stacks)
	if caster:HasModifier("modifier_survivor_wrath_buff") then 
		stacks = stacks * 2
	end
	caster:SetModifierStackCount("modifier_rage_mounting_fury_hidden", caster, stacks * (5 + caster:GetLevel() * 0.32))
	ParticleManager:CreateParticle("particles/freia_rage/rage_gain_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
end