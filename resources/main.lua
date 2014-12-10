-- Imports 
dofile("menu.lua") 
--

-- Switch to specific scene

function switchToScene(scene_name)
  if (scene_name == "game") then
    dofile("game.lua")
    director:moveToScene(gameScene)
  end
end