function _init()

	-- Entity collections
	balls = {}
	platforms = {}

	-- Create a couple of balls
	add(balls, Ball.new({
		x = 10,
		y = 0,
		r = 2,
		col = 7,
	}))

	add(balls, Ball.new({
		x = 110,
		y = 0,
		r = 2,
		col = 10,
	}))

	-- Creat a couple of platforms

	add(platforms, Platform.new({
		x1 = 2,
		y1 = 64,
		x2 = 50,
		y2 = 70,
		col = 7,
	}))

	add(platforms, Platform.new({
		x1 = 40,
		y1 = 90,
		x2 = 80,
		y2 = 94,
		col = 7,
	}))

	add(platforms, Platform.new({
		x1 = 90,
		y1 = 110,
		x2 = 120,
		y2 = 105,
		col = 7,
	}))
end

function _update()
	for ball in all(balls) do
		ball:update(platforms)
	end
end

function _draw()
	cls(1)

	for ball in all(balls) do
		ball:draw()
	end

	for platform in all(platforms) do
		platform:draw()
	end
end