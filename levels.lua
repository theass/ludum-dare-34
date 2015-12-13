Vector = require("vector")
local levels = {}

levels["plains"] = {
   image_name="slightly-better-track",
   starting_position=Vector.new(351,888),
   starting_rotation=-0.5,
   checkpoints=18
}

levels["desert"] = {
   image_name="slightly-better-track",
   starting_position=Vector.new(351,888),
   starting_rotation=0.5,
   checkpoints=18
}

levels["volcano"] = {
   image_name="slightly-better-track",
   starting_position=Vector.new(351,888),
   starting_rotation=-0.5,
   checkpoints=18
}

return levels
