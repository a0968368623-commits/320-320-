local Combat = {}
_G.HitboxEnabled = false -- 使用全域變數確保 UI 100% 能控制
_G.HitboxSize = 15

function Combat:ToggleHitbox(state)
    _G.HitboxEnabled = state
    print("Combat 模組接收到狀態:", state)
    
    -- 核心修復：關閉時「強制」還原所有玩家大小
    if not state then
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                v.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end

function Combat:UpdateSize(newSize)
    _G.HitboxSize = newSize
end

-- 循環檢查
task.spawn(function()
    while true do
        task.wait(0.2) -- 縮短檢查頻率，反應更快
        if _G.HitboxEnabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end
end)

return Combat
