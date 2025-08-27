RECIPE.name = "Steam-Propelled Rebar Launcher"
RECIPE.description = "Craft an Steam-Propelled Rebar Launcher."
RECIPE.model = "models/weapons/crossbow/w_crossbow.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 8,
	["glue"] = 7,
  ["plastic"] = 6,
	["gear"] = 6,
	["metalplate"] = 13,
	["refinedmetal"] = 10,
}
RECIPE.results = {
	["rebarlauncher"] = 1,
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
