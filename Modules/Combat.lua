local Combat = {}
local Settings = {Size = 15, Enabled = false}

function Combat:ToggleHitbox(state)
    Settings.Enabled = state
end

-- 新增：讓 UI 可以隨時調整大小
function Combat:UpdateSize(newSize)
    Settings.Size = newSize
end

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
