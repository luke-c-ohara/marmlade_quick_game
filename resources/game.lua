--imports
require("class")
require("object")

local gamePlaying = false
local gameTaps 
physics:setGravity(0, -980*1.5)
local maxEnemies 
local heightAdder 
local widthAdder 
local background 
local player 
local enemyArray 
local startGameHelp 
local resetButton
local menuButton

gameScene = director:createScene()

-- Event listener: touch
function systemEvents(event)
  if event.phase == "began" then
    if player.physics and gamePlaying == true then
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

-- game code, defines what the game does
function init()
  -- remove help label
  startGameHelp.alpha = 0
  physics:addNode(player, {radius = 21}) 
  for i=1,maxEnemies
    do
      enemyArray[i]:getSprite().physics:setLinearVelocity(-160, 0)
  end
  gamePlaying = true
end

--what happens when the game ends
function gameover()
  startGameHelp.text = "You lost bro, you lost"
  startGameHelp.color = color.white
  startGameHelp.alpha = 1
  background.color = color.red
  gamePlaying = false

  for i=1,maxEnemies
    do
    enemyArray[i]:getSprite().physics:setLinearVelocity(0, 0)
  end
  menuButton.alpha = 1
  resetButton.alpha = 1
end

function pressReset(event)
  if event.phase == "ended" then
    reset()
  end
end

function resetEnemies()
  for i=1,maxEnemies
    do 
    enemyArray[i]:getSprite().x = director.displayCenterX -- Move enemies back to start pos
  end

  --creating 6 enemies
  local yx = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
  local yy = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
  local yz = math.random(director.displayCenterY - 350, director.displayCenterY - 100)

  -- sets enemys up as pairs on top and bottom of the screen.
  local a = enemyArray[1]:getSprite().x
  local b = enemyArray[2]:getSprite().x
  local c = enemyArray[3]:getSprite().x - ((director.displayCenterX / 2)*2)
  local d = enemyArray[4]:getSprite().x - ((director.displayCenterX / 2)*2)
  local e = enemyArray[5]:getSprite().x + ((director.displayCenterX / 2)*2)
  local f = enemyArray[6]:getSprite().x + ((director.displayCenterX / 2)*2)

  -- gets columns from the left to reappear on the right.
  enemyArray[1]:getSprite().physics:setTransform(a + widthAdder, yx, 0)
  enemyArray[2]:getSprite().physics:setTransform(b + widthAdder, yx+heightAdder, 0)
  enemyArray[3]:getSprite().physics:setTransform(c + widthAdder, yy, 0)
  enemyArray[4]:getSprite().physics:setTransform(d + widthAdder, yy+heightAdder, 0)
  enemyArray[5]:getSprite().physics:setTransform(e + widthAdder, yz, 0)
  enemyArray[6]:getSprite().physics:setTransform(f + widthAdder, yz+heightAdder, 0)
end

-- giving the option to reset the game
function reset()
  physics:removeNode(player)
  player.x = director.displayCenterX/2
  player.y = director.displayCenterY + (director.displayCenterY/2)
  background.color = color.white
  startGameHelp.alpha = 1
  startGameHelp.color = color.red
  startGameHelp.text = "Tap to start!"
  gameTaps = 0
  resetButton.alpha = 0
  menuButton.alpha = 0
 
  resetEnemies()
end

-- creates the flap(jump) and stops the player moving out of the top of the screen
function jump()
  if player.y < director.displayHeight and player.y > 0 then
    player.physics:setLinearVelocity(0,0)
    player.physics:applyLinearImpulse(0,60)
  end
end

