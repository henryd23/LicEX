$ErrorActionPreference = 'Stop'

Write-Host 'Installing LICEX prerequisites with winget...'

winget install --id Microsoft.VisualStudio.2022.BuildTools --exact --accept-source-agreements --accept-package-agreements --override '--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended'
winget install --id Rustlang.Rustup --exact --accept-source-agreements --accept-package-agreements
winget install --id OpenJS.NodeJS.LTS --exact --accept-source-agreements --accept-package-agreements
winget install --id Git.Git --exact --accept-source-agreements --accept-package-agreements
winget install --id Kitware.CMake --exact --accept-source-agreements --accept-package-agreements
winget install --id Ninja-build.Ninja --exact --accept-source-agreements --accept-package-agreements
winget install --id LLVM.LLVM --exact --accept-source-agreements --accept-package-agreements
winget install --id ShiningLight.OpenSSL.Dev --exact --accept-source-agreements --accept-package-agreements

Write-Host 'Refreshing the current process PATH is not reliable after winget installs.'
Write-Host 'Close and reopen PowerShell, then run:'
Write-Host '  rustup default stable-msvc'
Write-Host '  npm install -g pnpm@10.17.1 --allow-scripts=pnpm'
Write-Host '  pnpm install --frozen-lockfile'
Write-Host '  pnpm run tauri:dev'
