RECIPE.name = "MP5K"
RECIPE.description = "Craft an MP5K"
RECIPE.model = "models/weapons/mp5k/w_mp5k.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 3,
	["glue"] = 6,
	["gear"] = 3,
	["plastic"] = 7,
	["metalplate"] = 6,
	["refinedmetal"] = 6,
}
RECIPE.results = {
	["mp5k"] = 1,
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
