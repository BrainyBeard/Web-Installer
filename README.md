# Web Installer

## Introduction

A simple PowerShell script which downloads and installs PHP for Windows - saving time for manually doing this.

This script is a work-in-progress, so will change and (hopefully) get better.

Upcoming changes:
- Apache
- MySQL (maybe)

## Usage

To use, just download the script, edit the variables at the top of the file to change what you want the script to download/install. This script requires administrator permissions.

## Contributing

BrainyBeard welcomes contributions to our open source projects.

1. **Fork** the repo on GitHub
2. **Clone** the project to your machine
3. Make changes and **commit** to your own branch
4. **Push** your work back to your repo
5. Submit a **pull request** so we can review your changes

### Copyright
This project is licensed under the MIT license (see below)

Any contributions made must be available under this license in order to be included in this repo.

## Issues

If you have any issues using this script, please submit an issue request.

### Common Issues

>**File web_installer.ps1 cannot be loaded because running scripts is disabled on this system.**

This is because the execution policy for the current scope of the PowerShell window is undefined. To fix this, open a PowerShell window and enter:

`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`

By defining the scope as `Process`, this ensures that the change is only valid whilst that PowerShell window is open and no permanent changes are made.


>**File web_installer.ps1 cannot be loaded. The file web_installer.ps1 is not digitally signed. The script will not execute on the system.**

Similar to the previous issue, this is because the execution policy has a setting which requires scripts to be signed. Since this script isn't signed, it cannot be run. The fix is the same as the last issue:

`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`

By defining the scope as `Process`, this ensures that the change is only valid whilst that PowerShell window is open and no permanent changes are made.


## License  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This script is licensed under the MIT license. See [LICENSE](LICENSE) for more information.