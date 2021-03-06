local sprites = {}

sprites.sheets = {}

local Sheet = {}
sprites.Sheet = Sheet
function Sheet.new(filename, frame_width, frame_height)
   local sheet = {}
   setmetatable(sheet, {__index = sprites.Sheet})
   sheet.image = love.graphics.newImage(filename)
   sheet.frame_width = frame_width or sheet.image:getWidth()
   sheet.frame_height = frame_height or sheet.image:getHeight()
   return sheet
end

local Sprite = {}
sprites.Sprite = Sprite
function Sprite:set_frame(x, y)
   x = math.floor(x)
   y = math.floor(y)
   self.quad:setViewport(x * self.sheet.frame_width, y * self.sheet.frame_height, self.sheet.frame_width, self.sheet.frame_height)
   -- self.quad:setViewport(x * 0, y * 0, 32, 32)
end

function Sprite:draw(...)
   love.graphics.draw(self.sheet.image, self.quad, ...)
end

function Sprite:getWidth()
   return self.sheet.frame_width
end

function Sprite:getHeight()
   return self.sheet.frame_height
end

function Sprite.new(sheet)
   local sprite = {}
   setmetatable(sprite, {__index = Sprite})
   if type(sheet) == "string" then
      sprite.sheet = sprites.sheets[sheet]
      if not sprite.sheet then error("Unloaded sheet specified: " .. sheet) end
   else
      sprite.sheet = sheet
   end
   sprite.quad = love.graphics.newQuad(0, 0, sprite.sheet.frame_width, sprite.sheet.frame_height, sprite.sheet.image:getWidth(), sprite.sheet.image:getHeight())
   return sprite
end

sprites.new = Sprite.new

local function load_into(dir, t)
   local files = love.filesystem.getDirectoryItems(dir)
   local filename
   for _, filename in ipairs(files) do
      local name = filename:gsub("(.+)%..+", "%1")
      if name:find("%.") then
 	 local width = tonumber(name:gsub("(.+)%.(%d+)x(%d+)", "%2"), 10)
	 local height = tonumber(name:gsub("(.+)%.(%d+)x(%d+)", "%3"), 10)
         name = name:gsub("(.+)%..+", "%1")
	 t[name] = Sheet.new(dir .. filename, width, height)
      else
	 t[name] = Sheet.new(dir .. filename)
      end
   end
end

function sprites.load()
   -- sheets.test_sheet = Sheet.new("art/sprite-test.png", 32, 32)
   load_into("art/", sprites.sheets)
   -- sheets.test_sheet = love.graphics.newImage("art/sprite-test.png")
end

return sprites
