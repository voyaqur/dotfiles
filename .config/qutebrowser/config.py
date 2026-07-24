# ==============================================================================
#  qutebrowser Configuration - Geist Dark Modernism (Safari Edition)
# ==============================================================================

terminal = 'ghostty'
editor= 'nvim'
# 1. CORE & QTWEBENGINE SETTINGS

config.load_autoconfig(False)

if not hasattr(c, 'qt'):
    c.qt = type('obj', (object,), {})()
if not hasattr(c.qt, 'args'):
    c.qt.args = []

c.backend = 'webengine'

c.qt.args.extend([
    # Process Model
    "--process-per-site",
    # Combined V8 JS Engine Limits
    "--js-flags=--max-old-space-size=512 --predictable-gc-schedule",
    # Resource Clamps & Low Memory Mode
    "--enable-low-end-device-mode",
    "--disable-background-timer-throttling",
    "--disable-renderer-backgrounding",
    "--disable-client-side-phishing-detection",
    "--disable-component-update",
    # Graphics Acceleration
    "--enable-gpu-rasterization",
    "--enable-zero-copy",
    "--ignore-gpu-blocklist",
    # Caching & Network Overhead
    "--disk-cache-size=52428800",
    "--media-cache-size=52428800",
    "--dns-prefetch-disable",
    "--no-pings",
    "--disable-quic",
    "--disable-breakpad",
    # Feature Stripping
    "--disable-speech-api",
    "--disable-speech-synthesis-api",
    "--disable-reading-from-canvas",
    "--disable-remote-fonts",
    "--disable-shared-workers",
])

# Web Engine & Content Rules
c.content.headers.referer = 'same-domain'
c.content.webgl = True
c.content.canvas_reading = False
c.content.geolocation = False
c.content.autoplay = False
c.content.default_encoding = 'utf-8'
c.content.pdfjs = False
c.content.headers.user_agent = ( 
'Mozilla/5.0 (Wayland; Linux x86_64) AppleWebKit/537.36 '
' (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36' )
c.scrolling.smooth = True
c.auto_save.session = True
c.confirm_quit = ['downloads']

c.downloads.location.directory = '~/Downloads'
c.downloads.position = 'bottom'

c.url.start_pages = ["https://duckduckgo.com"]
c.url.default_page = "https://duckduckgo.com"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gh":      "https://github.com/search?q={}",
    "aur":     "https://aur.archlinux.org/packages?K={}",
    "yt":      "https://www.youtube.com/results?search_query={}",
    "so":      "https://stackoverflow.com/search?q={}",
    "w":       "https://en.wikipedia.org/wiki/Special:Search?search={}",
}


# ==============================================================================
#  2. UI & SAFARI-STYLE TAB LAYOUT
# ==============================================================================
c.window.hide_decoration = True

c.tabs.position = 'top'
c.tabs.show = 'multiple'
c.tabs.show_switching_delay = 888

# Compact Safari-style Tab Sizing & Separation
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 6, 'right': 6}
c.tabs.indicator.width = 0
c.tabs.width = 140
c.tabs.favicons.show = 'always'
c.tabs.favicons.scale = 1.2
c.tabs.title.format = '{current_title}'
c.tabs.title.elide = 'right'

# Status Bar Configuration
c.statusbar.show = 'in-mode'
c.statusbar.position = 'bottom'
c.statusbar.padding = {'top': 3, 'bottom': 3, 'left': 8, 'right': 8}

# Completion Menu Layout
c.completion.height = '35%'
c.completion.shrink = True
c.completion.scrollbar.width = 3
c.completion.scrollbar.padding = 1

# c.statusbar.url.format = '{protocol}://{host}{path}'
c.statusbar.widgets = [
    'keypress',    # Shows pending keypresses (e.g. 2gg)
    'url',         # Current URL & title
    'scroll_raw',      # Scroll percentage (e.g. 50%)
    'scroll',      # Scroll percentage (e.g. 50%)
    'history',     # Back/Forward status
    'clock',      # Scroll percentage (e.g. 50%)
    'tabs',    # Page loading bar
    'search_match',    # Page loading bar
    'progress',    # Page loading bar
]
# ==============================================================================
#  3. TYPOGRAPHY
# ==============================================================================
c.fonts.default_family = [ 'Iosevka Term Extended', 'JetBrains Mono', 'Inter','monospace']
c.fonts.default_size = '10pt'
c.fonts.tabs.selected = 'bold 9pt default_family'
c.fonts.tabs.unselected = '9pt default_family'
c.fonts.statusbar = '10pt default_family'
c.fonts.completion.entry = '9pt default_family'
c.fonts.completion.category = 'bold 9pt default_family'
c.fonts.hints = 'bold 8pt default_family'


# ==============================================================================
#  4. GEIST DARK PALETTE THEMING
# ==============================================================================
c.colors.webpage.preferred_color_scheme = 'dark'

# --- Safari-Style Tab Colors (Separated Dark Cards) ---
c.colors.tabs.bar.bg = '#000000'                     # Pure black background behind tabs

