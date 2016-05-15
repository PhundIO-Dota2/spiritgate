function Reset(event)
	local caster = event.caster

    caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "modifier_basic_attack_reset", {})
    if caster:IsRangedAttacker() then
        local attack_target = caster:GetAttackTarget()
        if attack_target ~= nil then
        	caster:Interrupt()
        	caster:SetForceAttackTarget(attack_target)
        	Timers:CreateTimer(1 / 30, function()
        		caster:SetForceAttackTarget(nil)
    		end)
        end
    elseif caster:GetAttackTarget() ~= nil then
        caster:PerformAttack(caster:GetAttackTarget(), true, true, true, true)
        StartAnimation(caster, {duration=1 / caster:GetAttacksPerSecond(), activity=ACT_DOTA_ATTACK, rate=4})
    end
end

function OnAttackStart(event)
    local caster = event.caster
    if caster:IsRangedAttacker() then
        caster:RemoveModifierByName("modifier_basic_attack_reset")
    end    
end

function OnAttackLanded(event)
    local caster = event.caster
    if not caster:IsRangedAttacker() then
        caster:RemoveModifierByName("modifier_basic_attack_reset")
    end    
end