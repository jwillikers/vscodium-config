# Will still need to pass "--wait" to make it behave nicely.
# In order to get --wait to work in a Flatpak, run
# `flatpak override --user --env=TMPDIR=/var/tmp com.vscodium.codium`.
# Defined via `source`
function codium --wraps='flatpak run com.vscodium.codium' --description 'alias codium=flatpak run com.vscodium.codium'
    if test -f /app/bin/codium
        /app/bin/codium $argv &>/dev/null &; disown
    else if test -f /usr/bin/codium
        /usr/bin/codium $argv &>/dev/null &; disown
    else if test -f /usr/bin/flatpak-spawn
        /usr/bin/flatpak-spawn --host flatpak run com.vscodium.codium $argv &>/dev/null &; disown
    else if test -f /usr/bin/flatpak
        /usr/bin/flatpak run com.vscodium.codium $argv &>/dev/null &; disown
    else
        if set -l index (contains -i -- --wait $argv)
            set -e argv[$index]
        end
        exec vi $argv
    end
end
