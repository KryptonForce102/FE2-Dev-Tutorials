----------------------------------------
-- KryptonForce102
-- Written for: https://forum.crazyblox.games/t/fe2-dev-tutorial-2-how-to-add-camera-manipulation-to-your-map/43988
-- Created: 26/10/2021 @ 9:10 PM (AEST)
-- Updated: 26/10/2021 @ 9:10 PM (AEST)

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
local Players = game:GetService("Players") -- 2

local player = Players.LocalPlayer -- 3
local character = player.Character or player.CharacterAdded:Wait() -- 4

-- 5

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local map = workspace.Multiplayer:WaitForChild("Map") -- 6
local startCamera = map:WaitForChild("StartCamera") -- 7
local stopCamera = map:WaitForChild("StopCamera") -- 8
local currentCamera = workspace.CurrentCamera -- 9

function stopCurrentCamera() -- 10
	RunService:UnbindFromRenderStep("CameraEffect") -- 11
	currentCamera.CameraType = Enum.CameraType.Custom -- 12
end

startCamera.OnClientEvent:Connect(function(cameraPart) -- 13, 14
	currentCamera.CameraType = Enum.CameraType.Scriptable -- 15
	RunService:BindToRenderStep("CameraEffect", Enum.RenderPriority.Camera.Value, function(step) -- 16
		currentCamera.CFrame = CFrame.new(cameraPart.Position, humanoidRootPart.Position) -- 17
	end)
end)

stopCamera.OnClientEvent:Connect(stopCurrentCamera) -- 18
humanoid.Died:Connect(stopCurrentCamera) -- 19
map.AncestryChanged:Connect(stopCurrentCamera) -- 20
