function DuressAttackLanded(event)
	local caster = event.caster
	local target = event.target
	local item = event.ability
	if item:GetCooldownTimeRemaining() == 0 then
		if target.recently_duressed then
			item:ApplyDataDrivenModifier(caster, target, "modifier_duress_rooted", {Duration = 0.5})
			Timers:RemoveTimer(target.recently_duressed_timer)
		else
			item:ApplyDataDrivenModifier(caster, target, "modifier_duress_rooted", {Duration = 1})
		end
		target.recently_duressed = true
		target.recently_duressed_timer = Timers:CreateTimer(5, function()
			target.recently_duressed = false
			target.recently_duressed_timer = nil
		end)
		item:StartCooldown(15)
	else
		item:StartCooldown(item:GetCooldownTimeRemaining() - 1)
	end
end