export ALTERNATE_EDITOR='emacs -nw -q'
export BAT_THEME=GitHub
export BROWSER='google-chrome'
export DAN_VIRTUALENVS_DIRECTORY=~/tmp/virtualenvs
export EDITOR='emacsclient -n'
export GIT_SEQUENCE_EDITOR='emacsclient'
export OPEN_IN_EDITOR=~/bin/code
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS='-FIRXS'
export DELTA_PAGER='less -FRSX'
export PIP_INDEX_URL=
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export XENOCANTO_DATA_DIRECTORY=/tmp/xeno-quero-data
export EXA_COLORS=$(tr '\n' ':' < exa-colors)
export DAN_ETERNAL_HISTORY_DIR=~/GoogleDrive/shell_history
export DAN_ETERNAL_HISTORY_FILE=$DAN_ETERNAL_HISTORY_DIR/eternal_shell_history_03.99
is_zsh && {
    export PROMPT_EOL_MARK=
    export HISTFILE=$DAN_ETERNAL_HISTORY_FILE
}

export FZF_DEFAULT_COMMAND='fd'
fzf-set-environment-variables

# To add local TeX .sty files:
#   Add to /opt/homebrew/texlive/texmf-local/tex/latex/local
#   Run `texhash`

__dan_is_macos && export MANPATH="$MANPATH:/opt/homebrew/opt/coreutils/libexec/gnuman"  # $(brew --prefix coreutils) is too slow
# export MPLBACKEND="module://itermplot" ITERMPLOT=rv

# export   CFLAGS=-I/opt/homebrew/opt/libxml2/include/libxml2
# export CPPFLAGS=-I/opt/homebrew/opt/libxml2/include/libxml2
# export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"

source env-local.sh

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";


export LS_COLORS='no=00:fi=00:di=36:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=1;38;5;197:*.cmd=1;38;5;197:*.exe=1;38;5;197:*.com=1;38;5;197:*.bat=1;38;5;197:*.reg=1;38;5;197:*.app=1;38;5;197:*AUTHORS=38;5;248:*CHANGES=38;5;248:*CONTRIBUTORS=38;5;248:*COPYING=38;5;248:*COPYRIGHT=38;5;248:*HISTORY=38;5;248:*INSTALL=38;5;248:*LICENSE=38;5;248:*LICENSE-MIT=38;5;248:*LICENSE-APACHE=38;5;248:*NOTICE=38;5;248:*PATENTS=38;5;248:*README=38;5;248:*FAQ=38;5;248:*VERSION=38;5;248:*.css=38;5;220:*.htm=38;5;220:*.html=38;5;220:*.json=38;5;4:*.less=38;5;220:*.md=38;5;220:*.mkd=38;5;220:*.org=38;5;220:*.shtml=38;5;220:*.tex=38;5;220:*.txt=38;5;220:*.xml=38;5;220:*.toml=38;5;220:*.yml=38;5;220:*.rst=38;5;220:*Makefile=38;5;48:*CMakeLists.txt=38;5;48:*.gitignore=38;5;48:*.gitmodules=38;5;48:*SConscript=38;5;48:*SConstruct=38;5;48:*.C=32:*.awk=32:*.c=32:*.cc=32:*.cpp=32:*.csh=32:*.cxx=32:*.el=32:*.h=38;5;50:*.hs=32:*.java=32:*.js=32:*.l=32:*.lhs=32:*.lua=32:*.man=32:*.n=32:*.objc=32:*.p=32:*.php=32:*.pl=32:*.pm=32:*.pod=32:*.purs=32:*.py=32:*.r=32:*.rb=32:*.rdf=32:*.rs=32:*.sed=32:*.sh=32:*.sql=32:*.vim=32:*.zsh=32:*.JPG=33:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.dot=31:*.dotx=31:*.fla=31:*.ppt=31:*.pptx=31:*.psd=31:*.rtf=31:*.xls=31:*.xlsx=31:*.7z=1;35:*.Z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.zip=1;35:*#=38;5;244:*,v=38;5;244:*~=38;5;244:*.BAK=38;5;244:*.DIST=38;5;244:*.OFF=38;5;244:*.OLD=38;5;244:*.ORIG=38;5;244:*.bak=38;5;244:*.dist=38;5;244:*.log=38;5;244:*.o=38;5;244:*.off=38;5;244:*.old=38;5;244:*.org_archive=38;5;244:*.orig=38;5;244:*.pyc=38;5;244:*.swo=38;5;244:*.swp=38;5;244:*.lock=38;5;244:*.scons_opt=38;5;244:*.sconsign.dblite=38;5;244:*.reporter=38;5;244:*.project=38;5;244:*.cdtproject=38;5;244:*Doxyfile=38;5;244:*.deployed=38;5;244:*TODO=1:';
