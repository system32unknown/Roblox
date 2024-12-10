local RNG = {}
RNG.__index = RNG

function RNG.Char(valueRange, length):string
    local result = ""
    for _ = 1, length do
        result = result .. utf8.char(math.random(0, valueRange))
    end
    return result
end

function RNG.Vector(n:number):Vector3
    return Vector3.new(math.random(-n, n), math.random(-n, n), math.random(-n, n)) 
end

function RNG.CFrame(positionRange, rotationRange):CFrame
	local randomX = math.random(-positionRange, positionRange)
	local randomY = math.random(-positionRange, positionRange)
	local randomZ = math.random(-positionRange, positionRange)

	local randomRotX = math.rad(math.random(-rotationRange, rotationRange))
	local randomRotY = math.rad(math.random(-rotationRange, rotationRange))
	local randomRotZ = math.rad(math.random(-rotationRange, rotationRange))

	return CFrame.new(randomX, randomY, randomZ) * CFrame.Angles(randomRotX, randomRotY, randomRotZ)
end

return RNG
