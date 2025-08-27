--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

function Schema:AddDisplay(message, color, soundBool)
    for k, v in pairs(player.GetAll()) do
        net.Start("ixDisplaySend")
            net.WriteString(message)
            net.WriteColor(color or color_white)
            net.WriteBool(soundBool or false)
        net.Send(v)
    end
end

local allowedCodes = {
    ["codetwelve"] = true,
    ["idcheck"] = true,
    ["unrest"] = false,
    ["aj"] = false,
    ["jw"] = false,
    ["void"] = false,
}
function PLUGIN:InitializedSchema()
    if not ( timer.Exists("ixPasssiveDispatch") ) then
        timer.Create("ixPassiveDispatch", PLUGIN.dispatchCooldown, 0, function()
            local randomLine = table.Random(PLUGIN.dispatchLines)
            ix.event.PlaySoundGlobal({
                sound = randomLine.soundFile,
                volume = 0.4,
            })
            ix.dispatch.announce(randomLine.message)
        end)
    end
end

function PLUGIN:DoPlayerDeath(ply, attacker, dmg)
    local location = ply:GetArea()
    if ( location == "" ) then
        location = "unknown location"
    end
    
    if ( ply:IsCombine() ) then
        local sounds = {
            "NPC_MetroPolice.Radio.On",
            "npc/overwatch/radiovoice/lostbiosignalforunit.wav"
        }
        local name = string.upper(ply:Nick())

        for k, v in pairs(PLUGIN.taglines) do
            if ( string.find(name, v) ) then
                sounds[#sounds + 1] = "npc/overwatch/radiovoice/"..v..".wav"
            end
        end

        for k, v in pairs(PLUGIN.digitsToWords) do
            if ( string.find(name, "-"..k) ) then
                sounds[#sounds + 1] = "npc/overwatch/radiovoice/"..v..".wav"
            end
        end

        sounds[#sounds + 1] = "NPC_MetroPolice.Radio.Off"

        for k, v in pairs(player.GetAll()) do
            if ( v:IsCombine() ) then
                ix.util.EmitQueuedSounds(v, sounds, 0, nil, 60)
            end
        end

        for k, v in pairs(player.GetAll()) do
            if not ( v:Team() == ply:Team() ) then
                return
            end

            v:AddDisplay("lost bio-signal for "..ply:Nick().." at "..location.."!", Color(255, 0, 0), true)
        end
        
        --Schema:AddWaypoint(ply:GetPos(), "LOST BIO-SIGNAL FOR "..string.upper(ply:Nick()).." AT "..string.upper(location).."!", Color(255, 0, 0), 30, ply)
    end
end

function PLUGIN:PlayerHurt(ply, attacker, healthRemaining, damageTaken)
    if ( ply:IsCombine() ) and ( ( ply.ixCombineHurt or 0 ) > CurTime() ) then
        local word = "minor"

        if ( damageTaken >= 75 ) then
            word = "immense"
        elseif ( damageTaken >= 50 ) then
            word = "huge"
        elseif ( damageTaken >= 25 ) then
            word = "large"
        end
        
        for k, v in pairs(player.GetAll()) do
            if not ( v:Team() == ply:Team() ) then return end
            
            Schema:AddDisplay(ply:Nick().." has sustained "..word.." bodily damage!", Color(255, 175, 0), true)
            ply.ixCombineHurt = CurTime() + 20
        end 
    end
end

local passiveChatter = {
    "npc/overwatch/radiovoice/antifatigueration3mg.wav",
    "npc/overwatch/radiovoice/airwatchcopiesnoactivity.wav",
    "npc/overwatch/radiovoice/preparevisualdownload.wav",
    "npc/overwatch/radiovoice/remindermemoryreplacement.wav",
    "npc/overwatch/radiovoice/reminder100credits.wav",
    "npc/overwatch/radiovoice/teamsreportstatus.wav",
    "npc/overwatch/radiovoice/leadersreportratios.wav",
    "npc/overwatch/radiovoice/accomplicesoperating.wav",

    "npc/combine_soldier/vo/prison_soldier_activatecentral.wav",
    "npc/combine_soldier/vo/prison_soldier_boomersinbound.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker1.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker2.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker3.wav",
    "npc/combine_soldier/vo/prison_soldier_containd8.wav",
    "npc/combine_soldier/vo/prison_soldier_fallback_b4.wav",
    "npc/combine_soldier/vo/prison_soldier_freeman_antlions.wav",
    "npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav",
    "npc/combine_soldier/vo/prison_soldier_leader9dead.wav",
    "npc/combine_soldier/vo/prison_soldier_negativecontainment.wav",
    "npc/combine_soldier/vo/prison_soldier_prosecuted7.wav",
    "npc/combine_soldier/vo/prison_soldier_sundown3dead.wav",
    "npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",
    "npc/combine_soldier/vo/prison_soldier_visceratorsa5.wav",
}
function PLUGIN:PlayerTick(ply)
    if ( ( ply.nextChatter or 0 ) < CurTime() ) then
        if ( ply:IsCombine() ) then
            if ( ply:IsOW() ) then
                ix.util.EmitQueuedSounds(v, {
                    "NPC_Combine.Radio.On",
                    passiveChatter[math.random(1, #passiveChatter)],
                    "NPC_Combine.Radio.Off",
                }, 0, nil, 50)
            else
                ix.util.EmitQueuedSounds(v, {
                    "NPC_MetroPolice.Radio.On",
                    passiveChatter[math.random(1, #passiveChatter)],
                    "NPC_MetroPolice.Radio.Off",
                }, 0, nil, 50)
            end
        end

        ply.nextChatter = CurTime() + math.random(60, 300)
    end
end