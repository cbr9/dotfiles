let current_layout = setxkbmap -query | detect columns --no-headers | update column0 {|it| $it.column0 | str replace ':' ''} | transpose | reject column0 | headers  | str trim | get layout

let layouts = {
    us: "🇺🇸",
    de: "🇩🇪",
    es: "🇪🇸",
    gr: "🇬🇷",
}

let keys = $layouts | columns | to text
let flag = $layouts | get $current_layout.0
let msg = $'Current layout: ($flag)'
setxkbmap ($keys | rofi -dmenu -p "Keyboard Layout" -mesg $msg)
