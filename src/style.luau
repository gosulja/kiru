local Color4 = require(script.Parent.color4)

return {
    Colors = {
        Text = Color4.fromHex("#FFFFFF"),

        Button = Color4.new(0.2, 0.6, 1, 0.5),
        ButtonHovered = Color4.new(0.2, 0.6, 1, 0.8),
        ButtonActive = Color4.new(0.2, 0.6, 1, 1),
    },

    FontFaces = {
        Rubik = Font.fromId(12187365977, Enum.FontWeight.Regular),
    }
}