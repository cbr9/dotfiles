def-env lfcd [] {
  let tmp = (mktemp)
  lf -last-dir-path $tmp
  try {
    let target_dir = (open --raw $tmp)
    rm -f $tmp
    try {
        if ($target_dir != $env.PWD) { cd $target_dir }
    } catch { |e| print -e $'lfcd: Can not change to ($target_dir): ($e | get debug)' }
  } catch {
    |e| print -e $'lfcd: Reading ($tmp) returned an error: ($e | get debug)'
  }
}

let carapace = {|spans: list<string>|
    carapace $spans.0 nushell $spans
    | from json
    | if ($in | default [] | where value =~ '.*ERR$' | is-empty) { $in } else { null }
}

let zoxide = {|spans|
    $spans | skip 1 | zoxide query -l $in | lines | where {|x| $x != $env.PWD}
}

let fish = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let completer = {|spans|
  match $spans.0 {
      z | zi => $zoxide
      _ => $carapace
  } | do $in $spans
}

$env.config = {
  show_banner: false,
  keybindings: [
    {
      name: lfcd
      modifier: Control
      keycode: Char_w
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: ExecuteHostCommand
        cmd: "lfcd"
      }
    },
    {
      name: edit_command_line
      modifier: Alt
      keycode: Char_e
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: OpenEditor
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_l
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: HistoryHintWordComplete }          
          { edit: MoveWordRight }
        ]
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_j
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: MenuDown }          
          { send: Down }
        ]
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: MenuUp }          
          { send: Up }
        ]
      }
    },
  ],
  completions: {
    external: {
      enable: true
      completer: $completer
    }
  },
  cursor_shape: {
    vi_insert: line
    vi_normal: line
    emacs: line
  }
}


