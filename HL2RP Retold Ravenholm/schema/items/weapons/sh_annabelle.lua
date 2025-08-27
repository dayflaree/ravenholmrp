-- Item Statistics

ITEM.name = "Winchester"
ITEM.description = "A powerful Lever-Action rifle that's used by your favorite resident of Ravenholm."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/annabelle/w_annabelle.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_annabelle"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
    pos = Vector(0, 200, 1),
    ang = Angle(0, 270, 0),
    fov = 10,
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
