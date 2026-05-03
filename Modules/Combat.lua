-- [[ V1 320 戰鬥模塊 ]]
local Combat_Mod = {}
function Combat_Mod:Init(Settings)
    -- 這裡專門放 Hitbox 巨大化與自動攻擊邏輯
    -- 修復你影片中 Hitbox 消失的 Bug
    task.spawn(function()
        while task.wait(0.5) do
            if Settings.Hitbox then
                -- 執行 Hitbox 注入...
            end
        end
    end)
end
return Combat_Mod
