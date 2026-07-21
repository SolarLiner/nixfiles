export def "autojump db" []: nothing -> list<record<path: string, weight: float>> {
  ^autojump -s
  | lines
  | take until { str starts-with '___' }
  | parse --regex '^(?P<weight>\d+\.\d+):\s+(?P<path>.*)$'
  | update weight { into float }
}

export def "nu-complete autojump" []: nothing -> list<string> {
  autojump db | get path | uniq
}

export def --env j [...args: string] {
  let output = (^autojump ...$args);
  let is_dir = (($output | path exists) and (($output | path type) == "dir"));
  if $is_dir {
    echo $output
    cd $output
  } else {
    let meta = (metadata $args);
    error make {
      msg: $"directory '($args)' not found: ($output)",
      labels: [
        { span: $meta.span, text: "from this query" },
      ],
      help: $"Try `autojump --help` for more information.",
    }
  }
}
