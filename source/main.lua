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
local itemDistance = 800

local currentChange = 0
local vsprites = {}

function newSpriteFor(count)
   local char = hannyatext[count]
   local baseZPosition = initialZPosition - itemDistance * (count - 1)
   local imageName = fileForChar(char)
   local image = gfx.image.new(imageName)
   local ypos = 0
   local xpos = 0
   local v = VSprite(baseZPosition, currentZPosition, image, xpos, ypos)
   vsprites[count] = v
end

function myGameSetUp()
   newSpriteFor(1)
end

myGameSetUp()

function playdate.update()
   currentChange = 2
   currentZPosition = currentZPosition + currentChange
   for k,v in ipairs(vsprites) do
      v:update(currentZPosition)
   end
   gfx.sprite.update()
end
