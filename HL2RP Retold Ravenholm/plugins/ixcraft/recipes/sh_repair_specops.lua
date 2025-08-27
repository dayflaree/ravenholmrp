RECIPE.name = "Spec-Ops Resistance Kevlar"
RECIPE.description = "Repair Spec-Ops Kevlar."
RECIPE.model = "models/willardnetworks/update_items/armor03_item.mdl"
RECIPE.category = "Upgrade & Repair"

RECIPE.requirements = {
	["torso_specops"] = 1,
	["refinedmetal"] = 8,
}
RECIPE.results = {
	["torso_specops"] = 1,
}

RECIPE.station = "ix_station_upgradebench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near an upgrade & repair workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)
