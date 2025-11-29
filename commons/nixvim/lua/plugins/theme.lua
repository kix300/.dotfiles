return {
  {
    "RRethy/base16-nvim",
    config = function()
      -- Stylix gère déjà le colorscheme, on ajoute juste la transparence
      
      -- Fonction pour appliquer la transparence après le chargement du thème
      local function apply_transparency()
        -- Fond principal transparent
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        
        -- Transparence pour les fenêtres flottantes et popups
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "none" })
        
        -- Transparence pour Snacks (explorer, terminal, etc.)
        vim.api.nvim_set_hl(0, "SnacksNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksWinBar", { bg = "none" })
        vim.api.nvim_set_hl(0, "SnacksBackdrop", { bg = "none" })
        
        -- Transparence pour Neo-tree si utilisé
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
        
        -- Transparence pour les splits/borders
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
        
        -- Transparence pour la statusline (footer avec l'heure LazyVim)
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
        
        -- Transparence pour la tabline (onglets en haut)
        vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" })
        
        -- Transparence pour bufferline (si utilisé pour les onglets)
        vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferLineTab", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "none" })
      end
      
      -- Appliquer immédiatement
      apply_transparency()
      
      -- Réappliquer après chaque changement de colorscheme
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_transparency,
      })
    end,
  },
}

