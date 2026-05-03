local Combat = {}
_G.HitboxEnabled = false
_G.HitboxSize = 15

function Combat:ToggleHitbox(state)
    _G.HitboxEnabled = state
    if not state then
        -- 關閉時強制還原所有人大小
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

task.spawn(function()
    while true do
        task.wait(0.1)
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
