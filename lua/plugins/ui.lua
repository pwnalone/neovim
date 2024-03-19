return {
  -- Always show the bufferline and center Neo-tree's title text.
  {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    opts = function(_, opts)
      opts.options.always_show_bufferline = true
      opts.options.offsets[1].text = "Neotree"
      opts.options.offsets[1].text_align = "center"
      return opts
    end,
  },
}
