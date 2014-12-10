--imports
require("class")
require("object")

local gameTaps = 0
physics:setGravity(0, -980*1.5)
local maxEnemies = 6
local heightAdder = 750
local widthAdder = 600

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

--creating 6 enemies
local yx = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
local yy = math.random(director.displayCenterY - 350, director.displayCenterY - 100)
local yz = math.random(director.displayCenterY - 350, director.displayCenterY - 100)

local enemyArray = {}
for i=1,maxEnemies
  do
  enemyArray[i] = object.new(i, "gfx/enemy.png")
  enemyArray[i]:getSprite().xAnchor = 0.5
  enemyArray[i]:getSprite().yAnchor = 0.5
  enemyArray[i]:getSprite().x = director.displayCenterX
  physics:addNode(enemyArray[i]:getSprite(), {type="kinematic"})
end

local a = enemyArray[1]:getSprite().x
local b = enemyArray[2]:getSprite().x
local c = enemyArray[3]:getSprite().x - ((director.displayCenterX / 2)*2)
local d = enemyArray[4]:getSprite().x - ((director.displayCenterX / 2)*2)
local e = enemyArray[5]:getSprite().x + ((director.displayCenterX / 2)*2)
local f = enemyArray[6]:getSprite().x + ((director.displayCenterX / 2)*2)

enemyArray[1]:getSprite().physics:setTransform(a + widthAdder, yx, 0)
enemyArray[2]:getSprite().physics:setTransform(b + widthAdder, yx+heightAdder, 0)
enemyArray[3]:getSprite().physics:setTransform(c + widthAdder, yy, 0)
enemyArray[4]:getSprite().physics:setTransform(d + widthAdder, yy+heightAdder, 0)
enemyArray[5]:getSprite().physics:setTransform(e + widthAdder, yz, 0)
enemyArray[6]:getSprite().physics:setTransform(f + widthAdder, yz+heightAdder, 0)

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
  for i=1,maxEnemies
    do
      enemyArray[i]:getSprite().physics:setLinearVelocity(-160, 0)
  end
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