-- Creates scene 
menuScene = director:createScene() 
 
-- Create background: 
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png") 
background.xAnchor = 0.5 
background.yAnchor = 0.5 

-- Create playbutton for users

local playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/start.png")

playButton.xAnchor = 0.5
playButton.yAnchor = 0.5