return {
    highlights = {
        enabled = true,
        cmdline = true,
        groups = { "BlinkPairs" },
        unmatched_group = "BlinkPairsUnmatched",
        matchparen = {
            enabled = true,
            -- known issue where typing won't update matchparen highlight, disabled by default
            cmdline = true,
            -- also include pairs not on top of the cursor, but surrounding the cursor
            include_surrounding = false,
            group = "BlinkPairsMatchParen",
            priority = 250,
        },
    },
}
