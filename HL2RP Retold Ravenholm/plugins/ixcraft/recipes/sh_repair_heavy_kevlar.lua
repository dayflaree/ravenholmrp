RECIPE.name = "Heavy Kevlar Uniform"
RECIPE.description = "Repair Heavy Kevlar."
RECIPE.model = "models/willardnetworks/update_items/armor01_item.mdl"
RECIPE.category = "Upgrade & Repair"

RECIPE.requirements = {
	["torso_heavy_kevlar"] = 1,
	["refinedmetal"] = 6,
}
RECIPE.results = {
	["torso_heavy_kevlar"] = 1,
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
