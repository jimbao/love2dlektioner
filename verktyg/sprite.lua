Sprite = {}
Sprite.__index = Sprite

setmetatable(Sprite, {
  __call = function (cls, ...)
    return cls.ny(...)
  end,
})

function Sprite.ny(x, y, ...)
  local self = setmetatable({}, Sprite)
  self.x = x
  self.y = y
  return self
end

function Sprite:rita()
    
end

function Sprite:uppdatera()
    self.x = self.x + 3
    self.y = self.y + 3
end
