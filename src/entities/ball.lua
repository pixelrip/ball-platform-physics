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
	self.bot = self.y + self.r
	self.top = self.y - self.r
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

	-- update ball bounds
	self.bot = self.y + self.r
	self.top = self.y - self.r

	-- check for collisions with platforms
	for platform in all(platforms) do
		local platform_y_at_ball = self:_check_collision(platform)
	
		if platform_y_at_ball then

			-- Correct Position
			self.y = platform_y_at_ball - self.r

			-- simple collision response: invert y velocity
			self.vy = _prev_vy * -platform.bounce

			self.vx += platform.m * _prev_vy * 0.5 -- Tuning factor
		end			
	end

end

function Ball:draw()
	circ(self.x, self.y, self.r, self.col)
end

-- "Private" methods
function Ball:_check_collision(platform)
	local platform_y_at_ball = (platform.m * self.x) + platform.c

	if self.bot >= platform_y_at_ball and
		self.top <= platform.lowest_y and
		self.x >= platform.x1 and
		self.x <= platform.x2 then
		return platform_y_at_ball
	end

	return false
end