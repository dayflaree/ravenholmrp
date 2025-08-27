-- Item Statistics

ITEM.name = "GR9"
ITEM.description = "A Machine gun that is currently used by the Conscript forces. One of the most powerful non-pulse firearms made by the Combine."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/hmg/w_gr9.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "tfa_rtbr_hmg"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(-1.44, 269.22, 0),
	fov = 11
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
