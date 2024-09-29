# config.py takes precedent over autoconfig.yaml
config.load_autoconfig(True)

c.bindings.commands = {
    'normal': {
        '<Ctrl-Shift-E>': 'set content.proxy socks5://127.0.0.1:9050 ;; message-info "Tor Proxy Enabled"',
        '<Ctrl-Shift-D>': 'set content.proxy system ;; message-info "Tor Proxy Disabled"',
        # qute-pass username and password
        # install: python3-tldextract pinentry-qt
        # run: echo "pinentry-program /usr/bin/pinentry-qt" >> ~/.gnupg/gpg-agent.conf
        'zl': "spawn --userscript qute-pass -n -d dmenu", 
        # qute-pass username only
        'zul': "spawn --userscript qute-pass -n -e -d dmenu",
        # qute-pass password only
        'zpl': "spawn --userscript qute-pass -n -w -d dmenu",
        # open stylesheet
        'ce': 'config-edit',
        'cs': "message-info 'Sourcing config' ;; config-source",
        # translate current url
        ',t': 'open https://translate.google.com/translate?hl=en&sl=auto&tl=en&u={url}',
        # spawn mpv with url
        ',M': "hint links spawn --detach mpv {hint-url} ;; message-info 'Opening url in mpv'",
        ',m': "message-info 'opening {url} in mpv' ;; spawn --detach mpv {url} ;; tab-close", 
        # spawn freetube with url
        ',F': "hint links spawn --detach freetube {hint-url} ;; message-info 'Opening url in FreeTube'",
        ',f': "message-info 'opening {url} in FreeTube' ;;  spawn --detach freetube {url} ;; tab-close", 
        # toggle javascript
        ',j': "message-info 'Toggling javascript' ;; config-cycle content.javascript.enabled 'true' 'false' ;; reload",
        # stylesheet based theme
         '<Ctrl+r>': "config-cycle content.user_stylesheets 'style.css' ''",
        # chrome based dark mode
#         '<Ctrl+Shift+r>': "config-cycle qt.args ['blink-settings=forceDarkModeEnabled=true,forceDarkModeImagePolicy=2,forceDarkModePagePolicy=1,forceDarkModeInversionAlgorithm=4'] [''] ;; restart",
        # toggle user agent
        'za': "message-info 'Toggling useragent ;; config-cycle content.headers.user_agent ['Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'] ;; reload"
    }
}

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'l': 'https://www.levidia.ch/search.php?q={}',
    'w': 'https://en.m.wikipedia.org/wiki/Special:Search?search={}',
    'm': 'https://music.youtube.com/search?q={}'
}

# make nvim in st the default editor
c.editor.command = ['alacritty', '-e', 'nvim', '{}']

#c.completion.shrink = True

config.set("content.javascript.enabled", True)
config.set("content.cookies.accept", "all")
config.set("content.headers.accept_language", "en-US,en;q=0.5")
config.set("content.plugins", True)
config.set("content.webgl", True)
#c.statusbar.show = 'in-mode' # show statusbar in insert mode
#c.scrolling.bar = 'never' # hide scrollbar
#c.tabs.show = 'multiple' # only show tabs when there are more than one

### custom home and start page
# startpage = 'about:blank'
# c.url.start_pages = [startpage]
# c.url.default_page = startpage

######## colors ########
# cyan = '#005577'
# gray = '#1c1c1c'
# 
# # tabs
# c.colors.tabs.bar.bg = cyan
# c.colors.tabs.even.bg = cyan
# c.colors.tabs.odd.bg = cyan
# c.colors.tabs.selected.even.bg = gray
# c.colors.tabs.selected.odd.bg = gray
# 
# # statusbar
# c.colors.statusbar.caret.bg = cyan
# c.colors.statusbar.caret.selection.bg = cyan
# c.colors.statusbar.normal.bg = cyan
# c.colors.statusbar.command.bg = cyan
# c.colors.statusbar.insert.bg = cyan
# c.colors.statusbar.passthrough.bg = cyan
# c.colors.messages.info.bg = cyan
# 
# # downloads bar
# c.colors.downloads.bar.bg = gray

c.colors.webpage.preferred_color_scheme = 'dark'
#######################
