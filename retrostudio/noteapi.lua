local note = {}
note.__index = note

function getEvents(name:string):table
    local event_tbl = {}
    for _, even in game:GetDescendants() do
        if even.Name == name and even:IsA("RemoteEvent") then
            table.insert(event_tbl, even)
        end
    end
    return event_tbl
end

function note.change(text:string, color:Color3)
    for _, v in pairs(getEvents("Change")) do
        v:FireServer(unpack({
            [1] = {
                [1] = text,
                [2] = color
            }
        }))
    end
end
function note.place(vec1:Vector3, vec2:Vector3)
    for _, v in pairs(getEvents("Place")) do
        v:FireServer(unpack({
            [1] = {
                [1] = vec1,
                [2] = vec2
            }
        }))
    end
end

return note