-- [[ V1 320 核心引導程序 ]]
local BaseURL = "https://raw.githubusercontent.com/a0968368623-提交/320-320-/main/Modules/"

-- 建立一個函數來抓取模塊
local function LoadModule(FileName)
    local Success, Content = pcall(game.HttpGet, game, BaseURL .. FileName)
    if Success then
        return loadstring(Content)()
    else
        warn("無法加載模塊: " .. FileName)
    end
end

-- 依序加載功能
LoadModule("UI_Library.lua") -- 加載 UI 與 320 按鈕
LoadModule("Combat.lua")     -- 加載戰鬥模塊
LoadModule("Movement.lua")   -- 加載移動模塊
