import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "hannyatext"
import "vsprite"

local gfx <const> = playdate.graphics

function fileForChar(c)
   return "images/"..utf8.codepoint(c)..".png"
end

local screenZPosition = 400
local currentZPosition = 4000
local initialZPosition = currentZPosition
local initialScale = screenZPosition / initialZPosition
local itemDistance = 500

local currentChange = 0
local vsprites = {}

function newSpriteFor(count)
   print(count)
   local char = hannyatext[count]
   print(char)
   local baseZPosition = initialZPosition + itemDistance * (count - 1)
   local imageName = fileForChar(char)
   local image = gfx.image.new(imageName)
   assert(image)
   local ypos = math.random(-120, 120)
   local xpos = math.random(-200, 200)
   local v = VSprite(baseZPosition, currentZPosition, image, xpos, ypos)
   vsprites[count] = v
end

function myGameSetUp()
   for i=1, #hannyatext do
      newSpriteFor(i)
   end
end

myGameSetUp()
local messageFont = playdate.graphics.getSystemFont(gfx.font.kVariantBold)
local textHeight = messageFont:getHeight()

function message(text)
   local textWidth = messageFont:getTextWidth(text)
   local messageWidth = textWidth + 8
   local messageHeight = textHeight + 4
   gfx.drawRect(400 - messageWidth, 240 - messageHeight, messageWidth, messageHeight)
   messageFont:drawText(text, 400 - textWidth - 4, 240 - textHeight -2)
end

local mode = "auto"

function playdate.AButtonDown()
   print(mode)
   if mode == "auto" then
      mode = "crank"
   else
      mode = "auto"
   end
end

function playdate.update()
   if mode == "auto" then
      currentChange = 50
   else
      currentChange = playdate.getCrankChange() * 5
   end
   currentZPosition = currentZPosition - currentChange
   for k,v in ipairs(vsprites) do
      v:update(currentZPosition)
   end
   gfx.sprite.update()
   message(mode)
end
