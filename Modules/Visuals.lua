local Visuals = {Enabled = false}

function Visuals:ToggleESP(state)
    self.Enabled = state
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            -- 建立 Highlight 或 BillboardGui
            local Highlight = v.Character:FindFirstChild("V120_ESP") or Instance.new("Highlight", v.Character)
            Highlight.Name = "V120_ESP"
            Highlight.Enabled = state
            Highlight.FillColor = Color3.new(1, 0, 0)
        end
    end
end

return Visuals
