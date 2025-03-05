if vim.g.neovide then
	-- General Settings
	-- vim.o.guifont = "OverpassM Nerd Font Mono:14" -- text below applies for VimScript
	-- vim.o.guifont = "Maple Mono NF 1.3:14" -- text below applies for VimScript

	-- MonaspiceRn NF

	-- vim.o.guifont = "OverpassM Nerd Font Mono:h10"
	-- vim.g.neovide_font_normal = "JetBrainsMono Nerd Font"
	-- vim.g.neovide_font_italic = "VictorMono Nerd Font"
	-- vim.g.neovide_transparency = true
	-- vim.g.transparency = false

	-- vim.g.neovide_no_idle = true

	-- vim.g.neovide_position_animation_length = 0.06
	-- vim.g.neovide_cursor_animation_length = 0.04
  vim.g.neovide_refresh_rate = 240

	-- Scale Factor for Neovide
	vim.g.neovide_scale_factor = 1
	vim.g.neovide_confirm_quit = false

	vim.g.neovide_detach_on_quit = "always_detach"
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_hide_mouse_when_typing = true
	--
	vim.opt.linespace = 15
	vim.g.neovide_remember_window_size = true

	vim.g.neovide_profiler = false
	vim.g.neovide_cursor_vfx_mode = "railgun"

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
end
