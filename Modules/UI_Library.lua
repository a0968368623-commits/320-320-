-- [[ V1 320 UI 核心模塊 ]]
local UI_Mod = {}
local S = setmetatable({}, {__index = function(t, k) return game:GetService(k) end})
local CG, UIS = S.CoreGui, S.UserInputService

function UI_Mod:Build(PrimaryColor)
    -- 這裡存放 Lib:Create, ApplyDrag, 以及建立 320 小按鈕與主介面的代碼
    print("320 UI 系統已從雲端啟動")
    -- (貼入 UI 相關代碼...)
end
return UI_Mod
