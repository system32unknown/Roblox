local ExploitTool = {}

function ExploitTool:MakeSysMsg(text, color, font, size)
    local text = text or "Hello World"
    local color = color or Color3.fromRGB(255, 255, 255)
    local font = font or Enum.Font.SourceSansBold
    local size = size or 18

    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = text;
        Color = color;
        Font = font;
        TextSize = size;
    })
end

function ExploitTool.EncodeReversedBase64(data)
    return Krnl.Base64.Encode(string.reverse(data))
end

function ExploitTool.DecodeReversedBase64(data)
    return Krnl.Base64.Decode(string.reverse(data))
end

return ExploitTool