RECIPE.name = "Ice Axe"
RECIPE.description = "Craft an Ice Axe."
RECIPE.model = "models/weapons/iceaxe/w_iceaxe.mdl"
RECIPE.category = "Melee"

RECIPE.requirements = {
	["metalplate"] = 5,
	["glue"] = 3,
}
RECIPE.results = {
	["iceaxe"] = 1,
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
