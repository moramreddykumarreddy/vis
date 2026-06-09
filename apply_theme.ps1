$files = Get-ChildItem -Path "e:\vis\lib" -Recurse -Filter "*.dart"
foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw
    $newContent = $content -replace "0xFF104494", "0xFF0F7B45" `
                           -replace "0xFF0D3270", "0xFF065F46" `
                           -replace "0xFF2C3E50", "0xFF1F2937" `
                           -replace "0xFF607D8B", "0xFF6B7280" `
                           -replace "0xFF6390E6", "0xFF22C55E" `
                           -replace "Colors\.blue\.shade50", "Color(0xFFF8FAF8)" `
                           -replace "Colors\.blue\.shade100", "Color(0xFFDCFCE7)" `
                           -replace "Colors\.blue(?!\.)", "Color(0xFF22C55E)" `
                           -replace "FontWeight\.bold", "FontWeight.w600" `
                           -replace "FontWeight\.w700", "FontWeight.w600" `
                           -replace "FontWeight\.w900", "FontWeight.w600"
    if ($content -cne $newContent) {
        Set-Content -Path $f.FullName -Value $newContent -NoNewline
    }
}
