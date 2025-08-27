RECIPE.name = "Heavy Kevlar"
RECIPE.description = "A heavily armored top with kevlar. Often worn by resistance figures."
RECIPE.model = "models/willardnetworks/update_items/armor01_item.mdl"
RECIPE.category = "Clothing"

RECIPE.requirements = {
	["cloth"] = 10,
	["metalplate"] = 10,
	["plastic"] = 10,
}
RECIPE.results = {
	["torso_heavy_kevlar"] = 1,
}

RECIPE.station = "ix_station_tailorbench"
RECIPE.craftStartSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a tailoring workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)
