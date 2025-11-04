# .terminus/wrappers.sh
echo "🎮 Terminus-like wrappers loaded!"

function test_game() {
    echo "It works!"
}

function ls() {
    command ls "$@"
    
    # Check if current directory has game content
    if [[ -d ".game" ]]; then
        echo "🎮 [Game content detected]"
    fi
}
