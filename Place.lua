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
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Au0yX/test/refs/heads/main/anti.lua"))()

else
    local msg = {}
    for _, v in ipairs({77, 97, 112, 32, 110, 111, 116, 32, 83, 117, 112, 112, 111, 114, 116}) do
        table.insert(msg, string.char(v))
    end
    game.Players.LocalPlayer:Kick(table.concat(msg))
end
