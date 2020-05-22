import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "hannyatext"
import "vsprite"

local gfx <const> = playdate.graphics

function fileForChar(c)
   return "images/"..utf8.codepoint(c)..".png"
end

local screenZPosition = 400
local currentZPosition = 100
local initialZPosition = currentZPosition
local initialScale = screenZPosition / initialZPosition
local itemDistance = 500

local currentChange = 0
local vsprites = {}

function newSpriteFor(count)
   print(count)
   local char = hannyatext[count]
   print(char)
   local baseZPosition = initialZPosition - itemDistance * (count - 1)
   local imageName = fileForChar(char)
   local image = gfx.image.new(imageName)
   assert(image)
   local ypos = 0
   local xpos = 0
   local v = VSprite(baseZPosition, currentZPosition, image, xpos, ypos)
   vsprites[count] = v
end

function myGameSetUp()
   for i=1, #hannyatext do
      newSpriteFor(i)
   end
end

myGameSetUp()

function playdate.update()
   currentChange = 30
   currentZPosition = currentZPosition + currentChange
   for k,v in ipairs(vsprites) do
      v:update(currentZPosition)
   end
   gfx.sprite.update()
end
