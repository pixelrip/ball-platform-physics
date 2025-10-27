-- platform "module"

Platform = {}
Platform.__index = Platform

setmetatable(Platform, {__index = Entity })

function Platform.new(opts)
	local opts = opts or {}
	local self = Entity.new()
	
	setmetatable(self, Platform)

	-- Set platform properties
	self.x1 = opts.x1
	self.y1 = opts.y1
	self.x2 = opts.x2
	self.y2 = opts.y2
	self.col = opts.col or 7
	self.bounce = opts.bounce or 0.8
	
	-- pre-calculate slope (m) and y-intercept (c)
	self.m = get_slope(self.x1, self.y1, self.x2, self.y2)
	self.c = get_y_intercept(self.m, self.x1, self.y1)

	return self
end

function Platform:draw()
	line(self.x1, self.y1, self.x2, self.y2, self.col)
end