-- [[ 320 MASTER 核心啟動器 ]]
local Repo = "https://raw.githubusercontent.com/a0968368623-commits/320-320-/main/Modules/"

-- 1. 模組下載函數
local function GetModule(Name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(Repo .. Name .. ".lua"))()
    end)
    if success and result then
        print("[320] 模組載入成功: " .. Name)
        return result
    else
        warn("[320] 模組載入失敗: " .. Name .. " | 錯誤: " .. tostring(result))
        return nil
    end
end

-- 2. 載入 Combat 邏輯與 UI 庫
local CombatModule = GetModule("Combat")
local UILibrary = GetModule("UI_Library")

-- 3. 執行初始化
if UILibrary and CombatModule then
    -- 將 CombatModule 傳入 UI，這樣開關按鈕才能調用 CombatModule:ToggleHitbox()
    -- 數值輸入框才能調用 CombatModule:UpdateSize()
    UILibrary:Init({
        Combat = CombatModule
    })
    print("[320] 開關與大小調整介面已就緒")
else
    warn("[320] 啟動失敗，請檢查 GitHub 檔案名稱是否正確")
end
