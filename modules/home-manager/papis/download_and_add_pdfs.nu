#!/usr/bin/env nu

def main [--path (-p): path] {
    let files = ls $path | get name | each {|dir|  if ($dir | path type) == "dir" {
        let file = $dir | path join "info.yaml" | path expand
        let contains_url = $file | open | columns | any {|c| $c == url}
        if $contains_url {
            $file
        }
      }
    }

    let contents = $files | each {|f| $f | open}

    let table = ($files | wrap "path") | merge ($contents | wrap "content") | flatten


    $table | each {|row| 
        let dir = $row | get path | path dirname
        let base_url = $row | get url
        let name = $row | get title | split words | str join "-"
        let name = $'($name).pdf'
        if ($base_url | str contains "aclanthology") {
            let url = $'($row | get url).pdf'
            papis addto --doc-folder $dir --urls $url --file-name $name
        } else if ($base_url | str contains "arxiv") {
            let url = $'($base_url | str replace "abs" "pdf").pdf'
            papis addto --doc-folder $dir --urls $url --file-name $name
        } else {
            continue
        }
    }
}

