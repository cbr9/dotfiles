let carapace = {|spans: list<string>|
    carapace $spans.0 nushell $spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
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
      nix-shell | nix-build | nix-instantiate | nix-channel | nix => $carapace
      _ => $fish
  } | do $in $spans
}

$env.config = {
  show_banner: false,
  keybindings: [],
  completions: {
    external: {
      enable: true
      completer: $completer
    }
  }
}


