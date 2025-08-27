function Schema:CanDrive(ply, ent)
    return false
end

function Schema:PlayerFootstep(ply, pos, foot, sound, volume)
    local pitch = math.random(90.0, 110.0)
    local newVolume = volume / 1
	local newSound = ""

    if ( ply:KeyDown(IN_SPEED) ) then
        newVolume = volume * 1
    end

    if ( ply:IsOW() ) then
		sound = "npc/combine_soldier/gear"..math.random(1,6)..".wav"
    elseif ( ply:IsConscript() ) then
        sound = "npc/metropolice/gear"..math.random(1,6)..".wav"
        pitch = math.random(80.0, 90.0)
    elseif ( ply:IsVortigaunt() ) then
        sound = "npc/vort/vort_foot"..math.random(1,4)..".wav"
    end

    if not ( ply:WaterLevel() == 0 ) then
        newSound = "ambient/water/water_splash"..math.random(1,3)..".wav"
        sound = "ambient/water/rain_drip"..math.random(1,4)..".wav"
    end

    if ( SERVER ) then
        ply:EmitSound(newSound, 70, pitch, newVolume)
        ply:EmitSound(sound, 70, pitch, newVolume)
    end

    return true
end

function Schema:OnEntityCreated(ent)
    if ( IsValid(ent) ) then
        if ( ent:GetClass() == "prop_door_rotating" ) then
            ent:DrawShadow(false)
        elseif ( ent:GetClass() == "prop_ragdoll" ) then
            ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
        end
    end
end

function Schema:PlayerButtonDown(ply, key)
    if ( key == KEY_SPACE ) then
        if ( ply:GetNetVar("ixCurrentCamera", false) ) then
            if ( SERVER ) then
                ply:SetNetVar("ixCurrentCamera", false)
                ply:SetViewEntity(ply)
                ply:Freeze(false)
            else
                net.Start("ixScenePVSOff")
                net.SendToServer()
            end
        end
    end
end

function Schema:OnPlayerHitGround(ply)
    local vel = ply:GetVelocity()
    ply:SetVelocity(Vector(- ( vel.x * 0.4 ), - ( vel.y * 0.4 ), 0))
end

function Schema:IsCharacterRecognized()
    return true
end

function Schema:CanPlayerUseBusiness(ply)
    return false
end

function Schema:CanPlayerJoinClass()
    return false
end