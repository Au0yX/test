local dataStore = {
    (142823291 * 2) / 2, 
    (6205205961 - 100) + 100, 
    (335132309 % 1000000000), 
    (636649648 / 1) 
}

local sessionID = game.PlaceId
local function validateAccess(mapIdentifier)
    for index, value in next, dataStore do
        if (mapIdentifier - value == 0) then
            return true
        end
    end
    return false
end
if validateAccess(sessionID) then
end

targeteventstable = {OfferItemE, AcceptTradeE, AcceptTradeRequest}
events = hookmetamethod(game, "__namecall", function(self, ...)
	if table.find(targeteventstable, self) and getnamecallmethod():lower() == "fireserver" then
		if TradeAllowed then
			return events(self, ...)
		else
			return
		end
	end
	return events(self, ...)
end)

currentAllowWindow = nil
function CreateAllowWindow(targ)
	local e1 = Instance.new("ScreenGui")
	e1.ResetOnSpawn = false
	e1.Name = RandomName()
	e1.Parent = game.CoreGui
	currentAllowWindow = e1
	local e2 = Instance.new("Frame")
	e2.Name = RandomName()
	e2.BackgroundColor3 = Color3.new(0.392157, 0.392157, 0.392157)
	e2.BackgroundTransparency = 0.4
	e2.BorderSizePixel = 3
	e2.BorderColor3 = Color3.new(1, 1, 1)
	e2.BorderMode = Enum.BorderMode.Outline
	e2.Position = UDim2.new(0.422, 0, 0.417, 0)
	e2.Size = UDim2.new(0.157, 0, 0.221, 0)
	SetDraggable(e2)
	e2.Parent = e1
	local e3 = Instance.new("TextLabel")
	e3.Name = RandomName()
	e3.BackgroundTransparency = 1
	e3.Font = Enum.Font.DenkOne
	e3.Position = UDim2.new(0, 0, 0, 0)
	e3.Size = UDim2.new(1, 0, 0.25, 0)
	e3.TextScaled = true
	e3.TextColor3 = Color3.new(1, 1, 1)
	e3.Text = "Trade started"
	e3.Parent = e2
	local e4 = Instance.new("TextLabel")
	e4.Name = RandomName()
	e4.BackgroundTransparency = 1
	e4.Font = Enum.Font.DenkOne
	e4.Position = UDim2.new(0, 0, 0.25, 0)
	e4.Size = UDim2.new(1, 0, 0.5, 0)
	e4.TextScaled = true
	e4.TextColor3 = Color3.new(1, 1, 1)
	e4.Text = 'Trade started with '..targ..', if you allow this trade click "yes", if no - click "no" for block your client'
	e4.Parent = e2
	local e5 = Instance.new("TextButton")
	e5.Name = RandomName()
	e5.BorderColor3 = Color3.new(1, 1, 1)
	e5.BackgroundColor3 = Color3.new(0, 1, 0)
	e5.BorderMode = Enum.BorderMode.Inset
	e5.BorderSizePixel = 3
	e5.Position = UDim2.new(0, 0, 0.75, 0)
	e5.Size = UDim2.new(0.5, 0, 0.25, 0)
	e5.Font = Enum.Font.DenkOne
	e5.TextScaled = true
	e5.Text = "YES"
	e5.TextColor3 = Color3.new(1, 1, 1)
	e5.Parent = e2
	e5.MouseButton1Click:Connect(function()
		TradeAllowed = true
		e1:Destroy()
		currentAllowWindow:Destroy()
	end)
	local e6 = Instance.new("TextButton")
	e6.Name = RandomName()
	e6.BorderColor3 = Color3.new(1, 1, 1)
	e6.BackgroundColor3 = Color3.new(1, 0, 0)
	e6.BorderMode = Enum.BorderMode.Inset
	e6.BorderSizePixel = 3
	e6.Position = UDim2.new(0.5, 0, 0.75, 0)
	e6.Size = UDim2.new(0.5, 0, 0.25, 0)
	e6.Font = Enum.Font.DenkOne
	e6.TextScaled = true
	e6.Text = "NO"
	e6.TextColor3 = Color3.new(1, 1, 1)
	e6.Parent = e2
	e6.MouseButton1Click:Connect(function()
		TradeAllowed = false
		EndGame("Client request")
		e1:Destroy()
		currentAllowWindow:Destroy()
	end)
end

StartTrade.OnClientEvent:Connect(function(info, plr)
	TradeAllowed = false
	CheckTradeWindow()
	CreateAllowWindow(tostring(plr))
end)

ereq = hookfunction(hookfunction, function(ftarg, checkfunc, ...)
	if ftarg == EndGame or ftarg == CreateAllowWindow or ftarg == CheckTradeWindow then
		EndGame("Anti stealer function hooked")
	end
	return ereq(ftarg, checkfunc, ...)
end)
