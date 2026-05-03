local Combat = {}
local currentSize = 15 -- 預設大小

function Combat:UpdateSize(newSize)
    currentSize = newSize
    -- 立即套用更新
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart
            hrp.Size = Vector3.new(currentSize, currentSize, currentSize)
            hrp.Transparency = 0.5 -- 稍微透明方便觀察範圍
            hrp.CanCollide = false -- 防止碰撞造成噴飛
        end
    end
end

-- 循環確保新加入的玩家也會被改變
task.spawn(function()
    while task.wait(1) do
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(currentSize, currentSize, currentSize)
            end
        end
    end
end)

return Combat
