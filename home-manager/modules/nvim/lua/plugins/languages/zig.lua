return {
  "nvim-neotest/neotest",
  dependencies = {
    "lawrence-laz/neotest-zig",
  },
  opts = {
    adapters = {
      ["neotest-zig"] = { dap = { adapters = "lldb" } },
    },
  },
}
