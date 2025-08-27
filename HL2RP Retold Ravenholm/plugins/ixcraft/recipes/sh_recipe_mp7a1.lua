RECIPE.name = "MP7A1"
RECIPE.description = "Craft an MP7A1."
RECIPE.model = "models/weapons/smg1/w_smg1.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 6,
	["glue"] = 3,
	["gear"] = 3,
	["plastic"] = 6,
	["refinedmetal"] = 6,
}
RECIPE.results = {
	["mp7a1"] = 1,
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
