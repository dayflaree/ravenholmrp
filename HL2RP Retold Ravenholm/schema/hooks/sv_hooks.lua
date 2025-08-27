function Schema:PlayerSwitchFlashlight(ply)
    if ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
        return false
    end

    return true
end

function Schema:EntityEmitSound(data)
    local ent = data.Entity
    if not IsValid(ent) or not ent:IsPlayer() then return end

    if ( data.SoundName:find("player/footsteps") ) then
        return false
    end
end

function Schema:GetPlayerPainSound(ply)
    if ( ply:IsOW() ) then
        return "combine_soldier/pain"..math.random(1, 10)..".wav"
    elseif ( ply:IsConscript() ) then
        return "litenetwork/vo/conscript/hg_hit"..math.random(1, 19)..".wav"
	elseif ( ply:IsVortigaunt() ) then
        return "vo/npc/vortigaunt/vortigese"..math.random(1, 4)..".wav"
    end
end

function Schema:GetPlayerDeathSound(ply)
    if ( ply:IsOW() ) then
        return "npc/combine_soldier/die"..math.random(1, 4)..".wav"
    elseif ( ply:IsVortigaunt() ) then
        return "vo/npc/vortigaunt/vortigese"..math.random(1, 4)..".wav"
    elseif ( ply:IsConscript() ) then
        return "litenetwork/vo/conscript/hg_hit"..math.random(1, 19)..".wav"
    end
end

function Schema:DoPlayerDeath(ply, attacker, dmginfo)
    ply.ixDeathPos = ply:GetPos()
    ply.ixDeathAngles = ply:GetAngles()
    ply:SetRestricted(false)
    
    local pos = ply:GetPos()
    local ang = ply:GetAngles()
    if ( attacker:IsNPC() ) then
        if ( attacker:GetClass() == "npc_headcrab" ) then
            local zomb = ents.Create("npc_zombie")
            if ( ply:IsVortigaunt() ) then
                zomb = ents.Create("npc_vortigaunt")
                zomb:SetModel("models/vortigaunt_zombie.mdl")
            elseif ( ply:IsOW() ) then
                zomb = ents.Create("npc_zombine")
            end
            zomb:SetPos(pos)
            zomb:SetAngles(ang)
            zomb:Spawn()
            zomb:Activate()
            SafeRemoveEntity(attacker)
            ply:ChatNotify("A headcrab has attached to your head and you lost control of your body.")
        elseif ( attacker:GetClass() == "npc_headcrab_fast" ) then
            local zombfast = ents.Create("npc_fastzombie")
            if ( ply:IsVortigaunt() ) then
                zombfast = ents.Create("npc_vortigaunt")
                zombfast:SetModel("models/vortigaunt_zombie.mdl")
            elseif ( ply:IsOW() ) then
                zombfast = ents.Create("npc_zombine")
            end
            zombfast:SetPos(pos)
            zombfast:SetAngles(ang)
            zombfast:Spawn()
            zombfast:Activate()
            SafeRemoveEntity(attacker)
            ply:ChatNotify("A headcrab has attached to your head and you lost control of your body.")
        end
    end
end

function Schema:ShouldSpawnPlayerCorpse(ply, attacker, dmginfo)
    if ( attacker:IsNPC() ) then
        if ( attacker:GetClass() == "npc_headcrab" or attacker:GetClass() == "npc_headcrab_fast" ) then
            return false
        end
    end
end

function Schema:OnNPCKilled( npc, attack, wep )
    local pos = npc:GetPos()
    local ang = npc:GetAngles()
    local mod = npc:GetModel()
    if ( attack:IsNPC() ) then
        if ( attack:GetClass() == "npc_headcrab" ) then
            local zomb = ents.Create("npc_zombie")
            zomb:SetPos(npc:GetPos())
            zomb:SetAngles(npc:GetAngles())
            zomb:SetModel(mod)
            zomb:Spawn()
            zomb:Activate()
        elseif ( attack:GetClass() == "npc_headcrab_fast" ) then
            local zombfast = ents.Create("npc_fastzombie")
            zombfast:SetPos(pos)
            zombfast:SetAngles(ang)
            zombfast:SetModel(mod)
            zombfast:Spawn()
            zombfast:Activate()
        end
    end
end

function Schema:PlayerSpawn(ply)
    timer.Simple(1, function()
        for k, v in ipairs(ents.FindByClass("ix_campfire")) do
            v:StopFire()
            v:StartFire()
        end
    end)
end

function Schema:PlayerHurt(ply, attacker, hp, dmg)
    if ( IsValid(attacker) and attacker:IsPlayer() and attacker:Alive() ) then
        local direction = attacker:GetAimVector() * dmg * 10
        direction.z = 0
        ply:SetVelocity(direction)
    end
end

function Schema:PlayerTeamChanged(ply, oldTeam, newTeam)
    local char = ply:GetCharacter()

    char:SetName(char:GetData("originalName", "John Doe"))

    if ( newTeam == FACTION_CITIZEN ) then
        char:SetModel(char:GetData("originalModel", table.Random(ix.faction.Get(newTeam).models)))
    end

    ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)
end

