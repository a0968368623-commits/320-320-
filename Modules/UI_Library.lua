local UI_Lib = {}

function UI_Lib:Init(Data)
    print("[UI] 正在初始化 320 懸浮按鈕系統...")
    
    -- 1. 這裡會寫入你原本那一萬字的 UI 庫原始碼
    -- 2. 建立 320 懸浮按鈕邏輯
    -- 3. 綁定按鈕點擊打開主面板
    
    -- 測試代碼 (確保運作)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainBtn = Instance.new("TextButton", ScreenGui)
    MainBtn.Size = UDim2.new(0, 50, 0, 50)
    MainBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    MainBtn.Text = "320"
    MainBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    print("[UI] V1 介面已就緒，版本：" .. Data.Ver)
end

return UI_Lib
