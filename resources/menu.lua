-- Creates scene 
menuScene = director:createScene() 
 
-- Create background: 
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png") 
background.xAnchor = 0.5 
background.yAnchor = 0.5 

-- Game title 
local gameTitle = director:createLabel(0, director.displayCenterY+(director.displayCenterY/2), "Flappy Beard\nBy Luke O'Hara")
gameTitle.color = color.red

-- Starts game when playbutton pressed

function newGame(event)
  if event.phase == "ended" then
    switchToScene("game")
  end
end

-- Create playbutton for users

local playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/start.png")

playButton.xAnchor = 0.5
playButton.yAnchor = 0.5
playButton:addEventListener("touch", newGame)

