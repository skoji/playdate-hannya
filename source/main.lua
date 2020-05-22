import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "hannyatext"

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

function newSpriteFor(count)
   local char = hannyatext[count]
   local baseZPosition = initialZPosition - itemDistance * (count - 1)

   local imageName = fileForChar(char)
   local image = gfx.image.new(imageName)
   local initialYpos = 120

   local s = gfx.sprite.new()
   
   s.go = function(self)
      self.baseZPosition = baseZPosition
      self.zpos = baseZPosition + currentZPosition
      self.image = image
      self.xpos = 200
      self:updateScale()
      self.ypos = initialYpos
      self:updatePosition()
      self:add()
   end

   s.updateScale = function(self)
      self.scale = screenZPosition / self.zpos
      self:setSize(self.image.width * self.scale, self.image.height * self.scale)
   end

   s.updatePosition = function(self)
      self:setCenter(0.5, 0.5)
      self:moveTo(self.xpos, self.ypos)
   end

   s.update = function(self)
      if currentChange ~= 0 then
         self.zpos = self.baseZPosition + currentZPosition
         self.scale = screenZPosition / self.zpos
         if self.zpos < 50 then
            self:remove()
         end
         self:updateScale()
         self.ypos = initialYpos
         
         self:updatePosition()
         local x,y,w,h = self:getBounds()
         if x+w < 0 or x > 400 or y+h < 0 or y > 240 then
			self:remove()
         end
      end
   end

   s.draw = function(self, x, y, w, h)
      self.image:drawScaled(x, y, self.scale)
   end

   s:go()
end

function myGameSetUp()
   newSpriteFor(1)
end

myGameSetUp()


function playdate.update()
   currentChange = playdate.getCrankChange()
   currentZPosition = currentZPosition + currentChange
   gfx.sprite.update()
end
