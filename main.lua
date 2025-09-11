local files = {
      "items/jokers",
      "lib/atlas"
}

for i, v in pairs(files) do
    assert(SMODS.load_file(v..".lua"))()
end