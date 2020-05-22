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
   local ypos = 0
   local xpos = 0

   local s = gfx.sprite.new()
   
   s.go = function(self)
      self.baseZPosition = baseZPosition
      self.zpos = baseZPosition + currentZPosition
      self.image = image
      self.xpos = xpos
      self:updateScale()
      self.ypos = ypos
      self:updatePosition()
      self:add()
   end

   s.updateScale = function(self)
      self.scale = screenZPosition / self.zpos
      self:setSize(self.image.width * self.scale, self.image.height * self.scale)
   end

   s.updatePosition = function(self)
      self:setCenter(0.5, 0.5)
      local x = self.xpos * self.scale + 200
      local y = self.ypos * self.scale + 120
      self:moveTo(x, y)
   end

   s.update = function(self)
      if currentChange ~= 0 then
         self.zpos = self.baseZPosition + currentZPosition
         self.scale = screenZPosition / self.zpos
         if self.zpos < 50 then
            self:remove()
         end
         if self.zpos > 8000 then
            self:remove()
         end
         self:updateScale()
         self:updatePosition()
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
   --   currentChange = playdate.getCrankChange()
   currentChange = 2
   currentZPosition = currentZPosition + currentChange
   gfx.sprite.update()
end
