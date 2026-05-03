-- [[ V1 320 移動模塊 ]]
local Move_Mod = {}
function Move_Mod:Start(Settings)
    -- 這裡放飛行功能，修復影片 0:12 的回彈問題
    game:GetService("RunService").Heartbeat:Connect(function()
        if Settings.Fly then
            -- 執行穩定飛行邏輯...
        end
    end)
end
return Move_Mod
