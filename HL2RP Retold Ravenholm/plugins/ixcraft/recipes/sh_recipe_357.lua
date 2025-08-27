RECIPE.name = "357"
RECIPE.description = "Craft a 357."
RECIPE.model = "models/weapons/357/w_357.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 6,
	["glue"] = 6,
	["gear"] = 5,
	["refinedmetal"] = 6,
}
RECIPE.results = {
	["357"] = 1,
}

RECIPE.station = "ix_station_weaponbench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a weapon workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)
