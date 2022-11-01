main = do
  let prompt = [ColoredText Magenta username,
                Text "@",
                ColoredText Orange hostname,
                Text " in ",
                ColoredText Green fullPWD,
                Text "\\$([[ -n \\$(git branch 2> /dev/null) ]] && echo \\\" on \\\")",
                ColoredText Purple (Text "\\$(parse_git_branch)"),
                newline,
                Text "\\$ "
                ]
  header <- readFile "prompt.bash"
  putStrLn $ header ++ "PS1=\"" ++ concatMap generate prompt ++ "\""

data Color = Magenta | Orange | Green | Purple | White

instance (Show Color) where
  show Magenta = "MAGENTA"
  show Orange  = "ORANGE"
  show Green   = "GREEN"
  show Purple  = "PURPLE"
  show White   = "WHITE"

data Entry = Text String
           | ColoredText Color Entry

generate :: Entry -> String
generate (Text s) = s
generate (ColoredText c e) = "\\[$" ++ (show c) ++ "\\]" ++ generate e ++ "\\[$RESET\\]"

username = Text "\\u"
hostname = Text "\\$(uname -n)"
fullPWD = Text "\\w"
newline = Text "\\n"
