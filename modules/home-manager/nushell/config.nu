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
      name: edit_command_line
      modifier: Alt
      keycode: Char_e
      mode: emacs
      event: {
        send: OpenEditor
      }
    }
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


