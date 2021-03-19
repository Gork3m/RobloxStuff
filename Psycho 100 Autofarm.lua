--Thing = "Halley" -- you can change this to thing that you want to farm, example: Airi
--[[

  Written by Federal#9999
    discord.gg/moonsec

]]

if not Thing then Thing = "Halley" end
RS = game:GetService("ReplicatedStorage")
LCP = (function()
    return game:GetService("Players").LocalPlayer
end)
GoTo = (function(pos)
    LCP().Character:SetPrimaryPartCFrame(CFrame.new(pos.x, pos.y, pos.z))
end)
Positions = {
    ["TaskNPC"] = Vector3.new(-1631.55981, 8.66267109, 3272.15649),
    ["Item"] = Vector3.new(-1365.78662, 8.66140175, 3070.06812)
}
Remotes = {
    ["GetQuest"] = RS.newQuest,
    ["CompleteQuest"] = RS.Remotes.Interact
}
GetItem = (function()
    LCP().Backpack.Knife.Parent = LCP().Character
end)

getgenv().Stop = false
a = 0
while not getgenv().Stop do
    Remotes.GetQuest:FireServer(Thing)
    wait(1) --

    GoTo(Positions.Item)
    wait(1) -- You can decrease the delay to make it run faster
    GetItem()
    wait(0.5) --
    GoTo(Positions.TaskNPC)
    wait(1) --
    Remotes.CompleteQuest:FireServer()
    a = a + 1
    print("Completed " .. a)
    wait(1)
end
