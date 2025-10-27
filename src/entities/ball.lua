-- ball "module"
Ball = {}
Ball.__index = Ball

setmetatable(Ball, {__index = Entity })

function Ball.new(opts)
	local opts = opts or {}
	local self = Entity.new({
		x = opts.x or 0,
		y = opts.y or 0
	})

	setmetatable(self, Ball)

	-- Set ball properties
	self.vx = 0
	self.vy = 0
	self.r = opts.r or 2
	self.col = opts.col or 7
	self.gravity = opts.gravity or 0.2

	return self
end

function Ball:update(platforms)
	local _prev_vy = self.vy

	-- apply gravity to ball velocity
	self.vy += self.gravity

	-- apply velocity to ball position
	self.x += self.vx
	self.y += self.vy

	-- check for collisions with platforms
	for platform in all(platforms) do
		if self:_check_collision(platform) then
			local _prev_vy = self.vy
			local _platform_y_at_ball = (platform.m * self.x) + platform.c

	
			-- Correct Position
			self.y = _platform_y_at_ball - self.r

			-- simple collision response: invert y velocity
			self.vy = _prev_vy * -platform.bounce

			self.vx += platform.m * _prev_vy * 1 -- Tuning?
		end			
	end

end

function Ball:draw()
	circ(self.x, self.y, self.r, self.col)
end

-- "Private" methods
function Ball:_check_collision(platform)
	local platform_y_at_ball = (platform.m * self.x) + platform.c

	if self.y + self.r >= platform_y_at_ball and 
		self.x >= platform.x1 and
		self.x <= platform.x2 then
		return true
	end

	return false
end