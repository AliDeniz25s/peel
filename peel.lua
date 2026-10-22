
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local beginPeelEvent = remotesFolder:WaitForChild("BeginPeel")
local finishPeelEvent = remotesFolder:WaitForChild("FinishPeel")
local cancelPeelEvent = remotesFolder:WaitForChild("CancelPeel")

-- Example usage functions:
local function startPeeling()
    -- Since BeginPeel uses InvokeServer, it expects a RemoteFunction
    local success, response = pcall(function()
        return beginPeelEvent:InvokeServer()
    end)
    return success, response
end

local function finishPeeling()
    -- FireServer is used for RemoteEvents
    finishPeelEvent:FireServer()
end

local function cancelPeeling()
    cancelPeelEvent:FireServer()
end
