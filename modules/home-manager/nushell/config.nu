let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell $spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}


let multiple_completers = {|spans|
    match $spans.0
    {
        _ => $carapace_completer
    } | do $in $spans
}



$env.config = {
  show_banner: false,
  keybindings: [],
  completions: {
    external: {
      enable: true
      completer: $multiple_completers
    }
  }
}

