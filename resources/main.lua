-- Imports 
dofile("game.lua")
dofile("menu.lua") 
director:setCurrentScene(nil)
director:moveToScene(menuScene)

-- Switch to specific scene
function switchToScene(scene_name)
  if (scene_name == "game") then
    director:moveToScene(gameScene, {transitionType="fade", transitionTime=0.5})
  elseif (scene_name == "menu") then
    director:moveToScene(menuScene)
  end
end
