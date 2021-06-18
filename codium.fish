function codium --wraps='flatpak run com.vscodium.codium' --description 'alias the VSCodium Flatpak as codium'
    if test -f /app/bin/codium
        exec /app/bin/codium $argv
    else if test -f /usr/bin/codium
        exec /usr/bin/codium $argv
    else if test -f /usr/bin/flatpak-spawn
        exec /usr/bin/flatpak-spawn --host flatpak run com.vscodium.codium $argv
    else if test -f /usr/bin/flatpak
        exec /usr/bin/flatpak run com.vscodium.codium $argv
    else
        if set -l index (contains -i -- --wait $argv)
            set -e argv[$index]
        end
        exec vi $argv
    end
end
