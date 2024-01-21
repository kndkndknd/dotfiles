-- lua/plugins/nvim-treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { 
        "lua", 
        "typescript", 
        "rust", 
        "markdown", 
        "python", 
        "scala", 
        "zig" 
      },
      sync_install = true,
      indent = {
        enable = true,
      }
    },
}
