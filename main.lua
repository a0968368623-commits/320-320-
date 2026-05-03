-- [[ V1 Genesis Reborn - 320 雲端主控 ]]
local Version = "1.0.0"
local BaseURL = "https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/"

print("------------------------------------------")
print("[V1] 正在從 GitHub 加載核心模組...")

-- 雲端加載函數
local function GetCloud(File)
    local Success, Content = pcall(game.HttpGet, game, BaseURL .. File)
    if Success and Content then
        return loadstring(Content)()
    else
        warn("[錯誤] 無法加載模組: " .. File)
        return nil
    end
end

-- 異步加載所有模組，保證速度
local UI = GetCloud("UI_Library.lua")
local Combat = GetCloud("Combat.lua")
local Movement = GetCloud("Movement.lua")

if UI and Combat and Movement then
    print("[成功] 所有模組加載完成！")
    -- 啟動 UI 並傳入功能接口
    UI:Init({
        CombatFunc = Combat,
        MoveFunc = Movement,
        Ver = Version
    })
else
    print("[失敗] 腳本啟動中斷，請檢查網路。")
end
