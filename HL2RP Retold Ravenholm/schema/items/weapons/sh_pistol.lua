-- Item Statistics

ITEM.name = "USP Match"
ITEM.description = "A weapon used by Civil Protection, it is used by the Conscript forces in Ravenholm. "
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/pistol/w_pistol.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 2
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_pistol"
ITEM.weaponCategory = "secondary"

ITEM.iconCam = {
    pos = Vector(0, 200, -1),
    ang = Angle(0.33879372477531, 270.15808105469, 0),
    fov = 5.0470897275697,
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
