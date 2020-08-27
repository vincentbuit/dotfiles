#!/bin/bash

# Microsoft visual code (mvc) with extensions
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
dnf install code
code --install-extension pkief.material-icon-theme # Icons for all file types
code --install-extension CoenraadS.bracket-pair-colorizer # Rainbow brackets to easily see level
code --install-extension akamud.vscode-theme-onedark # Theme to make code easy readable
code --install-extension christian-kohler.path-intellisense # Auto complete filenames
code --install-extension wayou.vscode-todo-highlight # Highlight TODO and FIXME inside code

code --install-extension ms-python.python # python linting, debugging, formatting, snippets
code --install-extension Zignd.html-css-class-completion # IntelliSense for CSS class names
code --install-extension ms-dotnettools.csharp # C# 
code --install-extension foxundermoon.shell-format # shellscript, Dockerfile, properties, gitignore, dotenv, hosts, jvmoptions... DocumentFormat
code --install-extension dsznajder.es7-react-js-snippets # ES7 React/Redux/GraphQL/React-Native snippets
#code --install-extension johnpapa.angular2 # Angular snippets

code --install-extension msjsdiag.debugger-for-chrome # Chrome debugger
code --install-extension firefox-devtools.vscode-firefox-debug # Firefox debugger
code --install-extension msjsdiag.debugger-for-edge # Edge debugger

# Node version manager (nvm) with latest nodeJs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install 14.8.0

# .NET Core 3.1 SDK which includes ASP.NET Core runtime (includes both .NET Core- and ASP.NET Core runtime)
sudo dnf install dotnet-sdk-3.1

# Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io # ERROR

# Mssql-server
sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2019.repo
sudo dnf makecache
sudo dnf install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup # Option 2 & Admin pass from eforah repo (see make file)
sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
sudo yum -y install mssql-tools unixODBC-devel

# Pandoc & LaTeX
sudo dnf install pandoc
sudo dnf install texlive-scheme-basic # basic, medium or full

# REST

# Extra browsers