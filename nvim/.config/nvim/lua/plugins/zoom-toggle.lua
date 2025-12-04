return {
  dir = "~/personal/nvim-plugins/zoom-toggle.nvim",
  name = "zoom-toggle",
  config = function()
    local zoom = require("zoom-toggle")
    zoom.setup()
  end,
}
