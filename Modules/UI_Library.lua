local UI_Lib = {}

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "320_Hitbox_UI"

    -- 主框架
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 150)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Active = true
    MainFrame.Draggable = true 
    Instance.new("UICorner", MainFrame)

    -- 標題
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "範圍調整介面"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold

    -- 範圍輸入框
    local SizeInput = Instance.new("TextBox", MainFrame)
    SizeInput.Size = UDim2.new(0, 260, 0, 45)
    SizeInput.Position = UDim2.new(0.5, -130, 0, 60)
    SizeInput.PlaceholderText = "輸入大小 (例如: 20)"
    SizeInput.Text = ""
    SizeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SizeInput.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", SizeInput)

    -- 當輸入完成時 (按下 Enter 或點擊外面)
    SizeInput.FocusLost:Connect(function(enterPressed)
        local val = tonumber(SizeInput.Text)
        if val and Data.Combat then
            Data.Combat:UpdateSize(val)
            print("[320] 範圍已更新為: " .. val)
        end
    end)
end

return UI_Lib
