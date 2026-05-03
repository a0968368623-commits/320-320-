local Movement = {
    SavedPositions = {}, -- 格式: { ["名稱"] = Vector3 }
    FlySpeed = 100
}

-- 儲存當前座標
function Movement:SaveCurrentPos(name)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        self.SavedPositions[name] = char.HumanoidRootPart.Position
        print("[320] 已儲存座標: " .. name)
    end
end

-- 瞬移到指定名稱的座標
function Movement:TeleportTo(name)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and self.SavedPositions[name] then
        char.HumanoidRootPart.CFrame = CFrame.new(self.SavedPositions[name])
    end
end

return Movement
