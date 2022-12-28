local is_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if is_wsl then
  require("user.clipboard.wsl")
end
