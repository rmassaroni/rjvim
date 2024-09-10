local home = os.getenv("HOME") or os.getenv("USERPROFILE")
local dir = home .. "/.config/nvim"
local is_windows = package.config:sub(1,1) == '\\'

local function run_command(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result
end

local function is_command_available(cmd)
    local check = run_command("command -v " .. cmd)
    return check ~= ""
end

if not is_windows then
    run_command("sudo apt install python3-venv")
else
    if not is_command_available("choco") then
        print("Chocolatey is not installed. Please install Chocolatey first.")
        return
    end
    run_command("choco install python")
end

if is_command_available("nvim") then
    print("Neovim is already installed.")
else
    print("Neovim is not installed. Installing Neovim...")

    if is_windows then
        if is_command_available("choco") then
            run_command("choco install neovim")
        elseif is_command_available("scoop") then
            run_command("scoop install neovim")
        else
            print("Neither Chocolatey nor Scoop is installed. Please install one of them.")
            return
        end
    else
        if not is_command_available("brew") then
            print("Homebrew is not installed. Installing Homebrew...")
            run_command('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')

            run_command("sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/var/homebrew")
            run_command("sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/Cellar")
            run_command("sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/share/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions")

            run_command("/home/linuxbrew/.linuxbrew/bin/brew update --force --quiet")
        else
            print("Homebrew is already installed.")
        end

        run_command("brew install go")
        run_command("brew install neovim")
    end
end

if not run_command('test -d "' .. dir .. '" && echo "exists"') == "exists" then
    print("~/.config/nvim not found. Cloning repository...")
    run_command("git clone https://github.com/rmassaroni/rjvim.git " .. dir)
end

print("Done")

