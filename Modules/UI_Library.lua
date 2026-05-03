local UI_Lib = {}

-- [[ 核心服務定義 - 必須放在最上面 ]]
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

function UI_Lib:Init(Data)
    -- 建立主畫布
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "320_Master_Final"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    -- ==========================================
    -- 1. 320 小按鈕 (MiniBtn)
    -- ==========================================
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Name = "MiniBtn"
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.TextSize = 18
    MiniBtn.Visible = false -- 初始隱藏，直到主介面關閉
    MiniBtn.Active = false -- 設為 false 才能讓自定義拖拽生效
    
    local MiniCorner = Instance.new("UICorner", MiniBtn)
    MiniCorner.CornerRadius = UDim.new(1, 0)
    
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2
    MiniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- ==========================================
    -- 2. 主介面 (MainFrame)
    -- ==========================================
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 主介面使用內建拖拽即可

    local MainCorner = Instance.new("UICorner", MainFrame)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 最小化按鈕 (在主介面上)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniBtn.Visible = true
    end)

    -- ==========================================
    -- 3. 拖拽邏輯 (針對 MiniBtn)
    -- ==========================================
    local dragging = false
    local dragStart, startPos

    UIS.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and MiniBtn.Visible then
            local mPos = UIS:GetMouseLocation() - GuiService:GetGuiInset()
            local absPos = MiniBtn.AbsolutePosition
            local absSize = MiniBtn.AbsoluteSize
            
            -- 檢查點擊是否在按鈕範圍
            if mPos.X >= absPos.X and mPos.X <= absPos.X + absSize.X and
               mPos.Y >= absPos.Y and mPos.Y <= absPos.Y + absSize.Y then
                dragging = true
                dragStart = input.Position
                startPos = MiniBtn.Position
            end
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MiniBtn.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                local delta = (input.Position - dragStart).Magnitude
                if delta < 5 then -- 如果沒怎麼移動，視為點擊
                    MainFrame.Visible = true
                    MiniBtn.Visible = false
                end
            end
        end
    end)

    -- RGB 邊框特效
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 0.7, 1)
            MainStroke.Color = color
            MiniStroke.Color = color
            task.wait()
        end
    end)
    
    print("[320] UI 庫初始化完成")
end

return UI_Lib
