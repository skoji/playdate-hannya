import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local sprite = nil
local sprite2 = nil

function myGameSetUp()
   local spriteImage3 = gfx.image.new("images/zai.png")
   sprite3 = gfx.sprite.new()
   sprite3:setImage(spriteImage3)
   sprite3:setCenter(0.5, 0.5)
   sprite3:moveTo(200,120)
   sprite3:setZIndex(-10)
   local spriteImage2 = gfx.image.new("images/ji.png")
   sprite2 = gfx.sprite.new()
   sprite2:setImage(spriteImage2)
   sprite2:setCenter(0.5, 0.5)
   sprite2:moveTo(200,120)
   sprite2:setZIndex(0)
   local spriteImage = gfx.image.new("images/kan.png")
   sprite = gfx.sprite.new()
   sprite:setImage( spriteImage )
   sprite:setCenter( 0.5, 0.5 )
   sprite:moveTo( 200, 120 )
   sprite:setZIndex(10)
   sprite3:add()
   sprite2:add()
   sprite:add() 
   
   
end
gfx.setColor(gfx.kColorBlack)
gfx.fillRect(0,0,400,240)
myGameSetUp()
playdate.timer:start()
local moveTwo = false
function playdate.update()
   local change = playdate.getCrankChange()
   sprite:moveBy(0, change)
   if moveTwo then
      sprite2:moveBy(0, change)
   end
   local x, y = sprite:getPosition()
   if change < 0 and y < -150 then
      moveTwo = true
   end
   if moveTwo then
      local x2, y2 = sprite2:getPosition()
      if change > 0 and y2 > 120 then
         moveTwo = false
         sprite:moveTo(200,120)
      end
   end
   
   gfx.sprite.update()
   playdate.timer.updateTimers()
end
