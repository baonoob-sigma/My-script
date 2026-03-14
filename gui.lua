local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local screen = Instance.new("ScreenGui")
screen.Name = "MyOwnGUI"
screen.ResetOnSpawn = false
screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screen

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- ẢNH MÈO CỦA BẠN
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 120, 0, 120)
logo.Position = UDim2.new(0.5, -60, 0, 10)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://1234567890"  -- ← THAY SAU KHI UPLOAD ẢNH
logo.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 140)
title.BackgroundTransparency = 1
title.Text = "GUI RIÊNG CỦA BẠN"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Parent = mainFrame
close.MouseButton1Click:Connect(function() screen:Destroy() end)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -200)
scroll.Position = UDim2.new(0, 10, 0, 190)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = mainFrame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.Parent = scroll

-- Nút Hitbox
local btnHitbox = Instance.new("TextButton")
btnHitbox.Size = UDim2.new(1, -10, 0, 40)
btnHitbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnHitbox.Text = "Hitbox Size = 15"
btnHitbox.TextColor3 = Color3.new(1,1,1)
btnHitbox.Parent = scroll
btnHitbox.MouseButton1Click:Connect(function()
	local size = 15
	for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
		if tool:IsA("Tool") then
			pcall(function()
				local anims = tool:FindFirstChild("Animations")
				if anims then
					local att = anims:FindFirstChild("AttackAnimations")
					if att then
						for _, a in pairs(att:GetChildren()) do
							local hb = a:FindFirstChild("HitboxSize")
							if hb and hb:IsA("Vector3Value") then hb.Value = Vector3.new(size,size,size) end
						end
					end
				end
			end)
		end
	end
	for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			pcall(function()
				local anims = tool:FindFirstChild("Animations")
				if anims then
					local att = anims:FindFirstChild("AttackAnimations")
					if att then
						for _, a in pairs(att:GetChildren()) do
							local hb = a:FindFirstChild("HitboxSize")
							if hb and hb:IsA("Vector3Value") then hb.Value = Vector3.new(size,size,size) end
						end
					end
				end
			end)
		end
	end
end)

scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
