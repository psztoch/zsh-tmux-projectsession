# vim:et sts=2 sw=2 ft=zsh

if (( $+commands[tmux] )); then
  function tt() {
    if [[ -z "$TMUX_PROJECT_SESSION" ]]; then
      print -P "%F{yellow}⚠%f Set %F{cyan}TMUX_PROJECT_SESSION%f in .env/mise.toml"
      return
    fi

    if [[ -n "$TMUX" ]]; then
      if [[ "$TMUX_PROJECT_SESSION" != "$(tmux display-message -p '#S')" ]]; then
        if ! tmux switch-client -t "$TMUX_PROJECT_SESSION" 2>/dev/null; then
          tmux new-session -d -s "$TMUX_PROJECT_SESSION"
          tmux switch-client -t "$TMUX_PROJECT_SESSION"
        fi
      fi
    else
      tmux new-session -A -s $TMUX_PROJECT_SESSION
    fi
  }

  function _tmux_preferred_session() {
    [[ -z "$TMUX_PROJECT_SESSION" ]] && return

    if [[ -n "$TMUX" ]]; then
      if [[ "$TMUX_PROJECT_SESSION" != "$(tmux display-message -p '#S')" ]]; then
        if tmux has-session -t "$TMUX_PROJECT_SESSION" 2>/dev/null; then
          print -P "%F{yellow}⚠%f Use %F{cyan}tt%f or switch (C-B s) to preferred session: %F{cyan}$TMUX_PROJECT_SESSION%f"
        else
          print -P "%F{yellow}⚠%f Use %F{cyan}tt%f or tmux new -s %F{cyan}$TMUX_PROJECT_SESSION%f"
        fi
      fi
    else
      if tmux has-session -t "$TMUX_PROJECT_SESSION" 2>/dev/null; then
        print -P "%F{yellow}⚠%f Use %F{cyan}tt%f or tmux attach -t %F{cyan}$TMUX_PROJECT_SESSION%f"
      else
        print -P "%F{cyan}🛈%f Use %F{cyan}tt%f or tmux new -s %F{cyan}$TMUX_PROJECT_SESSION%f"
      fi
    fi
  }

  autoload -U add-zsh-hook
  add-zsh-hook chpwd _tmux_preferred_session
fi
