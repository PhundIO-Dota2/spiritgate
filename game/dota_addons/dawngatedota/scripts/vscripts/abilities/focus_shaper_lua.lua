function OnCreated(event)
	local caster = event.caster
	Timers:CreateTimer(1 / 30, function()
		caster.animal_companion = CreateUnitByName("npc_high_huntress_talah", caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
		caster.animal_companion:SetHullRadius(0)
		caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster.animal_companion, caster.animal_companion, "modifier_dummy_unit", {})
		local last_was_in_bush = caster.in_bush
		local last_caster_pos = caster:GetAbsOrigin()
		local last_caster_bush_pos = caster:GetAbsOrigin()
		caster.animal_companion.loneliness_ticker = nil
		caster.animal_companion_ticker = Timers:CreateTimer(function()
			if caster.in_bush then
				caster.animal_companion.stay = false
			end
			if last_was_in_bush and not caster.in_bush then
				local order = {}
		        order.UnitIndex = caster.animal_companion:entindex()
		        order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
		        order.Position = last_caster_bush_pos
		        order.Queue = false
	        	ExecuteOrderFromTable(order)
	        	caster.animal_companion.stay = true
	        	if caster.animal_companion.loneliness_ticker ~= nil then
	        		Timers:RemoveTimer(caster.animal_companion.loneliness_ticker)
	        	end
	        	caster.animal_companion.loneliness_ticker = Timers:CreateTimer(120, function()
	        		caster.animal_companion.stay = false
        		end)
			elseif not caster.animal_companion.stay and math_distance(caster, caster.animal_companion) > 130 then
				local order = {}
		        order.UnitIndex = caster.animal_companion:entindex()
		        order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
		        order.Position = caster:GetAbsOrigin() + Vector(RandomInt(-120, 120), RandomInt(-120, 120), 0)
		        order.Queue = false
	        	ExecuteOrderFromTable(order)
			end
	        last_was_in_bush = caster.in_bush
	        last_caster_pos = caster:GetAbsOrigin()
	        if caster.in_bush then
	        	last_caster_bush_pos = caster:GetAbsOrigin()
	        end
			return 0.2
		end)
	end)
end
function OnDestroy(event)
	local caster = event.caster
	if caster.animal_companion ~= nil then
		caster.animal_companion:Kill(event.ability, event.caster)
		Timers:RemoveTimer(caster.animal_companion_ticker)
	end
end
function OnOrder(event)
	local caster = event.caster
	--print(event.target_points[1])
	--DeepPrintTable(event)
end
function OnUnitMoved(event)
	local caster = event.caster
	--print(event.target_points[1])
	--DeepPrintTable(event)
end
function OnAttackLanded(event)
	local caster = event.caster
	caster:SetMana(caster:GetMana() + 5)
end