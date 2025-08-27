-- Item Statistics

ITEM.name = "Colt Python Revolver"
ITEM.description = "A weapon mainly used by high-ranking Civil Protection. It is very powerful yet not good if you can't aim well."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/357/w_357.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 2
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_357"
ITEM.weaponCategory = "sidearm"

ITEM.iconCam = {
    pos    = Vector(57.109928131104, 181.7945098877, -60.738327026367),
    ang = Angle(-17.581502914429, 250.7974395752, 0),
    fov    = 5.412494001838,
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
