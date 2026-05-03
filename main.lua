-- [[ 320 Master 專業版雲端加載器 - 極簡靜音版 ]]
-- 對接倉庫：a0968368623-commits / 320-320-

local Config = {
    User = "a0968368623-commits",
    Repo = "320-320-",
    Branch = "main"
}

local BaseURL = string.format("https://raw.githubusercontent.com/%s/%s/%s/", Config.User, Config.Repo, Config.Branch)

local function CloudLoad(FileName)
    -- 靜默下載，除非錯誤否則不輸出白字
    local success, content = pcall(game.HttpGet, game, BaseURL .. FileName .. "?t=" .. os.time())
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            return func() 
        else
            warn("[320 Error] " .. FileName .. " 語法錯誤") -- 僅保留紅字警告
        end
    else
        warn("[320 Error] 無法讀取 " .. FileName)
    end
    return nil
end

-- 啟動程序
task.spawn(function()
    -- 僅在啟動時顯示一行，代表腳本有在跑
    print("✨ [V1] 320 Master 加載中...")

    local UI_Mod = CloudLoad("Modules/UI_Library.lua")
    local Combat_Mod = CloudLoad("Modules/Combat.lua")
    local Move_Mod = CloudLoad("Modules/Movement.lua")

    if UI_Mod then
        UI_Mod:Init({
            Combat = Combat_Mod,
            Movement = Move_Mod,
            Version = "1.0.5"
        })
        -- 加載完成後顯示一條確認訊息
        print("✅ [V1] 腳本啟動成功，版本: 1.0.5")
    else
        warn("❌ [V1] 核心組件損壞，啟動失敗。")
    end
end)
