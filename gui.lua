loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BaoNoob Hub", "DarkTheme")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Chức năng chính")

-- Ảnh mèo của bạn
MainSection:NewImage("rbxassetid://140591784309269")

-- Hitbox
local hitboxSize = 15
MainSection:NewSlider("Hitbox Size", "Chỉnh kích thước hitbox", 100, 1, function(value)
    hitboxSize = value
end)

MainSection:NewButton("Apply Hitbox", "Áp dụng ngay", function()
    for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            pcall(function()
                local anims = tool:FindFirstChild("Animations")
                if anims then
                    local att = anims:FindFirstChild("AttackAnimations")
                    if att then
                        for _, a in pairs(att:GetChildren()) do
                            local hb = a:FindFirstChild("HitboxSize")
                            if hb and hb:IsA("Vector3Value") then hb.Value = Vector3.new(hitboxSize, hitboxSize, hitboxSize) end
                        end
                    end
                end
            end)
        end
    end
    for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            pcall(function()
                local anims = tool:FindFirstChild("Animations")
                if anims then
                    local att = anims:FindFirstChild("AttackAnimations")
                    if att then
                        for _, a in pairs(att:GetChildren()) do
                            local hb = a:FindFirstChild("HitboxSize")
                            if hb and hb:IsA("Vector3Value") then hb.Value = Vector3.new(hitboxSize, hitboxSize, hitboxSize) end
                        end
                    end
                end
            end)
        end
    end
end)

-- Attack Speed
MainSection:NewButton("Attack Speed = 100", "Auto set", function()
    pcall(function()
        local units = workspace:WaitForChild("Units")
        local unit = units and units:FindFirstChild(game.Players.LocalPlayer.Name)
        local stats = unit and unit:FindFirstChild("CharStats")
        local speed = stats and stats:FindFirstChild("AttackSpeed")
        if speed then speed.Value = 100 end
    end)
end)

-- Noclip, Fly, Fullbright, Xray (giữ nguyên như cũ)

-- ====================== UNIT TRACKER ======================
MainSection:NewButton("Load Unit Tracker", "Mở danh sách unit + Teleport", function()
    local player = game.Players.LocalPlayer
    local old = player.PlayerGui:FindFirstChild("UnitTracker")
    if old then old:Destroy() end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UnitTracker"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 350)
    frame.Position = UDim2.new(0.5, -150, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    title.Text = "Unit Tracker"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -40)
    scroll.Position = UDim2.new(0, 10, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 4)
    listLayout.Parent = scroll

    local function updateList()
        for _, child in ipairs(scroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local unitsFolder = workspace:FindFirstChild("Units")
        if not unitsFolder then return end

        for _, unit in ipairs(unitsFolder:GetChildren()) do
            if unit:IsA("Model") and unit.Name ~= "Clerk" then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -10, 0, 30)
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                btn.Text = unit.Name
                btn.TextColor3 = Color3.new(1,1,1)
                btn.TextSize = 14
                btn.Parent = scroll

                btn.MouseButton1Click:Connect(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp and unit then
                        local targetPart = unit.PrimaryPart or unit:FindFirstChildOfClass("BasePart")
                        if targetPart then
                            local pos = targetPart.Position
                            local ray = workspace:Raycast(pos, Vector3.new(0, -100, 0))
                            local ground = ray and ray.Position or pos
                            hrp.CFrame = CFrame.new(ground + Vector3.new(0, 5, 0))
                        end
                    end
                end)
            end
        end
        scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end

    updateList()
    task.spawn(function()
        while task.wait(3) do
            if screenGui.Parent then updateList() end
        end
    end)

    -- Drag
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)

print("✅ GUI Kavo + Unit Tracker đầy đủ đã load!")
