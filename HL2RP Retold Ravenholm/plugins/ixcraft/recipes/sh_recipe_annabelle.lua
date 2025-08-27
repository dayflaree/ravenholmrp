RECIPE.name = "Winchester"
RECIPE.description = "Craft a Winchester."
RECIPE.model = "models/weapons/annabelle/w_annabelle.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["wood"] = 6,
	["glue"] = 7,
	["gear"] = 4,
	["refinedmetal"] = 4,
	["metalplate"] = 7,
}
RECIPE.results = {
	["annabelle"] = 1,
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
