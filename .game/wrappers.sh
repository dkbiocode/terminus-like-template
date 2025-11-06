# .game/wrappers.sh

# Path to shared blank image
BLANK_IMAGE="/workspaces/terminus-like-template/.game/blank_image.jpg"

# check for a ls alias "ls --color=auto" is common
# and remove it
if alias ls >/dev/null 2>&1
then
    unalias ls
fi

function ls() {
    
    local target_dir="${1:-.}"
    
    # Check if path is valid
    if [[ ! -d "$target_dir" ]]; then
        echo "That is not a valid object to look at."
        
        return 1
    fi

    if [[ -e ".game/scene.jpg" ]]; then
        code --reuse-window .game/scene.jpg
    fi

    
    # List directories as Locations (excluding .game)
    echo "Locations:"
    local has_locations=false
    for dir in "$target_dir"/*/ ; do
        if [[ -d "$dir" ]] && [[ "$(basename "$dir")" != ".game" ]]; then
            echo "  $(basename "$dir")"
            has_locations=true
        fi
    done
    [[ "$has_locations" == false ]] && echo "  None"
    
    # List files as Items
    echo ""
    echo "Items:"
    local has_items=false
    for file in "$target_dir"/* ; do
        if [[ -f "$file" ]]; then
            echo "  $(basename "$file")"
            has_items=true
        fi
    done
    [[ "$has_items" == false ]] && echo "  None"
    
}

function cd() {
    builtin cd "$@"
    
    # Wipe the image by showing blank
    if [[ -f "$BLANK_IMAGE" ]]; then
        code --reuse-window "$BLANK_IMAGE"
    fi
    
    # Show intro text if it exists
    if [[ -f ".game/intro.txt" ]]; then
        echo ""
        /usr/bin/cat .game/intro.txt
        echo ""
    fi
}

function less() {
    # Use absolute path to cat to display the text content
    /usr/bin/cat "$@"
    
    # If single argument and it's a file, look for associated image
    if [[ $# -eq 1 ]] && [[ -f "$1" ]]; then
        local item_name="$(basename "$1")"
        
        # Look for image in .game directory
        for ext in jpg png gif pdf; do
            if [[ -f ".game/${item_name}.${ext}" ]]; then
                code --reuse-window ".game/${item_name}.${ext}"
                break
            fi
        done
    fi
}

# Hide cat command to match Terminus behavior
function cat() {
    echo "Command not found: cat"
    echo "Try 'less' to examine items."
    return 127
}

function test_game() {
    echo "It works!"
}

PS1="> "

if [ -e ".game/intro.txt" ]; then
    /usr/bin/cat ".game/intro.txt"
fi