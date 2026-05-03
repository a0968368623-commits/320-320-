local Combat = {}
local Settings = {Size = 15, Enabled = false}

-- 更新開關狀態
function Combat:ToggleHitbox(state)
    Settings.Enabled = state
    -- 如果關閉開關，立即執行一次還原
    if not state then
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1) -- 恢復 Roblox 預設大小
                v.Character.HumanoidRootPart.Transparency = 1 -- 恢復隱形
            end
        end
        print("Hitbox 已關閉並恢復原狀")
    end
end

-- 更新數值
function Combat:UpdateSize(newSize)
    Settings.Size = newSize
end

-- 循環核心
task.spawn(function()
    while task.wait(0.5) do
        if Settings.Enabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end
end)

return Combat
