DelayBetweenTPs = 0.9 -- seconds, 1 equals to 1 second. Smaller number ==> Faster autofarm. If you make it too fast, it might break
Tasks = {
    ["Halley"] = {
        NPCPosition = Vector3.new(-1631.55981, 8.66267109, 3272.15649),
        ItemPosition = Vector3.new(-1365.78662, 8.66140175, 3070.06812),
        RemoteArg = "Halley",
        ItemName = "Knife"
    },
    ["Jake"] = {
        NPCPosition = Vector3.new(-1909.9364, 8.66159534, 4093.50952),
        ItemPosition = Vector3.new(-1642.58862, 7.67278051, 3917.13306),
        RemoteArg = "Jake",
        ItemName = "Watch"
    },
    ["Airi"] = {
        NPCPosition = Vector3.new(-1181.74451, 8.66140175, 2358.97607),
        ItemPosition = Vector3.new(-498.269501, 8.67270184, 2507.17285),
        RemoteArg = "Airi",
        ItemName = "Cat"
    }
}
TASK_NAME = TASK_NAME or "Jake"   -- you can change this, it must be defined above!
CurrentTask = Tasks[TASK_NAME]

RS = game:GetService("ReplicatedStorage")
LCP = (function()
    return game:GetService("Players").LocalPlayer
end)
GoTo = (function(pos)
    LCP().Character:SetPrimaryPartCFrame(CFrame.new(pos.x, pos.y, pos.z))
end)

Remotes = {
    ["GetQuest"] = RS.newQuest,
    ["CompleteQuest"] = RS.Remotes.Interact
}
GetItem = (function()
    LCP().Backpack[CurrentTask.ItemName].Parent = LCP().Character
end)

getgenv().Stop = false
a = 0
while not getgenv().Stop do
    Remotes.GetQuest:FireServer(CurrentTask.RemoteArg)
    wait(DelayBetweenTPs)

    GoTo(CurrentTask.ItemPosition)
    wait(DelayBetweenTPs)

    pcall(GetItem) -- This sometimes errors idk y

    wait(DelayBetweenTPs)

    GoTo(CurrentTask.NPCPosition)
    wait(DelayBetweenTPs)
    Remotes.CompleteQuest:FireServer()
    a = a + 1
    print("Completed " .. a)
    wait(DelayBetweenTPs)
end