# Active Tab (Elevated Card)
c.colors.tabs.selected.even.bg = '#171717'           # Geist Accent 8
c.colors.tabs.selected.even.fg = '#ffffff'
c.colors.tabs.selected.odd.bg = '#171717'
c.colors.tabs.selected.odd.fg = '#ffffff'

# Inactive Tabs (Muted Flat Background)
c.colors.tabs.even.bg = '#0a0a0a'                     # Pitch black base
c.colors.tabs.even.fg = '#555555'                     # Geist Accent 5
c.colors.tabs.odd.bg = '#0a0a0a'
c.colors.tabs.odd.fg = '#555555'

# Tab Borders (Safari-like subtle divider line)
c.colors.tabs.pinned.selected.even.bg = '#171717'
c.colors.tabs.pinned.selected.odd.bg = '#171717'

# --- Geist Status Bar Colors ---
# Normal / Idle Mode
c.colors.statusbar.normal.bg = '#000000'              # Pure Geist Canvas
c.colors.statusbar.normal.fg = '#888888'              # Geist Accent 4

# Command Mode (Typing bar)
c.colors.statusbar.command.bg = '#000000'             # Geist Canvas
c.colors.statusbar.command.fg = '#ffffff'             # Crisp text
c.colors.statusbar.command.private.bg = '#000000'     # Geist Canvas
c.colors.statusbar.command.private.fg = '#ffffff'

# Insert Mode (GREEN HIGHLIGHT)
c.colors.statusbar.insert.bg = '#171717'              # Geist Accent 8
c.colors.statusbar.insert.fg = '#00e676'              # Bright Geist Green

# Passthrough Mode
c.colors.statusbar.passthrough.bg = '#171717'         # Geist Accent 8
c.colors.statusbar.passthrough.fg = '#7928ca'         # Geist Violet
# Caret Mode
c.colors.statusbar.caret.bg = '#171717'               # Geist Accent 8
c.colors.statusbar.caret.fg = '#ffb300'               # Amber/Gold text

# Caret Mode Selection (When highlighting text in caret mode)
c.colors.statusbar.caret.selection.bg = '#171717'     # Geist Accent 8
c.colors.statusbar.caret.selection.fg = '#ffb300'     # Amber/Gold text
# URL Colors in Status Bar
c.colors.statusbar.url.fg = '#555555'                 # Geist Accent 5
c.colors.statusbar.url.error.fg = '#ff1a1a'           # Geist Error Light
c.colors.statusbar.url.hover.fg = '#3291ff'           # Geist Light Blue
c.colors.statusbar.url.success.http.fg = '#888888'     # Geist Accent 4
c.colors.statusbar.url.success.https.fg = '#888888'    # Geist Accent 4
c.colors.statusbar.url.warn.fg = '#f7b955'            # Geist Warning Light

# Progress Bar
c.colors.statusbar.progress.bg = '#00e676'            # Matching Green Progress Bar

# --- Completion Menu Colors ---
c.colors.completion.category.fg = '#555555'
c.colors.completion.category.bg = '#000000'
c.colors.completion.category.border.top = '#000000'
c.colors.completion.category.border.bottom = '#000000'

c.colors.completion.fg = ['#888888', '#888888', '#888888']
c.colors.completion.odd.bg = '#0d0d0d'
c.colors.completion.even.bg = '#080808'

c.colors.completion.item.selected.fg = '#ffffff'
c.colors.completion.item.selected.bg = '#1f1f1f'
c.colors.completion.item.selected.border.top = '#1f1f1f'
c.colors.completion.item.selected.border.bottom = '#1f1f1f'

c.colors.completion.match.fg = '#3291ff'            # Geist Electric Blue
c.colors.completion.scrollbar.fg = '#333333'
c.colors.completion.scrollbar.bg = '#000000'
# --- Hints ---
c.hints.padding = {"top": 2, "bottom": 2, "left": 3, "right": 3}
c.hints.radius = 2
c.hints.border = "1px solid #333333"
c.colors.hints.bg = "#050505"
c.colors.hints.fg = "#ffffff"
c.colors.hints.match.fg = "#3291ff"


# ==============================================================================
#  5. PRIVACY & SECURITY
# ==============================================================================
c.content.cookies.accept = 'no-3rdparty'
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'
c.content.headers.do_not_track = True
c.content.hyperlink_auditing = False


