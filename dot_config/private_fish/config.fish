if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --global fish_user_paths $HOME/bin $HOME/.local/bin

# fzf integration
set --global FZF_DEFAULT_OPTS --height=40%
set --global FZF_DISABLE_KEYBINDINGS 0
set --global FZF_LEGACY_KEYBINDINGS 0
set --global FZF_PREVIEW_DIR_CMD ls
set --global FZF_PREVIEW_FILE_CMD head -n 10
# set --global FZF_TMUX_HEIGHT 40-

# tide prompt
set --global tide_character_color 5FD700
set --global tide_character_color_failure FF0000
set --global tide_character_icon \u276f
set --global tide_character_vi_icon_default \u276e
set --global tide_character_vi_icon_replace \u25b6
set --global tide_character_vi_icon_visual V
set --global tide_chruby_bg_color B31209
set --global tide_chruby_color 000000
set --global tide_chruby_icon \ue23e
set --global tide_cmd_duration_bg_color C4A000
set --global tide_cmd_duration_color 000000
set --global tide_cmd_duration_decimals 0
set --global tide_cmd_duration_icon \x1d
set --global tide_cmd_duration_threshold 3000
set --global tide_context_always_display false
set --global tide_context_bg_color 444444
set --global tide_context_color_default D7AF87
set --global tide_context_color_root D7AF00
set --global tide_context_color_ssh D7AF87
set --global tide_git_bg_color 4E9A06
set --global tide_git_bg_color_unstable C4A000
set --global tide_git_bg_color_urgent CC0000
set --global tide_git_color_branch 000000
set --global tide_git_color_conflicted 000000
set --global tide_git_color_dirty 000000
set --global tide_git_color_operation 000000
set --global tide_git_color_staged 000000
set --global tide_git_color_stash 000000
set --global tide_git_color_untracked 000000
set --global tide_git_color_upstream 000000
set --global tide_git_icon \x1d
set --global tide_go_bg_color 00ACD7
set --global tide_go_color 000000
set --global tide_go_icon \ue627
set --global tide_jobs_bg_color 444444
set --global tide_jobs_color 4E9A06
set --global tide_jobs_icon \uf013
set --global tide_kubectl_bg_color 326CE5
set --global tide_kubectl_color 000000
set --global tide_kubectl_icon \u2388
set --global tide_left_prompt_frame_enabled false
set --global tide_left_prompt_items pwd git
set --global tide_left_prompt_prefix
set --global tide_left_prompt_separator_diff_color \ue0b0
set --global tide_left_prompt_separator_same_color \ue0b1
set --global tide_left_prompt_suffix \ue0b0
set --global tide_node_bg_color 44883E
set --global tide_node_color 000000
set --global tide_node_icon \u2b22
set --global tide_os_bg_color CED7CF
set --global tide_os_color 080808
set --global tide_os_icon \uf31b
set --global tide_php_bg_color 617CBE
set --global tide_php_color 000000
set --global tide_php_icon \ue608
set --global tide_prompt_add_newline_before true
set --global tide_prompt_color_frame_and_connection 6C6C6C
set --global tide_prompt_color_separator_same_color 949494
set --global tide_prompt_icon_connection \x20
set --global tide_prompt_min_cols 26
set --global tide_prompt_pad_items true
set --global tide_pwd_bg_color 3465A4
set --global tide_pwd_color_anchors E4E4E4
set --global tide_pwd_color_dirs E4E4E4
set --global tide_pwd_color_truncated_dirs BCBCBC
set --global tide_pwd_icon \x1d
set --global tide_pwd_icon_home \x1d
set --global tide_pwd_icon_unwritable \uf023
set --global tide_pwd_markers .bzr .citc .git .hg .node_version .python_version .ruby_version .shorten_folder_marker .svn .terraform Cargo.toml composer.json CVS go.mod package.json
set --global tide_right_prompt_frame_enabled false
set --global tide_right_prompt_items status cmd_duration context jobs virtual_env kubectl vi_mode
set --global tide_right_prompt_prefix \ue0b2
set --global tide_right_prompt_separator_diff_color \ue0b2
set --global tide_right_prompt_separator_same_color \ue0b3
set --global tide_right_prompt_suffix
set --global tide_rustc_bg_color F74C00
set --global tide_rustc_color 000000
set --global tide_rustc_icon \ue7a8
set --global tide_shlvl_bg_color 808000
set --global tide_shlvl_color 000000
set --global tide_shlvl_icon \uf120
set --global tide_shlvl_threshold 1
set --global tide_status_bg_color 2E3436
set --global tide_status_bg_color_failure CC0000
set --global tide_status_color 4E9A06
set --global tide_status_color_failure FFFF00
set --global tide_status_icon \u2714
set --global tide_status_icon_failure \u2718
set --global tide_terraform_bg_color 800080
set --global tide_terraform_color 000000
set --global tide_terraform_icon \x1d
set --global tide_time_bg_color D3D7CF
set --global tide_time_color 000000
set --global tide_time_format
set --global tide_vi_mode_bg_color_default 008000
set --global tide_vi_mode_bg_color_replace 808000
set --global tide_vi_mode_bg_color_visual 000080
set --global tide_vi_mode_color_default 000000
set --global tide_vi_mode_color_replace 000000
set --global tide_vi_mode_color_visual 000000
set --global tide_vi_mode_icon_default DEFAULT
set --global tide_vi_mode_icon_replace REPLACE
set --global tide_vi_mode_icon_visual VISUAL
set --global tide_virtual_env_bg_color 444444
set --global tide_virtual_env_color 00AFAF
set --global tide_virtual_env_icon \ue73c
