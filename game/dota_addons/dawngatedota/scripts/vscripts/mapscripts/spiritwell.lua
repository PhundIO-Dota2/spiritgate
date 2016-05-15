WORKER_STATE_DONE = 0
WORKER_STATE_MOVING_TO_RESOURCE = 1
WORKER_STATE_MINING = 2
WORKER_STATE_RETURNING_RESOURCE = 3

LOCK_TIMER = 4 * 60 -- 4 minutes

function enter_well_area(trigger)
    if trigger.activator.spiritwell == nil then
        trigger.activator.spiritwell = trigger.caller
        if trigger.caller.heroes_within == nil then
        	trigger.caller.heroes_within = {}
        end
        if(trigger.activator:IsHero() and trigger.activator:GetUnitName() ~= "npc_well_worker") then
            trigger.caller.heroes_within[#trigger.caller.heroes_within + 1] = trigger.activator
        end
        --print(#trigger.caller.heroes_within)
        Timers:CreateTimer(1 / 30, function()
        	trigger.activator.spiritwell = nil
    	end)
    end
end
function exit_well_area(trigger)
    if trigger.activator.spiritwell == nil then
        trigger.activator.spiritwell = trigger.caller
        if(trigger.activator:IsHero() and trigger.activator:GetUnitName() ~= "npc_well_worker") then
            tableRemove(trigger.caller.heroes_within, trigger.activator)
        end
        --print(#trigger.caller.heroes_within)
        Timers:CreateTimer(1 / 30, function()
        	trigger.activator.spiritwell = nil
    	end)
    end
end
local spiritwell = {}
function spiritwell.init()
    wells = Entities:FindAllByName("spiritwell")
    local wellindex = 0
    for _, well in pairs(wells) do
        wellindex = wellindex + 1
        well.targets = { }
        for j=1, 9 do
            local ent = Entities:FindByName(nil, "well_0" .. wellindex .. "_target_0" .. j)
            well.targets[j] = ent:GetAbsOrigin()
            ent:Destroy()
        end
        well.pid_team = ParticleManager:CreateParticle("particles/spiritwell/spiritwell_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
        well.status = 0
        well.locked = false
        well.team = DOTA_TEAM_NEUTRALS
        if wellindex == 1 or wellindex == 3 then
            well.status = 1
            well.locked = true
            well.team = DOTA_TEAM_GOODGUYS
            lockwell(well, well.status, well.team)
        else
            well.status = -1
            well.locked = true
            well.team = DOTA_TEAM_BADGUYS
            lockwell(well, well.status, well.team)
        end
        well.timer = Timers:CreateTimer(function()

            if well.heroes_within == nil then
                well.heroes_within = {}
            end
            
            local change_status = 0

            if #well.heroes_within == 0 then
                if well.team == DOTA_TEAM_GOODGUYS then
                    change_status = 0.05
                end
                if well.team == DOTA_TEAM_BADGUYS then
                    change_status = -0.05
                end
            end

            for  _, hero in pairs(well.heroes_within) do
                if hero:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
                    if well.status < 1 then
                        change_status = change_status + 0.05
                    end
                elseif well.status > -1 then
                    change_status = change_status - 0.05
                end
            end
            if not well.locked then
                well.status = well.status + change_status
            end
            if well.status > 1 then well.status = 1 end
            if well.status < -1 then well.status = -1 end

            local new_status = nil
            local new_team = nil
            if well.status >= 1 and change_status ~= 0 and not well.locked and well.team ~= DOTA_TEAM_GOODGUYS then
                new_status = 1
                new_team = DOTA_TEAM_GOODGUYS
            end
            if well.status <= -1 and change_status ~= 0 and not well.locked and well.team ~= DOTA_TEAM_BADGUYS then
                new_status = -1
                new_team = DOTA_TEAM_BADGUYS
            end
            if new_status ~= nil then
                lockwell(well, new_status, new_team)
            end

            if well.pid ~= nil then
                ParticleManager:SetParticleControl(well.pid, 0, well:GetAbsOrigin() + Vector(0, 0, -2))
            end
            if well.status > 0 then
                ParticleManager:SetParticleControl(well.pid_team, 1, Vector(0.5, 0.5, 0.5 + well.status / 2))
            else
                ParticleManager:SetParticleControl(well.pid_team, 1, Vector(0.5 - well.status / 2, 0.5, 0.5))
            end
            return 1 / 4
        end)
        ParticleManager:SetParticleControl(well.pid_team, 0, well:GetAbsOrigin() + Vector(0, 0, -1))
    end
end

function lockwell(well, new_status, new_team)
    well.status = new_status
    well.team = new_team
    if well.workers == nil then
        well.workers = { }
    end
    for i=1, 9 do
        if well.workers[i] ~= nil and well.workers[i]:IsAlive() then
            well.workers[i]:Kill(nil, nil)
        end
    end
    if well.spawner ~= nil then
        Timers:RemoveTimer(well.spawner)
    end

    well.spawner = Timers:CreateTimer(0.5, function()
        for i=1, 9 do
            if well.workers[i] == nil or not well.workers[i]:IsAlive() then
                create_worker(well, i)
                break
            end
        end
        return 15
    end)

    if well.pid ~= nil then
        ParticleManager:DestroyParticle(well.pid, true)
    end
    well.pid = ParticleManager:CreateParticle("particles/spiritwell/spiritwell_lock_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
    well.locked = true
    Timers:CreateTimer(LOCK_TIMER, function()
        well.locked = false
        ParticleManager:DestroyParticle(well.pid, true)
        well.pid = nil
        local poofpid = ParticleManager:CreateParticle("particles/spiritwell/spiritwell_lockpoof.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControl(poofpid, 0, well:GetAbsOrigin() + Vector(0, 0, 1))
    end)
end

function create_worker(well, target_index)
    local worker = CreateUnitByName("npc_well_worker", well:GetAbsOrigin() + Vector(RandomInt(-50, 50), RandomInt(-50, 50), 0), true, nil, nil, well.team)
    
    ParticleManager:CreateParticle("particles/wellworker/wellworker_effect1.vpcf", PATTACH_ABSORIGIN_FOLLOW, worker)

    --worker:AddNewModifier(caster, nil, "modifier_invulnerable", {})
    worker:SetHullRadius(15)
    worker.worker_state = WORKER_STATE_DONE

    if well.workers == nil then
        well.workers = {}
    end
    well.workers[target_index] = worker

    local worker_target = target_index

    local position_target_index = target_index
    if position_target_index > 9 then position_target_index = position_target_index - 9 end

    Timers:CreateTimer(1 / 30, function()
        if not worker:IsAlive() then
            well.workers[target_index] = nil
            return nil
        end
        if worker.worker_state == WORKER_STATE_DONE then
            local order = {}
            order.UnitIndex = worker:entindex()
            order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
            order.Position = well.targets[position_target_index]
            ExecuteOrderFromTable(order)
            worker.worker_state = WORKER_STATE_MOVING_TO_RESOURCE
            worker.worker_state_target = well.targets[position_target_index]
        elseif worker.worker_state == WORKER_STATE_MOVING_TO_RESOURCE then
            if math_distance(worker:GetAbsOrigin(), worker.worker_state_target) < 65 then
                worker.worker_state = WORKER_STATE_MINING
                return 2.5
            else
                local order = {}
                order.UnitIndex = worker:entindex()
                order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
                order.Position = well.targets[position_target_index]
                ExecuteOrderFromTable(order)
                worker.worker_state_target = well.targets[position_target_index]
            end
        elseif worker.worker_state == WORKER_STATE_MINING then
            local order = {}
            order.UnitIndex = worker:entindex()
            order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
            order.Position = well:GetAbsOrigin()
            ExecuteOrderFromTable(order)
            worker.worker_state = WORKER_STATE_RETURNING_RESOURCE
            worker.worker_state_target = well:GetAbsOrigin()
        elseif worker.worker_state == WORKER_STATE_RETURNING_RESOURCE then
            if math_distance(worker:GetAbsOrigin(), worker.worker_state_target) < 65 then
                worker.worker_state = WORKER_STATE_DONE
                local player_count = PlayerResource:GetPlayerCount()
                for i=1, player_count do
                    local player = PlayerResource:GetPlayer(i - 1)
                    if player ~= nil then
                        local hero = player:GetAssignedHero()
                        if hero ~= nil and hero:GetTeamNumber() == well.team then
                            PlayerResource:ModifyGold(i - 1, 1, true, 0)
                        end
                    end
                end
            else
                local order = {}
                order.UnitIndex = worker:entindex()
                order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
                order.Position = well:GetAbsOrigin()
                ExecuteOrderFromTable(order)
                worker.worker_state_target = well:GetAbsOrigin()
            end
        end
        return 1 / 2
    end)
end

return spiritwell