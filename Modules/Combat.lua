local Combat = {Settings = {Size = 10, Enabled = false}}

function Combat:ToggleHitbox(state, size)
    self.Settings.Enabled = state
    self.Settings.Size = size or 10
    
    task.spawn(function()
        while self.Settings.Enabled do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(self.Settings.Size, self.Settings.Size, self.Settings.Size)
                    hrp.Transparency = 0.8
                    hrp.CanCollide = false
                end
            end
            task.wait(0.5)
        end
    end)
end

return Combat
