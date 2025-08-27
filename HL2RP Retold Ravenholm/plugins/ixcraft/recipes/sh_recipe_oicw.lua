RECIPE.name = "XM29 OICW"
RECIPE.description = "Craft an XM29 OICW."
RECIPE.model = "models/weapons/oicw/w_oicw.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 7,
	["glue"] = 6,
	["gear"] = 6,
	["plastic"] = 4,
	["refinedmetal"] = 4,
}
RECIPE.results = {
	["oicw"] = 1,
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
