RECIPE.name = "Dark Energy-Powered Sniper"
RECIPE.description = "Upgrade an LAR Big Bore into a Pulse Sniper."
RECIPE.model = "models/litenetwork/w_ospr.mdl"
RECIPE.category = "Upgrade & Repair"

RECIPE.requirements = {
	["bigbore"] = 1,
	["weaponparts"] = 5,
  ["darkshard"] = 2,
}
RECIPE.results = {
	["pulse_sniper"] = 1,
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
