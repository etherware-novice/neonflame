local mod_path = "" .. SMODS.current_mod.path

SMODS.current_mod.badge_colour = SMODS.Gradient {
    key = "flame_badge",
    colours = {
        HEX('B52A2A'),
	HEX('6F0C0C'),
    },
    cycle = 4,
}

SMODS.current_mod.badge_text_colour = SMODS.Gradient {
    key = "flame_badge_text",
    colours = {
        HEX('F5EF4A'),
	HEX('D0CA1D'),
    },
    cycle = 2,
}


for _, f in ipairs(NFS.getDirectoryItems(mod_path .. "lib")) do
	assert(SMODS.load_file("lib/" .. f))()
end


-- we're using regtable to force a specific collection order by sorting before registering
local regtable = {}

for _, f in ipairs(NFS.getDirectoryItems(mod_path .. "items")) do
	local objs = assert(SMODS.load_file("items/" .. f))() or {}
	for _, o in ipairs(objs) do table.insert(regtable, o) end
end

table.sort(regtable, function(a, b)
	-- put original jokers before reference jokers
	if not a.pools and b.pools then return true end
	if not b.pools and a.pools then return false end

	-- sorting by rarities
	-- num/num and str/str can be directly compared
	-- otherwise put the vanilla rarity first
	if a.rarity ~= b.rarity then
		if type(a.rarity) == type(b.rarity) then
			return a.rarity < b.rarity
		else
			return type(a.rarity) == "number"
		end
	end

	-- alphabetical sort
	-- since name isnt used, this is a handy way to force subsort order
	return string.lower(a.name) < string.lower(b.name)
end)

for _, o in ipairs(regtable) do
	SMODS.current_mod.debug_info = o.name
	SMODS[o.object_type](o)
	SMODS.current_mod.debug_info = nil
end



-- its probably fine to ignore sorting for crossmods
for _, f in ipairs(NFS.getDirectoryItems(mod_path .. "crossmod")) do
	local key, _ = string.gsub(f, "%..*$", "")
	if next(SMODS.find_mod(key)) or key == "multi" then
		assert(SMODS.load_file("crossmod/" .. f))()
	end
end

