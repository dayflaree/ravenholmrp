-- Item Statistics

ITEM.name = "Steam-Propelled Rebar Launcher"
ITEM.description = "A pressure based rebar-firing weapon used by the Resistance."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/crossbow/w_crossbow.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_crossbow"
ITEM.weaponCategory = "primary"

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_R ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)
