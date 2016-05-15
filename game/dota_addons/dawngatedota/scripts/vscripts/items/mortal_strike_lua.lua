function OnCreated(event)
	local caster = event.caster
	local target = event.target
	if target.mortal_strike_ticker == nil then
		target.mortal_strike_ticker = Timers:CreateTimer(function()
			local removed_health = target:GetHealthRegen() / 2 / 3.275
			target:SetHealth(target:GetHealth() - removed_health)
			return 0.5
		end)
	end
end

function OnDestroy(event)
	local caster = event.caster
	local target = event.target
	Timers:RemoveTimer(target.mortal_strike_ticker)
	target.mortal_strike_ticker = nil
end