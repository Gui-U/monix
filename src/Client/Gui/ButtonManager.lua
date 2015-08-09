local Card = require "Gui/Card"
local ButtonManager = {}

ButtonManager.buttonList = {}
ButtonManager.defaultButton = Card:new{
	color=	{0,255,0,255},
	size=	{height=60, width=120},
	position=	{x=100,y=100},
	title=	"Compte",
	account=	"root",
	credit=	"-1",
}

function ButtonManager:default(buttonAttribute)
	for k,v in pairs(buttonAttribute) do
		self.defaultButton[k] = v
	end
end

function ButtonManager:newButton(o)
	local newButton = {
		position= {
			x=	o.x or self.defaultButton.position.x,
			y=	o.y or self.defaultButton.position.y
		},
		size= {
			width=	o.width or self.defaultButton.size.width,
			height=	o.height or self.defaultButton.size.height
		},
		color= {
			unpack(o.color or self.defaultButton.color)
		},
		title = o.title or self.defaultButton.title,
		account = o.account or self.defaultButton.account,
		credit = o.credit or self.defaultButton.credit
	}
	
	local button = Card:new(newButton)
	table.insert(self.buttonList, button)
	return button
end

love.mousepressed = function(x, y, button)
	if button == "l" then
		for k,v in ipairs(ButtonManager.buttonList) do
			if v:isIn(x,y) then
				v.isPressed = true
			end
		end
	end
end

love.mousereleased = function(x, y, button)
	if button == "l" then
		for k,v in ipairs(ButtonManager.buttonList) do
			if v:isIn(x,y) then
				if v.isPressed then
					love.event.push("buttonevent","click",k)
				end
			end
			v.isPressed = false
		end
	end
end

love.handlers.buttonevent = function(what, key, c, d)
	local object = ButtonManager.buttonList[key]
	if type(object[what]) == "function" then
		object[what](object,c,d)
	end
--	print(object,"is "..what)
end

function ButtonManager:draw()
	for k,v in ipairs(self.buttonList) do
		v:draw()
	end
end

return ButtonManager
