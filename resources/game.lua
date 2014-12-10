local gameTaps = 0
physics:setGravity(0, -980*1.5)

gameScene = director:createScene()

-- adds background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png")

background.xAnchor = 0.5
background.yAnchor = 0.5
background.rotation = 180

-- adds users image
local player = director:createSprite(director.displayCenterX/2, director.displayCenterY + (director.displayCenterY/2), "gfx/player.png")

player.xAnchor = 0.5
player.xAnchor = 0.5

-- Start game label 
local startGameHelp = director:createLabel(0, director.displayCenterY, "Tap to start!")
startGameHelp.color = color.red

-- Event listener: touch
function systemEvents(event)
  if event.phase == "began" then
    if player.physics then
      jump()
    end
  elseif event.phase == "ended" then
    gameTaps = gameTaps + 1
    dbg.print('Taps:' ..gameTaps)
      if gameTaps == 2 then
        init()
      end
  end
end

system:addEventListener("touch", systemEvents)

-- game code, defines what the game does
function init()
  physics:addNode(player, {radius = 21})
  -- remove help label
  startGameHelp.alpha = 0
end

function gameover()
  local startGameHelp = director:createLabel(0, director.displayCenterY, "YOU LOST BRO! YOU LOST!")
  background.color = color.red
end

function reset()

end
-- creates the flap(jump) and stops the player moving out of the top of the screen
function jump()
  if player.y < director.displayHeight and player.y > 0 then
    player.physics:setLinearVelocity(0,0)
    player.physics:applyLinearImpulse(0,60)
  end
end

function updater()
  if player.y < 0 then
    gameover()
  end
end

system:addEventListener("update", updater)