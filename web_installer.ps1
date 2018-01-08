#Requires -RunAsAdministrator

#######
# PHP #
#######
$php_download_url = "http://windows.php.net/downloads/releases/php-7.2.1-nts-Win32-VC15-x64.zip"
$php_download_hash = "b00e802bc023e617f6fcc05a6aad7ea80fadbc94a59bd794f69f4609c1e83cab"

$php_version = "7.2.1"
$php_install_path = "C:\Web\PHP"

$php_extensions = "curl", "gd2", "mbstring", "mysqli", "pdo_mysql", "xmlrpc";

#########################
# Don't edit past here! #
#########################
function replaceOrAdd($path, $old, $new) {
    $content = Get-Content $path

    if ($content -match $old) {
        $content -replace $old, $new | Set-Content $path
    }
    else {
        Add-Content $path $new
    }
}

function install_php() {
    echo "Downloading PHP $php_version`n"

    #Download PHP
    $php_download_path = "$env:temp\php-$php_version.zip"

    Invoke-WebRequest -Uri $php_download_url -OutFile $php_download_path

    echo "`nChecking file hash"
    
    $hash = (Get-FileHash -Path $php_download_path -Algorithm SHA256)[0].Hash

    echo "Downloaded: $hash"
    echo "Provided: $php_download_hash"

    if ($hash -ine $php_download_hash) {
        echo "Error: File hash doesn't match"
        exit 1
    }

    #Create version folder
    $php_folder = "$php_install_path\$php_version"
    $php_latest = "$php_install_path\latest"
    $php_ini = "$php_folder\php.ini";

    echo "`nInstalling PHP $php_version to $php_folder"

    if (!(Test-Path $php_folder)) {
        New-Item $php_folder -ItemType Directory | Out-Null
    }

    #Add symlink
    New-Item -Path $php_latest -ItemType SymbolicLink -Value $php_folder -Force | Out-Null
    
    #Extract PHP
    Expand-Archive -Path $php_download_path -DestinationPath $php_folder -Force

    #Set ini/values
    Copy-Item -Path "$php_folder\php.ini-development" $php_ini

    Add-Content $php_ini "extension_dir = `"$php_latest\ext`""

    foreach ($php_extension in $php_extensions) {
        replaceOrAdd "$php_ini" "^;extension=$php_extension$" "extension=$php_extension"
    }

    echo "Adding $php_latest to PATH"

    #Set environment variables
    $current_path = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $current_path = "$php_latest;$current_path"
    
    [Environment]::SetEnvironmentVariable("Path", $current_path, "Machine")

    echo "`nRemoving $php_download_path"
    Remove-Item $php_download_path | Out-Null
    
    echo "`nPHP $php_version installed"
}

install_php