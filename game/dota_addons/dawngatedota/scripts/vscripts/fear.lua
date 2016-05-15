function tick(event)
	local caster = event.caster
	local target = event.target

	local angle = RandomInt(1, 360) / 180 * math.pi

	local order = { }
  	order.UnitIndex = target:entindex()
    order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
    order.Position = target:GetAbsOrigin() + Vector(math.cos(angle) * 2000, math.sin(angle) * 2000, 0)
    order.Queue = false

    ExecuteOrderFromTable(order)
end

function end_fear(event)
	local target = event.target
	target:Stop()
end