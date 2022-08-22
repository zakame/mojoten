#!/bin/bash
set +e  # Continue on errors

echo "Installing cpanfile dependencies"
apt-get update
apt-get install -y --no-install-recommends gcc libssl-dev
cpm install -g Carton
cpm install

COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"

echo -e "${COLOR_CYAN}
   ____              ____
  |  _ \  _____   __/ ___| _ __   __ _  ___ ___
  | | | |/ _ \ \ / /\___ \| '_ \ / _\` |/ __/ _ \\
  | |_| |  __/\ V /  ___) | |_) | (_| | (_|  __/
  |____/ \___| \_/  |____/| .__/ \__,_|\___\___|
                          |_|
${COLOR_RESET}
Welcome to your development container!

This is how you can work with it:
- Run \`${COLOR_CYAN}perl -Ilocal/lib/perl5 script/mojoten daemon${COLOR_RESET}\` to start the application
- Run \`${COLOR_CYAN}perl -Ilocal/lib/perl5 local/bin/morbo script/mojoten${COLOR_RESET}\` to start hot reloading
- ${COLOR_CYAN}Files will be synchronized${COLOR_RESET} between your local machine and this container
- Some ports will be forwarded, so you can access this container on your local machine via ${COLOR_CYAN}http://localhost:3000${COLOR_RESET}
"

bash
