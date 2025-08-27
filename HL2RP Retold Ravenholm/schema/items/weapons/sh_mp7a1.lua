-- Item Statistics

ITEM.name = "MP7A1"
ITEM.description = "A weapon used by Civil Protection, but is mainly used by the Conscript Forces and OTA in Ravenholm."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/smg1/w_smg1.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_smg1"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
    pos = Vector(0, 200, 0),
    ang = Angle(0.31, 269.53, 0),
    fov = 7.36
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
