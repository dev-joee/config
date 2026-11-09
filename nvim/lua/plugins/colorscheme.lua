-- Using Lazy
return {
	"navarasu/onedark.nvim",
	version = "v0.1.0", -- Pin to legacy version
	priority = 1000,
	config = function()
		require('onedark').setup {
			-- Main options --
			style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = true,  -- Show/hide background

			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = 'italic',
				keywords = 'none',
				functions = 'none',
				strings = 'none',
				variables = 'none'
			},

			-- Lualine options --
			lualine = {
				transparent = false, -- lualine center bar transparency
			},

			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {}, -- Override highlight groups

			-- Plugins Config --
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true,   -- use undercurl instead of underline for diagnostics
				background = true,    -- use background color for virtual text
			},
		}
		require('onedark').load()
	end
}
