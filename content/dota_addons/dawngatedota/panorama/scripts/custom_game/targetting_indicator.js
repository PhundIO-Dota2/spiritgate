var real_mouse_pos = null;
var target_particle = null;
var last_unit = null;
var ability_data = null;

function GetNumber(value, or, unit) {
    if (!value) {
        return or;
    }

    return eval(value);
}

var update = function() {
    var cursor, unit;
    $.Schedule(0.025, update);
    unit = Players.GetLocalPlayerPortraitUnit();
    cursor = GameUI.GetCursorPosition();
    var active = Abilities.GetLocalPlayerActiveAbility();
    if(active != -1 && ability_data != null) {
        var ability_info = ability_data.data[Abilities.GetAbilityName(active)]
        var target_info = ability_info["TargetInfo"]
        if(target_info != null) {
            if(target_info.Radius == "INFINITE") {
                target_info.Radius = 1000000
            }
            if(target_info.Range == "INFINITE") {
                target_info.Range = 1000000
            }
            real_mouse_pos = GameUI.GetScreenWorldPosition(cursor)
            mouse_over_entities = GameUI.FindScreenEntities(cursor)
            mouse_over_entity = undefined
            if(mouse_over_entities[0] !== undefined) {
                 mouse_over_entity = mouse_over_entities[0].entityIndex
            }
            if(target_info.Type == "Range") {
                if (unit !== last_unit) {
                    last_unit = unit;
                    if (target_particle !== null) {
                        Particles.DestroyParticleEffect(target_particle, true);
                        Particles.ReleaseParticleIndex(target_particle);
                    }
                    target_particle = Particles.CreateParticle("particles/targeting/range.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, unit);
                }
                Particles.SetParticleControl(target_particle, 1, [ GetNumber(target_info.Radius, 0, unit), 0, 0 ]);
            }
            if(target_info.Type == "Line" || target_info.Type == "FullLine") {
                if (unit !== last_unit) {
                    last_unit = unit;
                    if (target_particle !== null) {
                        Particles.DestroyParticleEffect(target_particle, true);
                        Particles.ReleaseParticleIndex(target_particle);
                    }
                    target_particle = Particles.CreateParticle("particles/targeting/line.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, unit);
                }
                var landing_pos = real_mouse_pos
                if(Vector.FromArray(real_mouse_pos).distanceTo(Vector.FromArray(Entities.GetAbsOrigin(unit))) > target_info.Radius || target_info.Type == "FullLine") {
                    landing_pos = Vector.FromArray(real_mouse_pos).minus(Vector.FromArray(Entities.GetAbsOrigin(unit))).normalize().scale(target_info.Radius).add(Vector.FromArray(Entities.GetAbsOrigin(unit))).toArray()
                }
                Particles.SetParticleControl(target_particle, 1, landing_pos);
            }
            if(target_info.Type == "Cone") {
                if (unit !== last_unit) {
                    last_unit = unit;
                    if (target_particle !== null) {
                        Particles.DestroyParticleEffect(target_particle, true);
                        Particles.ReleaseParticleIndex(target_particle);
                    }
                    target_particle = Particles.CreateParticle("particles/targeting/cone.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, unit);
                }
                var landing_pos = real_mouse_pos
                landing_pos = Vector.FromArray(real_mouse_pos).minus(Vector.FromArray(Entities.GetAbsOrigin(unit))).normalize().scale(target_info.Radius).add(Vector.FromArray(Entities.GetAbsOrigin(unit))).toArray()
                Particles.SetParticleControl(target_particle, 1, landing_pos);
                Particles.SetParticleControl(target_particle, 2, [target_info.Radius * (target_info.Width / 2), 1, 1]);
            }
            if(target_info.Type == "UnitTargetRadius" || target_info.Type == "PointTargetRadius") {
                if (unit !== last_unit) {
                    last_unit = unit;
                    if (target_particle !== null) {
                        Particles.DestroyParticleEffect(target_particle, true);
                        Particles.ReleaseParticleIndex(target_particle);
                        target_particle = null
                    }
                    target_particle = Particles.CreateParticle("particles/targeting/aoe.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN, unit);
                }
                var landing_pos = real_mouse_pos
                if(Vector.FromArray(real_mouse_pos).distanceTo(Vector.FromArray(Entities.GetAbsOrigin(unit))) > target_info.Range) {
                    landing_pos = Vector.FromArray(real_mouse_pos).minus(Vector.FromArray(Entities.GetAbsOrigin(unit))).normalize().scale(target_info.Range).add(Vector.FromArray(Entities.GetAbsOrigin(unit))).toArray()
                } else if(target_info.Type != "PointTargetRadius") {
                    if(mouse_over_entity !== undefined && (Abilities.GetAbilityTargetType(active) != 1 || Entities.IsHero(mouse_over_entity))) {
                        landing_pos = Entities.GetAbsOrigin(mouse_over_entity)
                    }
                }
                Particles.SetParticleControl(target_particle, 0, landing_pos);
                Particles.SetParticleControl(target_particle, 1, [ GetNumber(target_info.Radius, 0, unit), 0, 0 ]);
            }
        }
    }
    else {
        if (target_particle !== null) {
            Particles.DestroyParticleEffect(target_particle, true);
            Particles.ReleaseParticleIndex(target_particle)
            last_unit = null
            target_particle = null
        }
    }
}

update();

var GetSpiritgateAbilityTargetInfo = function(data) {
    ability_data = data
}
GameEvents.SendCustomGameEventToServer("GetSpiritgateAbilityTargetInfo", {} )
GameEvents.Subscribe("GetSpiritgateAbilityTargetInfo", GetSpiritgateAbilityTargetInfo);