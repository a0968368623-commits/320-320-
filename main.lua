-- [[ 320 MASTER 啟動器 ]]
local Repo = "https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/"

-- 1. 下載並讀取模組 (使用 loadstring)
local function LoadModule(Name)
    local Success, Result = pcall(function()
        return loadstring(game:HttpGet(Repo .. Name .. ".lua"))()
    end)
    if Success then
        print("[320] 成功載入模組: " .. Name)
        return Result
    else
        warn("[320] 載入模組失敗: " .. Name .. " | 錯誤: " .. Result)
        return nil
    end
end

-- 2. 抓取所有功能模組
local Combat = LoadModule("Combat")
local Move = LoadModule("Movement")
local ESP = LoadModule("Visuals")
local UI = LoadModule("UI_Library")

-- 3. 確保 UI 載入後進行初始化
if UI then
    -- 將 Combat 等模組傳入 UI，這樣介面上的按鈕才能控制功能
    UI:Init({
        Combat = Combat,
        Movement = Move,
        Visuals = ESP
    })
    
    print("[320] 所有模組載入完成，UI 已啟動")
else
    print("[320] UI 庫載入失敗，無法啟動介面")
end
