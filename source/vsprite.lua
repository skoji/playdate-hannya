import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/object"
local gfx <const> = playdate.graphics

class("VSprite").extends(Object)

local screenZpos = 400
local minZpos = 50
local maxZpos = 4000

function VSprite:init(baseZpos, currentZpos, image, xpos, ypos)
   self.baseZpos = baseZpos
   self.zpos = baseZpos + currentZpos
   self.xpos = xpos
   self.ypos = ypos
   self.image = image
   self.active = false
end

function VSprite:updateScale()
   if (self.zpos > 50) then
      self.scale = screenZpos / self.zpos
      self.sprite:setSize(self.image.width * self.scale, self.image.height * self.scale)
   else
      self.scale = 0
   end
end

function VSprite:updatePosition()
   if self.active then
      self.sprite:setCenter(0.5, 0.5)
      local x = self.xpos * self.scale + 200
      local y = self.ypos * self.scale + 120
      self.sprite:moveTo(x, y)
   end
end

function VSprite:checkZpos()
   return self.zpos >= minZpos and self.zpos <= maxZpos
end

function VSprite:activate()
   if self.active == false then
      self.active = true
      self.sprite = gfx.sprite.new()
      self.sprite.draw = function(_, x, y, w, h) 
         self.image:drawScaled(x, y, self.scale)
      end
      self.sprite:add()
   end
end

function VSprite:deactivate()
   if self.active == true then
      self.sprite:remove()
      self.sprite = nil
      self.active = false
   end
end

function VSprite:update(currentZpos)
   self.zpos = self.baseZpos + currentZpos
   if self:checkZpos() then
      self:activate()
      self:updateScale()
      self:updatePosition()
      local x,y,w,h = self.sprite:getBounds()
   else
      self:deactivate()
   end
end




