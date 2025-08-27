RECIPE.name = "GR9"
RECIPE.description = "Craft an GR9."
RECIPE.model = "models/weapons/hmg/w_gr9.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 12,
	["glue"] = 8,
  ["plastic"] = 7,
	["gear"] = 8,
	["metalplate"] = 17,
	["refinedmetal"] = 13,
}
RECIPE.results = {
	["gr9"] = 1,
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
