require("starship"):setup({
    config_file = "~/dotfiles/.config/starship.toml",
})
require("git"):setup({
    -- Order of status signs showing in the linemode
    order = 1500,
})
