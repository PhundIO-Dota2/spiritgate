dofile("deal_damage")

function feeding_frenzy(event)
    local stop = false
    Timers:CreateTimer(function()
        if(event.target:HasModifier("modifier_tidal_prison")) then
            deal_damage(event.caster, event.target, event.Damage / 10.0, event.PowerRatio, 2, event.ability, true, false, false)
        end
        if stop then return nil end
        return 0.1
    end)
    Timers:CreateTimer(event.Duration, function()
        stop = true
        return nil
    end)
end