# ==============================================================================
#  6. ADBLOCK LISTS
# ==============================================================================
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
    # --- 1. CORE AD & NETWORK BLOCKING ---
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://filters.adtidy.org/extension/ublock/filters/2.txt",               # AdGuard Base Filter
    "https://filters.adtidy.org/extension/ublock/filters/4.txt",               # AdGuard Mobile & In-App Ads
    "https://filters.adtidy.org/extension/ublock/filters/5.txt",               # AdGuard Experimental
    "https://filters.adtidy.org/extension/ublock/filters/10.txt",              # AdGuard Useful Search Ads
    "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt",      # AdGuard DNS Filter
    "https://abp.oisd.nl",                                                       # OISD Big (ABP Syntax)

    # --- 2. UBLOCK ORIGIN COMPLETE SUITE ---
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt",

    # --- 3. MULLVAD OFFICIAL BLOCKLIST SUITE ---
    "https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/doh/doh_adblock.txt",
    "https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/doh/doh_privacy.txt",
    "https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/doh/doh_adult.txt",
    "https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/doh/doh_gambling.txt",
    "https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/doh/doh_social.txt",

    # --- 4. HAGEZI EXPANDED MULTI-LEVEL SUITE ---
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/ultimate.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/fake.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/popupads.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/doh-vpn-proxy-bypass.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt",
    "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.xiaomi.txt",

    # --- 5. SECURITY, MALWARE, PHISHING & THREAT INTEL ---
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt",
    "https://phishing.army/download/phishing_army_blocklist_extended.txt",
    "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh.txt",
    "https://gitlab.com/malware-filter/urlhaus-filter/-/raw/master/urlhaus-filter-online.txt",
    "https://raw.githubusercontent.com/curbengh/urlhaus-filter/master/urlhaus-filter-ag-online.txt",
    "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt",
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt",
    "https://raw.githubusercontent.com/ph00lt0/blocklist/master/blocklist.txt",
    "https://raw.githubusercontent.com/shadowwhisperer/BlockLists/master/Lists/Malware",
    "https://raw.githubusercontent.com/shadowwhisperer/BlockLists/master/Lists/Ads",
    "https://raw.githubusercontent.com/stamparm/blackbook/master/blackbook.txt",
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts",
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts",

    # --- 6. BLOCKLISTPROJECT COMPLETE SECURITY ---
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/phishing.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/malware.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/ransomware.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/abuse.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/crypto.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/redirect.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/scam.txt",

    # --- 7. TELEMETRY, ANALYTICS & TRACKING ---
    "https://filters.adtidy.org/extension/chromium/filters/11.txt",
    "https://filters.adtidy.org/extension/ublock/filters/11.txt",
    "https://filters.adtidy.org/extension/chromium/filters/17.txt",
    "https://filters.adtidy.org/extension/ublock/filters/17.txt",
    "https://filters.adtidy.org/extension/ublock/filters/3.txt",
    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext",
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
    # "https://raw.githubusercontent.com/crazy-max/Windows-Spy-Blocker/master/data/hosts/win10/spy.txt",
    # "https://raw.githubusercontent.com/crazy-max/Windows-Spy-Blocker/master/data/hosts/win10/extra.txt",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/tracking.txt",
    "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt",
    "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt",
    "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt",
    "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt",

    # --- 8. COOKIE BANNERS, POPUPS & ANNOYANCES ---
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist-downloads.adblockplus.org/fanboy-social.txt",
    "https://filters.adtidy.org/extension/ublock/filters/14.txt",
    "https://filters.adtidy.org/extension/ublock/filters/18.txt",
    "https://filters.adtidy.org/extension/ublock/filters/19.txt",
    "https://filters.adtidy.org/extension/ublock/filters/20.txt",
    "https://filters.adtidy.org/extension/ublock/filters/21.txt",
    "https://filters.adtidy.org/extension/ublock/filters/22.txt",
    "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt",

    # --- 9. GAMBLING & CASINO BLOCKING ---
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/gambling.txt",
    "https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/gambling-hosts",

    # --- 10. ADULT / NSFW BLOCKLISTS ---
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts",
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/porn.txt",
    "https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/pornography-hosts",

    # --- 11. REGIONAL FILTERS ---
    "https://raw.githubusercontent.com/abpvn/abpvn/master/filter/abpvn.txt",            # Vietnam
    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts",                  # HostsVN (Vietnam)
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/GameConsoleAdblockList.txt",
]
# ==============================================================================
#  7. KEYBINDINGS & JAVASCRIPT PERMISSIONS
# ==============================================================================
c.content.javascript.clipboard = "access"

# Tab Visibility Toggles
config.bind('tt', 'config-cycle tabs.show multiple never')
config.bind('tT', 'config-cycle tabs.show always multiple')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xs', 'config-cycle -t tabs.position left right bottom top')
# Stream Offloading to MPV
config.bind('m', 'spawn mpv {url}')
config.bind('yc', 'hint code userscript qute-code-hint')
config.bind('M', 'hint links spawn --detach mpv {hint-url}')
config.bind(';m', 'hint links spawn --detach mpv {hint-url}')

# Quickmarks & Bookmarks Management
config.bind('go', 'cmd-set-text -s :quickmark-load')       # Open quickmark
config.bind('gn', 'cmd-set-text -s :quickmark-load -t')    # Quickmark in new tab
config.bind('ma', 'bookmark-add')                          # Add bookmark
config.bind(',c', 'clear-keychain ;; clear-messages')      # Purge keychain & status messages
config.bind(',k', 'spawn --userscript qute-keepassxc',mode='normal')
config.bind(',ku', 'spawn --userscript qute-keepassxc --username-only')
config.bind(',kp', 'spawn --userscript qute-keepassxc --password-only')
config.bind('gr', 'spawn --userscript readability-js')
config.bind('sd', 'spawn --userscript doi')
config.bind('gh', 'spawn {terminal} -e {editor} $QUTE_HTML')
