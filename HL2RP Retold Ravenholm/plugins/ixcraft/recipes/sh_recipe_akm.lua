RECIPE.name = "AKM"
RECIPE.description = "Craft an AKM."
RECIPE.model = "models/weapons/akm/w_akm.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 6,
	["metalplate"] = 8,
	["glue"] = 7,
	["gear"] = 7,
	["refinedmetal"] = 6,
}
RECIPE.results = {
	["akm"] = 1,
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
