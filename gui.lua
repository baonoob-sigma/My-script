-- Kavo UI Library (load từ nguồn chính thức)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Tạo GUI chính (theme đẹp, có drag/move)
local Window = Library.CreateLib("BaoNoob Hub", "DarkTheme")  -- Theme tối + hồng dễ thương

-- Tab Main
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Chức năng chính")

-- Logo mèo của bạn (thay ID nếu cần)
MainSection:NewImage("rbxassetid://140591784309269")  -- Ảnh mèo pixel art cầm cốc

-- Hitbox
local hitboxSize = 15
MainSection:NewSlider("Hitbox Size", "Kéo để chỉnh kích thước", 100, 1, function(s)
    hitboxSize = s
end)

MainSection:NewButton("Áp dụng Hitbox", "Nhấn để apply", function()
    for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            pcall(function()
                local anims = tool:FindFirstChild("Animations")
                if anims then
                    local att = anims:FindFirstChild("AttackAnimations")
                    if att then
                        for _, a in pairs(att:GetChildren()) do
                            local hb = a:FindFirstChild("HitboxSize")
                            if hb and hb:IsA("Vector3Value") then
                                hb.Value = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                            end
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
                            if hb and hb:IsA("Vector3Value") then
                                hb.Value = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Attack Speed
MainSection:NewButton("Attack Speed = 100", "Set ngay", function()
    pcall(function()
        local units = workspace:WaitForChild("Units")
        local unit = units:FindFirstChild(game.Players.LocalPlayer.Name)
        local stats = unit and unit:FindFirstChild("CharStats")
        local speed = stats and stats:FindFirstChild("AttackSpeed")
        if speed then speed.Value = 100 end
    end)
end)

-- Noclip
local noclip = false
MainSection:NewToggle("Noclip", "Xuyên tường (ON/OFF)", function(state)
    noclip = state
    if state then
        game:GetService("RunService").Stepped:Connect(function()
            if noclip then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end)

-- Fly
local fly = false
local flySpeed = 50
MainSection:NewToggle("Fly", "Bay (ON/OFF)", function(state)
    fly = state
    if fly then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local cam = workspace.CurrentCamera
            game:GetService("RunService").RenderStepped:Connect(function()
                if fly then
                    local dir = Vector3.new()
                    local uis = game:GetService("UserInputService")
                    if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                    if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                    if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                    if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                    if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end
                    if dir.Magnitude > 0 then dir = dir.Unit * flySpeed end
                    hrp.Velocity = dir
                end
            end)
        end
    end
end)

MainSection:NewSlider("Fly Speed", "Tốc độ bay", 200, 10, function(s)
    flySpeed = s
end)

-- Fullbright
MainSection:NewToggle("Fullbright", "Sáng max", function(state)
    game.Lighting.Brightness = state and 2 or 1
    game.Lighting.Ambient = state and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
end)

-- Xray
MainSection:NewToggle("Xray", "Nhìn xuyên tường", function(state)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.Transparency = state and 0.3 or 0
        end
    end
end)

-- Unit Tracker (nút mở đơn giản, bạn có thể thêm code tele sau)
MainSection:NewButton("Mở Unit Tracker", "Hiện list unit", function()
    print("Unit Tracker đang mở... (thêm code tele ở đây nếu cần)")
    -- Nếu muốn thêm code Unit Tracker đầy đủ, bảo mình mình bổ sung
end)

print("BaoNoob Hub đã load thành công! 🐱")
