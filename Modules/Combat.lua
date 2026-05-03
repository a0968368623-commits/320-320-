local Combat = {}

-- 初始化全域變數
_G.HitboxEnabled = false
_G.HitboxSize = 15

function Combat:ToggleHitbox(state)
    _G.HitboxEnabled = state
    
    -- 如果關閉，立刻強制還原場上所有人的大小
    if not state then
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1) -- Roblox 預設值
                v.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end

function Combat:UpdateSize(newSize)
    _G.HitboxSize = newSize
end

-- 獨立循環線程
task.spawn(function()
    while true do
        task.wait(0.1) -- 提高偵測頻率，讓開關反應更快
        if _G.HitboxEnabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    -- 根據全域變數即時調整大小
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end
end)

return Combat