-- constantly checking the game is still going and the player is not off the screen
function updater()
  if gamePlaying == true then
    if player.y < 0 then
      gameover()
    end
    -- constantly updated the columns 
    if (enemyArray[1]:getSprite().x + enemyArray[1]:getSprite().w) + 30 < 0 then
        local y = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
        enemyArray[1]:getSprite().physics:setTransform(director.displayWidth + enemyArray[1]:getSprite().w, y, 0)
        enemyArray[2]:getSprite().physics:setTransform(director.displayWidth + enemyArray[2]:getSprite().w, y+heightAdder, 0)
    end

    if (enemyArray[3]:getSprite().x + enemyArray[3]:getSprite().w) + 30 < 0 then
      local y = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
      enemyArray[3]:getSprite().physics:setTransform(director.displayWidth + enemyArray[3]:getSprite().w, y, 0)
      enemyArray[4]:getSprite().physics:setTransform(director.displayWidth + enemyArray[4]:getSprite().w, y+heightAdder, 0)
    end

    if (enemyArray[5]:getSprite().x + enemyArray[5]:getSprite().w) + 30 < 0 then
      local y = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
      enemyArray[5]:getSprite().physics:setTransform(director.displayWidth + enemyArray[5]:getSprite().w, y, 0)
      enemyArray[6]:getSprite().physics:setTransform(director.displayWidth + enemyArray[6]:getSprite().w, y+heightAdder, 0)
    end
  end
end

-- looking for collison events
function hit(event)
  if event.phase == "began" then
    if event.nodeA.name == "player" then
      if event.nodeB.name == "enemy" then
        gameover()
      end
    elseif event.nodeB.name == "player" then
      if event.nodeA.name == "enemy" then
        gameover()
      end
    end
  end
end

function goToMenu(event)
  if event.phase == 'ended' and menuButton.alpha == 1 then
    switchToScene("menu")
  end
end

-- reordered to start game efficently 
function gameScene:setUp(event)
  gameTaps = 0

  background = director:createSprite(director.displayCenterX, director.displayCenterY, "gfx/background.png")
  background.xAnchor = 0.5
  background.yAnchor = 0.5
  background.rotation = 180

  player = director:createSprite(director.displayCenterX/2, director.displayCenterY + (director.displayCenterY/2), "gfx/player.png")
  player.xAnchor = 0.5
  player.xAnchor = 0.5
  player.name ="player"

  startGameHelp = director:createLabel(0, director.displayCenterY, "Tap to start!")
  startGameHelp.color = color.red

  maxEnemies = 6
  heightAdder = 750
  widthAdder = 600

  enemyArray = {}

  for i=1,maxEnemies
    do
    enemyArray[i] = object.new(i, "gfx/enemy.png")
    enemyArray[i]:getSprite().xAnchor = 0.5
    enemyArray[i]:getSprite().yAnchor = 0.5
    enemyArray[i]:getSprite().name = "enemy"
    enemyArray[i]:getSprite().x = director.displayCenterX
    physics:addNode(enemyArray[i]:getSprite(), {type="kinematic"})
  end

  menuButton = director:createLabel( {
    x=0, y= -90, hAlignment="centre", vAlignment="middle", text="MENU"
    } )
  menuButton.color = color.blue
  menuButton.alpha = 0

  resetButton = director:createLabel( {
    x=0, y= -50, hAlignment="centre", vAlignment="middle", text="RESET"
    } )
  resetButton.color = color.blue
  resetButton.alpha = 0

  menuButton:addEventListener("touch", goToMenu)
  resetButton:addEventListener("touch", pressReset)
  resetEnemies()

  system:addEventListener("touch", systemEvents)
  system:addEventListener("update", updater)

  for i=1, maxEnemies
    do
    enemyArray[i]:getSprite():addEventListener("collision", hit)
  end

end

function gameScene:tearDown(event)
  dbg.print('game scene tear down')
 
  background = background:removeFromParent()
  player = player:removeFromParent() 
  startGameHelp = startGameHelp:removeFromParent()
 
  heightAdder = nil
  widthAdder = nil
 
  for i=1,maxEnemies
  do
    enemyArray[i]:remove()
  end
 
  system:removeEventListener("touch", systemEvents)
  system:removeEventListener("update", updater)
 
  enemyArray = {}
  maxEnemies = nil
end


gameScene:addEventListener({"setUp", "tearDown"}, gameScene) --Called at start and end of scene