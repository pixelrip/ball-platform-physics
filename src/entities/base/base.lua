-- Base Entity Class
Entity = {}
Entity.__index = Entity

function Entity.new(opts)
    local opts = opts or {}
    local self = setmetatable({}, Entity)
    
    -- Core Properties
    -- Some invisible entities don't
    -- actually need them.
    
    self.x = opts.x or 0
    self.y = opts.y or 0

    return self
end

function Entity:init() end
function Entity:update() end
function Entity:draw() end
function Entity:destroy() end
