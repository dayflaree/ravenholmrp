RECIPE.name = "Blue Kevlar Uniform"
RECIPE.description = "Repair Blue Kevlar."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_2.mdl"
RECIPE.category = "Repair"

RECIPE.requirements = {
	["torso_blue_kevlar"] = 1,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["torso_blue_kevlar"] = 1,
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
