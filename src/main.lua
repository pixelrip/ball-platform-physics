function _init()

	-- Entity collections
	balls = {}
	platforms = {}

	-- Create a couple of balls
	for i = 1, 15 do
		add(balls, Ball.new({
			x = rnd_between(10, 120),
			y = 0,
			r = 2,
			col = i
		}))
	end

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

	for platform in all(platforms) do
		platform:update()
	end
end

function _draw()
	cls(0)

	for ball in all(balls) do
		ball:draw()
	end

	for platform in all(platforms) do
		platform:draw()
	end
end