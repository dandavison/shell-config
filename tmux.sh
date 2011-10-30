if [[ $TERM != screen ]] ; then
    # tmux is not running on this machine, nor have we ssh'd in from a
    # tmux session
    if _dan_is_laptop ; then
	export _DAN_TMUX_SESSION=$(hostname)
	tmux
    else
	echo "Not on laptop, expecting $TERM == screen" 1>&2
	export _DAN_TMUX_SESSION=$(hostname)
	tmux
    fi
else
    if _dan_is_laptop ; then
	# Different prefix for local and remote tmux
	tmux set-option prefix C-v >/dev/null
    else
	# Start tmux on this machine if we are not already in a tmux
	# session on this machine.
	if [[ "$_DAN_TMUX_SESSION" != $(hostname) ]] ; then
	    export _DAN_TMUX_SESSION=$(hostname)
	    tmux
	fi
    fi
fi
