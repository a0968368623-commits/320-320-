-- [[ 320 Master 雲端主控 ]]
-- 確保網址開頭是 https 並以 / 結尾
local BaseURL = "https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/"

local function GetCloud(File)
    local success, content = pcall(function()
        return game:HttpGet(BaseURL .. File .. "?t=" .. os.time())
    end)

    if success and content then
        local func, err = loadstring(content)
        if func then
            print("[320] 成功載入檔案: " .. File)
            return func()
        else
            warn("[320] 檔案語法錯誤 (" .. File .. "): " .. tostring(err))
        end
    else
        warn("[320] 無法連線至 GitHub 或找不到檔案: " .. File)
    end
    return nil
end

-- 按順序抓取模組
local UI = GetCloud("UI_Library.lua")
local Move = GetCloud("Movement.lua")
local Combat = GetCloud("Combat.lua")

-- 檢查是否全部成功
if UI and Move and Combat then
    -- 初始化 UI 並傳入功能模組
    UI:Init({
        MoveFunc = Move,
        Combat = Combat
    })
    print("[320] 所有模組載入完成，UI 已啟動！")
else
    warn("[320] 載入中斷，請按 F9 檢查上方警告訊息")
end
