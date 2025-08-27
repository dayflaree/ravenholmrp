RECIPE.name = "USP Match"
RECIPE.description = "Craft a USP Match."
RECIPE.model = "models/weapons/pistol/w_pistol.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 3,
	["glue"] = 6,
	["gear"] = 3,
	["plastic"] = 7,
	["metalplate"] = 6,
}
RECIPE.results = {
	["pistol"] = 1,
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
