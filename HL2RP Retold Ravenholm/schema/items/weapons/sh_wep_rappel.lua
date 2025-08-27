ITEM.name = "Rappel Gear"
ITEM.description = "A set of rappeling gear, this will become very useful at times."
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.class = "ix_rappel"
ITEM.weaponCategory = "gear"
ITEM.width = 1
ITEM.height = 1

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
