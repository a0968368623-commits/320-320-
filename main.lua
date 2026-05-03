-- [[ 320 Master 雲端主控 ]]
local BaseURL = "https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/"

local function GetCloud(File)
    local s, content = pcall(game.HttpGet, game, BaseURL .. File .. "?t=" .. os.time())
    return s and loadstring(content)() or nil
end

local UI = GetCloud("UI_Library.lua")
local Move = GetCloud("Movement.lua")
local Combat = GetCloud("Combat.lua") -- 新增：加載戰鬥模組

if UI and Move and Combat then
    UI:Init({
        MoveFunc = Move,
        Combat = Combat -- 新增：把 Combat 傳給 UI 使用
    })
    print("[V1] 雲端加載成功！")
else
    warn("[V1] 模組遺失，請檢查 GitHub 檔名")
end
