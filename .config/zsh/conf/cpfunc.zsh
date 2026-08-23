cp_run() {
    local target="${1%.cpp}"
    if [[ -z "$target" ]]; then
        echo "No .cpp file found!"
        return 1
    fi
    shift
    make -f "${HOME}/cp/Makefile" "${target}" && time ./"${target}" "$@" || return 1
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

    template_path="${HOME}/cp/templates/main.cpp"
    des="${HOME}/cp/sites/Codeforces/${1}/"
    mkdir -p "${des}"

    for ((i = 1; i <= num; i++)); do
        cp "${template_path}" "${des}/${1}_${i}.cpp"
        echo "Created problem ${i}"
    done
}

cp_gen() {
    if [[ -z "${1}" ]]; then
        echo "Usage: cp_gen <name> [link]"
        return 1
    fi

    local name="$1"
    local raw_link="$2"
    local target_file="${name}.cpp"

    # Regex domain filter for target CP platforms
    local cp_domains="cses|vnoi|codeforces|usaco|dmoj|leetcode|atcoder|hackerrank|spoj|marisaoj|"

    # Fetch from clipboard if no explicit link argument is provided
    if [[ -z "$raw_link" ]]; then
        if command -v wl-paste &> /dev/null; then
            raw_link=$(wl-paste 2> /dev/null)
        elif command -v xclip &> /dev/null; then
            raw_link=$(xclip -selection clipboard -o 2> /dev/null)
        elif command -v xsel &> /dev/null; then
            raw_link=$(xsel --clipboard --output 2> /dev/null)
        fi

        # Only accept clipboard input if it matches allowed CP domains
        if [[ ! "$raw_link" =~ ($cp_domains) ]]; then
            raw_link=""
        fi
    fi

    # Copy template
    cp "${HOME}/cp/templates/main.cpp" ./"$target_file"

    # Prepend header if a valid link was provided or matched from clipboard
    if [[ -n "$raw_link" ]]; then
        local clean_link="${raw_link#http*://}"
        {
            echo "// Problem: ${clean_link}"
            cat "$target_file"
        } > "${target_file}.tmp" && mv "${target_file}.tmp" "$target_file"
    fi

    echo "Created file ${1}.cpp"
}
