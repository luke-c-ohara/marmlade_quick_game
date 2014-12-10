gameScene = director:createScene()
 
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png")

background.xAnchor = 0.5
background.yAnchor = 0.5
background.rotation = 180

local player = director:createSprite(director.displayCenterX/2, director.displayCenterY + (director.displayCenterY/2), "gfx/player.png")

player.xAnchor = 0.5
player.xAnchor = 0.5

physics:addNode(player, {radius = 21})
