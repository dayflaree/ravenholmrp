-- Item Statistics

ITEM.name = "AKM"
ITEM.description = "A weapon originally made in Russia, it is most commonly confused with it's brother, the AK-47."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/akm/w_akm.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_akm"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
    pos = Vector(0, 200, 0),
    ang = Angle(-1.48, 269.18, 0),
    fov = 11.83
}

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
