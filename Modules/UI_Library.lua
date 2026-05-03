local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService"), RS = game:GetService("RunService")}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "Aethelgard_V120"
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = true -- 改成 true 才會直接顯示
    
    -- RGB 邊框
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Thickness = 3
    
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            UIStroke.Color = Color3.fromHSV(hue, 0.8, 1)
            task.wait()
        end
    end)

    -- 簡單的座標儲存按鈕範例
    local SaveBtn = Instance.new("TextButton", MainFrame)
    SaveBtn.Size = UDim2.new(0, 200, 0, 50)
    SaveBtn.Position = UDim2.new(0, 10, 0, 10)
    SaveBtn.Text = "儲存當前座標"
    SaveBtn.MouseButton1Click:Connect(function()
        if Data.MoveFunc and Data.MoveFunc.SaveLocation then
            Data.MoveFunc:SaveLocation("我的點位")
            print("座標已記錄！")
        end
    end)

    print("AETHELGARD ETERNITY V120 已顯示")
end

return UI_Lib
