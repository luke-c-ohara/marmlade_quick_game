--[[
A gem game object
--]]

module(..., package.seeall)

-- OO functions
require("class")

-- Create the gem class
object = inheritsFrom(baseClass)

-- Constants
width = 40
height = 40

-- Creates an instance of a new gem
function new(type, image)
  local o = object:create()
  object:init(o, type, image)  
  return o
end

-- Initialise the gem
function object:init(o, type, image)
-- Create a sprite

o.sprite = director:createSprite(0, 0, image)

-- Calculate scale based on sprites texture size
--o.sprite.xScale = width / o.sprite.w
--o.sprite.yScale = height / o.sprite.h
o.type = type
end

function object:getSprite()
  return self.sprite
end

function object:getX()
  return self.x
end

function object:getY()
  return self.y
end

function object:setPos(pX, pY)
  self.sprite.x = pX
  self.sprite.y = pY
end
