$files = Get-ChildItem -Path "e:\vis\lib" -Recurse -Filter "*.dart"
foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw
    $newContent = $content -replace "Colors\.red", "Color(0xFFEF4444)" `
                           -replace "Colors\.green(?!\.)", "Color(0xFF22C55E)" `
                           -replace "Colors\.orange", "Color(0xFFF59E0B)"
    if ($content -cne $newContent) {
        Set-Content -Path $f.FullName -Value $newContent -NoNewline
    }
}
