ButtonManager = require "Gui/ButtonManager"

function love.load()
end

function love.update(dt)
end

ButtonManager:default({color= {0,255,0,255}})
local testButton2 = ButtonManager:newButton(400,400)
testButton2.click = function(self)
	print(self, "button2 click")
end
function love.draw()
	testButton2:draw()
end

