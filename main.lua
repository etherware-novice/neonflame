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

for _, f in ipairs(NFS.getDirectoryItems(mod_path .. "items")) do
	assert(SMODS.load_file("items/" .. f))()
end

for _, f in ipairs(NFS.getDirectoryItems(mod_path .. "crossmod")) do
	local key, _ = string.gsub(f, "%..*$", "")
	if next(SMODS.find_mod(key)) or key == "multi" then
		assert(SMODS.load_file("crossmod/" .. f))()
	end
end

--[[
for i, v in pairs(files) do
    assert(SMODS.load_file(v..".lua"))()
end

for i, v in pairs(crossmodfiles) do
    if next(SMODS.find_mod(v)) then
       assert(SMODS.load_file("crossmod/" .. v .. ".lua"))()
    end
end
--]]
