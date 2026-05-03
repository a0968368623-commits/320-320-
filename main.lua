-- [[ 320 Master 雲端主控 ]]
local BaseURL = "[https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/](https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/)"

local function GetCloud(File)
    local s, content = pcall(game.HttpGet, game, BaseURL .. File .. "?t=" .. os.time())
    return s and loadstring(content)() or nil
end

local UI = GetCloud("UI_Library.lua")
local Move = GetCloud("Movement.lua")

if UI and Move then
    -- 將 Move 模組傳進 UI 初始化
    UI:Init({
        MoveFunc = Move -- 這是關鍵，沒傳進去按鈕就沒反應
    })
    print("[V1] 雲端加載成功！")
else
    warn("[V1] 模組遺失，請檢查 GitHub 檔名")
end
