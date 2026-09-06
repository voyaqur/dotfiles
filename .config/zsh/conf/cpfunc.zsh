crp() {
    if [[ -z "$1" ]]; then
        echo "Usage: cp_run <file.cpp> [args...]" >&2
        return 1
    fi

    local file="$1"
    local target="${file%.cpp}"

    if [[ ! -f "$file" && ! -f "${target}.cpp" ]]; then
        echo "Error: Source file '${target}.cpp' not found." >&2
        return 1
    fi

    shift
    make -f "${HOME}/cp/Makefile" "$target" && printf '\n' && time ./"$target" "$@"
}

cp_cf_gen() {
    if [[ -z "${1}" ]]; then
        echo "Usage: $0 <CF-number> <num>"
        return 1
    fi

    num="${2:-7}"
    cp_path="${HOME}/cp"

    if [[ ! -d "${cp_path}" ]]; then
        echo "CP folder does not exist."
        return 1
    fi

    template_path="${HOME}/cp/templates/main.hpp"
    des="${HOME}/cp/sites/Codeforces/${1}/"
    mkdir -p "${des}"

    for ((i = 1; i <= num; i++)); do
        cp "${template_path}" "${des}/${1}_${i}.cpp"
        echo "Created problem ${i}"
    done
}

cgp() {
    if [[ -z "$1" ]]; then
        echo "Usage: cp_gen <name> [link]" >&2
        return 1
    fi

    local name="${1%.cpp}"
    local raw_link="$2"
    local template_path="${HOME}/cp/templates/main.hpp"
    local target_file="${name}.cpp"

    if [[ -f "$target_file" ]]; then
        echo "Error: '$target_file' already exists." >&2
        return 1
    fi

    if [[ ! -f "$template_path" ]]; then
        echo "Error: Template not found at '$template_path'." >&2
        return 1
    fi

    # Fetch clipboard link if missing
    if [[ -z "$raw_link" ]]; then
        local clip_cmd=""
        if command -v wl-paste &> /dev/null; then
            clip_cmd="wl-paste"
        elif command -v xclip &> /dev/null; then
            clip_cmd="xclip -selection clipboard -o"
        elif command -v pbpaste &> /dev/null; then
            clip_cmd="pbpaste"
        fi

        if [[ -n "$clip_cmd" ]]; then
            local clip_val
            clip_val=$($clip_cmd 2> /dev/null)
            local cp_domains="cses|vnoi|codeforces|usaco|dmoj|leetcode|atcoder|hackerrank|spoj|marisaoj"
            if [[ "$clip_val" =~ ($cp_domains) ]]; then
                raw_link="$clip_val"

            fi
        fi
    fi

    # Construct output file with header directly without temp files
    if [[ -n "$raw_link" ]]; then
        local clean_link="${raw_link#http*://}"
        printf "// problem-url: %s\n\n" "$clean_link" > "$target_file"
        cat "$template_path" >> "$target_file"
    else
        cp "$template_path" "$target_file"
    fi

    echo "Successfully created $target_file"
}

cplean() {
    local count
    count=$(find . -maxdepth 2 -type f \( -executable -o -name "*.out" -o -name "*.in" \) ! -name "*.cpp" ! -name "*.sh" | wc -l)

    if [[ "$count" -eq 0 ]]; then
        echo "Workspace is already clean."
        return 0
    fi

    find . -maxdepth 2 -type f \( -executable -o -name "*.out" -o -name "*.in" \) ! -name "*.cpp" ! -name "*.sh" -delete
    echo "Removed $count compiled binaries and test artifacts."
}

clp() {
    if [[ -z "$1" ]]; then
        echo "Usage: ${0} <file.cpp>" >&2
        return 1
    fi
    local file="${1%.cpp}.cpp"
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found." >&2
        return 1
    fi
    # Determine clipboard command array to safely handle arguments with spaces
    local clip_cmd=()
    if command -v wl-copy &> /dev/null; then
        clip_cmd=("wl-copy")
    elif command -v pbcopy &> /dev/null; then
        clip_cmd=("pbcopy")
    elif command -v xclip &> /dev/null; then
        clip_cmd=("xclip" "-selection" "clipboard")
    elif command -v xsel &> /dev/null; then
        clip_cmd=("xsel" "--clipboard" "--input")
    elif command -v clip.exe &> /dev/null; then
        clip_cmd=("clip.exe") # Support for WSL
    else
        echo "Error: No clipboard utility found (wl-copy, pbcopy, xclip, xsel, clip.exe)." >&2
        return 1
    fi
    # Strips /* comments */ and // comments safely while preserving string literals, then drops blank lines
    perl -0777 -pe 's{/\*.*?\*/|//[^\r\n]*|("([^"\\]|\\.)*")|(\x27([^\x27\\]|\\.)*\x27)}{$1 || $3 ? $& : ""}gse' "$file" | grep -v '^\s*$' | "${clip_cmd[@]}"
    echo "Copied $file to clipboard!"
}

cpregen() {
    if [[ -z "$1" ]]; then
        echo "Usage: cpregen <file_or_name>" >&2
        return 1
    fi

    local name="${1%.cpp}"
    local target_file="${name}.cpp"
    local template_path="${HOME}/cp/templates/main.cpp"

    if [[ ! -f "$target_file" ]]; then
        echo "Error: '$target_file' does not exist." >&2
        return 1
    fi

    if [[ ! -f "$template_path" ]]; then
        echo "Error: Template not found at '$template_path'." >&2
        return 1
    fi

    # Prompt user for confirmation (Zsh compatible syntax)
    local confirm
    if [[ -n "$ZSH_VERSION" ]]; then
        read -r "confirm?Are you sure you want to overwrite '$target_file'? [y/N]: "
    else
        read -rp "Are you sure you want to overwrite '$target_file'? [y/N]: " confirm
    fi

    case "$confirm" in
        [yY] | [yY][eE][sS])
            ;;
        *)
            echo "Aborted."
            return 0
            ;;
    esac

    # Extract existing problem link from the file header
    local link
    link=$(grep -m 1 -E '^[[:space:]]*//[[:space:]]*problem-url:[[:space:]]*' "$target_file" | sed -E 's/^[[:space:]]*\/\/[[:space:]]*problem-url:[[:space:]]*//')

    # If missing in file, attempt to pull from clipboard
    if [[ -z "$link" ]]; then
        local clip_cmd=""
        if command -v wl-paste &> /dev/null; then
            clip_cmd="wl-paste"
        elif command -v xclip &> /dev/null; then
            clip_cmd="xclip -selection clipboard -o"
        elif command -v pbpaste &> /dev/null; then
            clip_cmd="pbpaste"
        fi

        if [[ -n "$clip_cmd" ]]; then
            local clip_val
            clip_val=$($clip_cmd 2> /dev/null)
            local cp_domains="cses|vnoi|codeforces|usaco|dmoj|leetcode|atcoder|hackerrank|spoj|marisaoj"
            if [[ "$clip_val" =~ ($cp_domains) ]]; then
                link="${clip_val#http*://}"
            fi
        fi
    fi

    # Overwrite file with template and problem link
    if [[ -n "$link" ]]; then
        printf "// problem-url: %s\n\n" "$link" > "$target_file"
        cat "$template_path" >> "$target_file"
    else
        cp "$template_path" "$target_file"
    fi

    echo "Successfully regenerated $target_file"
}
