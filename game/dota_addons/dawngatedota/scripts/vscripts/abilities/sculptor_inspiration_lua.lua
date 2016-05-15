function add_inspiration_stack(event)
	print("Test")
	local caster = event.caster
	local target = event.target
	local addedStacks = 0
	if target:IsHero() then
		addedStacks = event.shaper_stacks
	else
		addedStacks = event.other_stacks
	end
	local ability = event.caster:FindAbilityByName("ability_inspired_shaper")
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_inspiration", { })
	local stacks = caster:GetModifierStackCount("modifier_inspiration", caster)
	if stacks ~= 0 then
		caster:SetModifierStackCount("modifier_inspiration", ability, math.min(5, stacks + addedStacks))
	else
		caster:SetModifierStackCount("modifier_inspiration", ability, addedStacks)
	end
    
    local partID = ParticleManager:CreateParticle("particles/renzo_inspiring_strike/inspiring_strike_base_ability.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControl(partID, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
    ParticleManager:SetParticleControl(partID, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
    --ParticleManager:SetParticleControl(partID, 2, caster:GetAbsOrigin() + Vector(0, 0, 100))
    --ParticleManager:SetParticleControlOrientation(partID, 0, caster:GetForwardVector(), caster:GetRightVector(), caster:GetUpVector())
    --ParticleManager:SetParticleControlOrientation(partID, 0, caster:GetForwardVector(), caster:GetRightVector(), caster:GetUpVector())
    --ParticleManager:SetParticleControlOrientation(partID, 0, caster:GetForwardVector(), caster:GetRightVector(), caster:GetUpVector())
end

function inspiration_embrace(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target

	if caster:GetModifierStackCount("modifier_inspiration", caster) == 5 then
		deal_damage_heal(caster, target, event.heal_amount, event.PowerRatio, 0)
		caster:RemoveModifierByName("modifier_inspiration")
	end
end

function inspiration_kinetic_sculpture(event)
	local caster = event.caster
	local target = event.target
	
	if caster:GetModifierStackCount("modifier_inspiration", caster) == 5 then
		local ability = event.caster:GetAbilityByIndex(2)
		ability:ApplyDataDrivenModifier(caster, target, "modifier_sculptor_kinetic_sculpture_inspiration", { })
		caster:RemoveModifierByName("modifier_inspiration")
	end
end

function Spawn ( keys ) -- This is run when the masterpiece NPC is created, animates the masterpiece
    local partID = ParticleManager:CreateParticle("particles/renzo_masterpiece/renzo_masterpiece_base_ability.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, thisEntity)
    thisEntity:SetHullRadius(0)
    ParticleManager:SetParticleControl(partID, 0, thisEntity:GetAbsOrigin())
    ParticleManager:SetParticleControl(partID, 1, thisEntity:GetAbsOrigin())
    ParticleManager:SetParticleControl(partID, 2, thisEntity:GetAbsOrigin())
    ParticleManager:SetParticleControl(partID, 3, thisEntity:GetAbsOrigin())
    Timers:CreateTimer(1, function()
        ParticleManager:DestroyParticle(partID, false)
    end)
	Timers:CreateTimer({
		endTime = 1,
		callback = function()
			thisEntity:Destroy()
		end
	})
end