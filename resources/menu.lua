-- Creates scene 
menuScene = director:createScene() 
 
-- Create background (via menuScene:setUp)
local background 
-- Game title 
local gameTitle 
-- Create playbutton for users
local playButton 

-- Starts game when playbutton pressed
function newGame(event)
  if event.phase == "ended" then
    switchToScene("game")
  end
end

function menuScene:setUp(event)
  dbg.print("menu set up")
  background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png") 
  background.xAnchor = 0.5 
  background.yAnchor = 0.5 

  gameTitle = director:createLabel(0, director.displayCenterY+(director.displayCenterY/2), "Flappy Beard\nBy Luke O'Hara")
  gameTitle.color = color.red

  playButton = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/start.png")
  playButton.xAnchor = 0.5
  playButton.yAnchor = 0.5

  playButton:addEventListener("touch", newGame)
end

function menuScene:tearDown(event)
  dbg.print("menu torn down")

  playButton:removeEventListener("touch", newGame)

  background = background:removeFromParent()
  gameTitle = gameTitle:removeFromParent()
  playbutton = playButton:removeFromParent()
end

menuScene:addEventListener({"setUp", "tearDown"}, menuScene)

