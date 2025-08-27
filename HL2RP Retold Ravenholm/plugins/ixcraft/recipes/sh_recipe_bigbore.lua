RECIPE.name = "LAR Big Bore"
RECIPE.description = "Craft a LAR Big Bore."
RECIPE.model = "models/weapons/sniper/w_sniper.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 12,
	["glue"] = 10,
	["gear"] = 8,
	["plastic"] = 6,
	["refinedmetal"] = 8,
}
RECIPE.results = {
	["bigbore"] = 1,
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
