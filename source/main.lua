import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "hannyatext"

local gfx <const> = playdate.graphics

function fileForChar(c)
   return "images/"..utf8.codepoint(c)..".png"
end

local initialDistance = 400
local currentPosition = initialDistance
local currentChange = 0

function newSpriteFor(count)
   local char = hannyatext[count]
   local imageName = fileForChar(char)
   local image = gfx.image.new(imageName)
   local initialYpos = 380
   local initialDistanceDiff = -300
   local s = gfx.sprite.new()
   s.go = function(self)
      self.distance = initialDistance + initialDistanceDiff
      self.image = image
      self.xpos = 200
      self.ypos = initialYpos
      self:updateScale()
      self:updatePosition()
      self:add()
   end

   s.updateScale = function(self)
      self.scale = initialDistance / self.distance
      self:setSize(self.image.width * self.scale, self.image.height * self.scale)
   end

   s.updatePosition = function(self)
      self:setCenter(0.5, 0.5)
      self:moveTo(self.xpos, self.ypos)
   end

   s.update = function(self)
      if currentChange ~= 0 then
         self.distance = self.distance + currentChange * 5
         self.scale = initialDistance / self.distance
         self.ypos = initialYpos - (self.distance - (initialDistance + initialDistanceDiff)) * 0.9 * self.scale
         if self.distance < 50 then
            self:remove()
         end
         self:updateScale()
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
   gfx.sprite.update()
end
