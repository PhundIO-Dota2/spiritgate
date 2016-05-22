function enter_grass(trigger)
    if trigger.activator.grass_area == nil then
        trigger.activator.grass_area = trigger.caller
        if trigger.caller.heroes_within == nil then
            trigger.caller.heroes_within = {}
        end
        trigger.caller.heroes_within[#trigger.caller.heroes_within + 1] = trigger.activator
        local revealers = init_revealer_group(trigger.activator:GetAbsOrigin())
        Timers:CreateTimer(function()
            trigger.activator.grass_area = nil
            trigger.activator.in_bush = true
            if trigger.activator:IsNull() then
                return
            end
            if tableContains(trigger.caller.heroes_within, trigger.activator) then
                if not trigger.activator.in_bush_attack_delay then
                    local found_enemy = false
                    for _, unit in pairs(trigger.caller.heroes_within) do
                        if not unit:IsNull() and unit:GetTeamNumber() ~= trigger.activator:GetTeamNumber() then
                            found_enemy = true
                            break
                        end
                    end
                    if not found_enemy and not trigger.activator:HasModifier("modifier_bush_invisible") then
                        trigger.activator:RemoveModifierByName("modifier_bush_invisible_revealed")
                        trigger.activator:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(trigger.activator, trigger.activator, "modifier_bush_invisible", {})
                    end
                    if found_enemy and not trigger.activator:HasModifier("modifier_bush_invisible_revealed") then
                        trigger.activator:RemoveModifierByName("modifier_bush_invisible")
                        trigger.activator:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(trigger.activator, trigger.activator, "modifier_bush_invisible_revealed", {})
                    end
                end
                for k, v in ipairs(revealers) do
                    Timers:CreateTimer(RandomFloat(0, 0.2), function()
                        if trigger.activator:IsNull() then
                            return
                        end
                        AddFOWViewer(trigger.activator:GetTeamNumber(), v, trigger.activator:GetCurrentVisionRange() - math_distance(trigger.activator:GetAbsOrigin(), v), 1 / 4, true)
                    end)
                end
                return 1 / 10
            end
            return 
        end)
    end
end

function exit_grass(trigger)
    if trigger.activator.grass_area == nil then
        trigger.activator.grass_area = trigger.caller
        if trigger.caller.heroes_within == nil then
            trigger.caller.heroes_within = {}
        end
        tableRemove(trigger.caller.heroes_within, trigger.activator)
        Timers:CreateTimer(1 / 30, function()
            trigger.activator.grass_area = nil
            trigger.activator.in_bush = false
            trigger.activator:RemoveModifierByName("modifier_bush_invisible")
            trigger.activator:RemoveModifierByName("modifier_bush_invisible_revealed")

            if trigger.activator.is_model_swapping == nil then trigger.activator.is_model_swapping = false end
            if trigger.activator.is_model_swapping then
                trigger.activator.is_model_swapping = false
                enter_grass(trigger)
            end
        end)
    end
end

_G["existing_revealer_groups"] = { }
function init_revealer_group(position)
    if existing_revealer_groups[position] ~= nil then
        return existing_revealer_groups[position]
    end
    local revealers = { }
    local ents = Entities:FindAllInSphere(position, 240)
    for k, ent in ipairs(ents) do
        if ent:GetName() == "bush_fow_revealer" then
            revealers[#revealers + 1] = ent:GetAbsOrigin()
        end
    end
    local revealers = build_revealer_group(revealers)
    for k, v in ipairs(revealers) do
        existing_revealer_groups[v] = revealers
    end
    return revealers
end
_G["init_revealer_group"] = init_revealer_group
function build_revealer_group(revealers) 
    local initial_group_size = #revealers
    for k, v in ipairs(revealers) do
        local ents = Entities:FindAllInSphere(v, 240)
        for k, ent in ipairs(ents) do
            if ent:GetName() == "bush_fow_revealer" then
                if not tableContains(revealers, ent:GetAbsOrigin()) then
                    revealers[#revealers + 1] = ent:GetAbsOrigin()
                end
            end
        end
    end
    if #revealers == initial_group_size or #revealers > 100 then
        return revealers 
    else
        return build_revealer_group(revealers)
    end
end


function unit_attack(event)
    local caster = event.caster
    local target = event.target
    local attacker = event.attacker

    local universal_ability = attacker:FindAbilityByName("ability_universal_ability")
    universal_ability:ApplyDataDrivenModifier(attacker, attacker, "modifier_bush_invisible_revealed", {})
    attacker:RemoveModifierByName("modifier_bush_invisible")
    attacker.in_bush_attack_delay = true

    Timers:CreateTimer(0.75, function()
        if attacker.in_bush then
            universal_ability:ApplyDataDrivenModifier(attacker, attacker, "modifier_bush_invisible", {})
            attacker:RemoveModifierByName("modifier_bush_invisible_revealed")
        end
        attacker.in_bush_attack_delay = false
    end)
end