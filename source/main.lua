import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local sprite = nil

function myGameSetUp()
   local spriteImage = gfx.image.new("images/kan.png")
   sprite = gfx.sprite.new()
   sprite:setImage( spriteImage )
   sprite:setCenter( 0.5, 0.5 )
   sprite:moveTo( 200, 120 )
   sprite:add() 
end

myGameSetUp()

local initialDistance = 400
local distance = initialDistance

local moveTwo = false
print(utf8.codepoint("菩"))

function playdate.update()
   local change = playdate.getCrankChange()
   if change ~= 0 then
      distance = distance + change * 5
      sprite:setScale(initialDistance / distance)
      sprite:setCenter( 0.5, 0.5 )
      local y = 120 - distance * 0.01
      sprite:moveTo( 200, y )
   end
   gfx.sprite.update()

end
