local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService"), RS = game:GetService("RunService")}

function UI_Lib:Init(Data)
    -- 建立 V120 MENU 懸浮按鈕
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "Aethelgard_V120"
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = false
    
    -- RGB 邊框特效 (對應影片 0:02-0:07)
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Thickness = 3
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    task.spawn(function()
        while true do
            if _G.RGB_Mode then
                local hue = tick() % 5 / 5
                UIStroke.Color = Color3.fromHSV(hue, 0.8, 1)
            else
                UIStroke.Color = Color3.fromRGB(100, 100, 100)
            end
            task.wait()
        end
    end)

    -- 側邊欄與按鈕邏輯... (此處可擴充至數千行 UI 佈局代碼)
    print("AETHELGARD ETERNITY V120 已從雲端就緒")
end

return UI_Lib
