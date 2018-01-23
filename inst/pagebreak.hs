#!/usr/bin/env runhaskell

import Text.Pandoc.JSON

pgBrkXml :: String

pgBrkXml = "<w:p><w:r><w:br w:type=\"page\"/></w:r></w:p>"

pgBrkBlock :: Block
pgBrkBlock = RawBlock (Format "openxml") pgBrkXml

insertPgBrks :: Block -> Block
insertPgBrks (RawBlock (Format "latex") "\\newpage") = pgBrkBlock
insertPgBrks blk = blk

main = toJSONFilter insertPgBrks
