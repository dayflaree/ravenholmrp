RECIPE.name = "Automatic Pistol"
RECIPE.description = "Upgrade a USP Match to an Automatic Pistol."
RECIPE.model = "models/weapons/alyxgun/w_alyx_gun.mdl"
RECIPE.category = "Upgrade & Repair"

RECIPE.requirements = {
	["pistol"] = 1,
	["weaponparts"] = 1,
}
RECIPE.results = {
	["autopistol"] = 1,
}

RECIPE.station = "ix_station_upgradebench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near an upgrade & repair workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)