function Schema:PlayerUseDoor(ply, door)
    if ( door:GetClass() == "func_door" ) and ( ply:IsCombine() or ply:Team() == FACTION_ICT or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        if not ( door:HasSpawnFlags(256) or door:HasSpawnFlags(1024) ) then
            door:Fire("open")
            door:EmitSound("buttons/combine_button1.wav")
        end
    end
end

function Schema:PlayerDeath(ply, inflicter, attacker)
    if not ( ply:IsBot() ) then
        timer.Simple(ix.config.Get("spawnTime") + 0.01, function() ix.util.FactionBecome(ply, FACTION_CITIZEN) end) -- hacky
    end
end

function Schema:PlayerLoadedCharacter(ply, char)
    if ( ply:IsCitizen() ) then
        ix.util.FactionBecome(ply, FACTION_CITIZEN, true)
    else
        ix.util.FactionBecome(ply, FACTION_CITIZEN)
    end
end

function Schema:PreGamemodeLoaded()
    function widgets.PlayerTick()
    end

    hook.Remove("PlayerTick", "TickWidgets")
end

local pickupAbleEntities = {
    ["grenade_helicopter"] = true,
    ["npc_grenade_frag"] = true,
    ["npc_handgrenade"] = true,
    ["ix_container"] = true,
    ["ix_cloth"] = true,
    ["ix_radioied"] = true,
    ["npc_satchel"] = true,
    ["stormfox_digitalclock"] = true,
    ["stormfox_oil_lamp"] = true,
}
function Schema:CanPlayerHoldObject(ply, ent)
    if ( pickupAbleEntities[ent:GetClass()] ) then
        return true
    end
end

function Schema:EntityTakeDamage(ply, dmg)
    if ( IsValid(ply) and ply:IsPlayer() ) then
        if ( dmg:IsDamageType(DMG_CRUSH) ) and not ( IsValid(ply.ixRagdoll) ) then
            return true
        end
    end
end

function Schema:ScalePlayerDamage(ply, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if ( attacker.GetActiveWeapon ) then
        local awep = attacker:GetActiveWeapon()
    end

    if ( ply:IsOW() ) then
        if ( ply:GetLocalVar("ixClass") == 2 or ply:GetLocalVar("ixClass") == 4 ) then
            if ( ply:GetLocalVar("ixRank") == 3 ) then
                dmginfo:ScaleDamage(0.3)
            else
                dmginfo:ScaleDamage(0.4)
            end
        else
            dmginfo:ScaleDamage(0.5)
        end
    elseif ( ply:IsConscript() or ply:IsRebel() ) then
        dmginfo:ScaleDamage(0.75)
    end

    if ( hitgroup == HITGROUP_HEAD ) then
        if ( IsValid(awep) ) then
            if ( awep.Primary.HeadshotDamage ) then
                dmginfo:SetDamage(awep.Primary.HeadshotDamage / 2)
            else
                dmginfo:SetDamage(awep.Primary.Damage * 2)
            end
        end
    end
end

local npcHealthValues = {
    ["npc_antlionguard"] = 1000,
    ["npc_antlion"] = 200,
    ["npc_hunter"] = 400,
    ["npc_combine_s"] = 200,
    ["npc_citizen"] = 100,
}
function Schema:PlayerSpawnedNPC(ply, ent)
    ent:SetKeyValue("spawnflags", "16384")
    ent:SetKeyValue("spawnflags", "2097152")
    ent:SetKeyValue("spawnflags", "8192") -- dont drop weapons

    if ( ent.SetCurrentWeaponProficiency ) then
        ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
    end

    if ( npcHealthValues[ent:GetClass()] ) then
        ent:SetHealth(npcHealthValues[ent:GetClass()])
    end
end

local function DropFunction(ent)
    timer.Simple(0.6, function()
        ent:EmitSound("physics/metal/weapon_impact_hard"..math.random(1,3)..".wav", nil)
    end)

    timer.Simple(60, function()
        if ( IsValid(ent) ) then
            ent:EmitSound("physics/metal/metal_solid_impact_bullet"..math.random(1,4)..".wav", nil, 90)
            ent:Remove()
        end
    end)
end

local lootPools = {
    ["weapon_pistol"] = {"wep_usp", "ammo_pistol", "ammo_pistol"},
    ["weapon_smg1"] = {"wep_mp7", "ammo_smg", "ammo_smg"},
    ["weapon_shotgun"] = {"wep_spas12", "ammo_buckshot", "ammo_buckshot"},
    ["weapon_ar2"] = {"ammo_pulse", "ammo_pulse", "ammo_pulse"},
}
function Schema:OnNPCKilled(npc, attacker, inflictor)
    local npcWeapon = npc:GetActiveWeapon()
    if ( IsValid(npcWeapon) ) then
        if ( npc:GetClass() == "npc_citizen" or npc:GetClass() == "npc_metropolice" or npc:GetClass() == "npc_combine_s" ) then
            if ( lootPools[npcWeapon:GetClass()] ) then
                ix.item.Spawn(lootPools[npcWeapon:GetClass()][math.random(1,3)], npc:EyePos(), function(item, ent)
                    DropFunction(ent)
                end, npc:EyeAngles())
            end
        end
    end
end

function Schema:GetGameDescription()
    return "RETOLD: Half-Life 2 Roleplay"
end

function Schema:CanPlayerSpawnContainer()
    return false
end

function Schema:PlayerSpray()
    return false
end