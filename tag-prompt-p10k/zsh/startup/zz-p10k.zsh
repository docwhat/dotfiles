# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Config overrides.
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=true
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='\uF059'$s       # 
typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='\uF06A'$s        # 
typeset -g POWERLEVEL9K_VCS_STAGED_ICON='\uF055'$s          # 
typeset -g POWERLEVEL9K_VCS_STASH_ICON='\uF01C '            # 
typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\uF01A ' # 
typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\uF01B ' # 
typeset -g POWERLEVEL9K_VCS_TAG_ICON='\uF02B '              # 
typeset -g POWERLEVEL9K_VCS_BOOKMARK_ICON='\uF461 '         # 
typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='\uE729 '           # 
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '           # 
typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON='\uE728 '    # 

# Use the p10k command if you want to re-run the config wizard.
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
