-- platform "module"

Platform = {}
Platform.__index = Platform

setmetatable(Platform, {__index = Entity })

function Platform.new(opts)
	local opts = opts or {}
	local self = Entity.new()
	
	setmetatable(self, Platform)

	-- Set platform properties

	self.base_y1 = opts.y1
	self.base_y2 = opts.y2

	self.amplitude_y1 = rnd_between(5, 10)
	self.amplitude_y2 = rnd_between(5, 10)
	self.speed_y1 = rnd_between(1, 3)
	self.speed_y2 = rnd_between(1, 3)


	self.x1 = opts.x1
	self.y1 = opts.y1
	self.x2 = opts.x2
	self.y2 = opts.y2
	self.lowest_y = max(self.y1, self.y2)

	self.col = opts.col or 7
	self.bounce = opts.bounce or 0.8
	
	-- pre-calculate slope (m) and y-intercept (c)
	self.m = get_slope(self.x1, self.y1, self.x2, self.y2)
	self.c = get_y_intercept(self.m, self.x1, self.y1)

	return self
end

function Platform:update()
	local t1 = t() * self.speed_y1
	local t2 = t() * self.speed_y2
	local y1_offset = cos(t1) * self.amplitude_y1
	local y2_offset = sin(t2) * self.amplitude_y2

	self.y1 = self.base_y1 + y1_offset
	self.y2 = self.base_y2 + y2_offset

	self.lowest_y = max(self.y1, self.y2)
	self.m = get_slope(self.x1, self.y1, self.x2, self.y2)
	self.c = get_y_intercept(self.m, self.x1, self.y1)
end


function Platform:draw()
	line(self.x1, self.y1, self.x2, self.y2, self.col)
end