----------------------------------------
-- KryptonForce102
-- Written for:

--[[

Copyright (c) 2021 KryptonForce102

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]--
----------------------------------------

local RunService = game:GetService("RunService") -- 1

local Sin = math.sin -- 2
local Cos = math.cos -- 3
local Clamp = math.clamp -- 4

local Clock = os.clock -- 5

function animateWater(waterObject, animateSpeed) -- 6, 7, 8	
	task.spawn(function() -- 9	
		local blockMesh = waterObject:FindFirstChildOfClass("BlockMesh") -- 10
		if not blockMesh then -- 11
			return
		end
		
		local lerpPercent = 0 -- 12
		local lerpDuration = 2 -- 13
		
		local startingOffset = blockMesh.Offset -- 14
		local animateConnection -- 15
		
		animateConnection = RunService.RenderStepped:Connect(function(step) -- 16
			local newOffset = Vector3.new(
				Cos(Clock()) * animateSpeed, -- 17
				blockMesh.Offset.Y, -- 18
				Sin(Clock()) * animateSpeed -- 19
			)

			if lerpPercent < 1 then -- 20
				lerpPercent += step / lerpDuration -- 21
			end

			blockMesh.Offset = (
				lerpPercent < 1 and 
				startingOffset:Lerp(newOffset, Clamp(lerpPercent, 0, 1)) 
				or newOffset
			) -- 22

			if not waterObject then -- 23
				animateConnection:Disconnect() -- 24
			end
		end)
	end)
end

animateWater(workspace.MapMakingKit.Intro._Water1, 4)
