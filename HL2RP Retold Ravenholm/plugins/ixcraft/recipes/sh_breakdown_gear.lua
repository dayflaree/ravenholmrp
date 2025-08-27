RECIPE.name = "Metal Gear"
RECIPE.description = "Breakdown a Metal Gear."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Resources"

RECIPE.requirements = {
    ["gear"] = 1,
}
RECIPE.results = {
    ["metalplate"] = 1,
}

RECIPE.station = "ix_station_scrappingbench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a scrapping workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)
