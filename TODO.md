# TODO

-   Git setup
-   Package documentation
-   Split into mutiple packages (EHA-internal and general)
    -   Separate main function and eha-outbreak and eha-internal functions that call it
    -   Make drat repository for public using git-worktree and private on on EHA github
-   HTMLwidget and/or knitr hook to make full-screen versions of images.

-  Fix non-sidenote footnotes.

PDF output command:

-   wkhtmltopdf --javascript-delay 25000 --print-media-type -s Letter -B 0 -L 0 -R 0 -T 0 test.html wkt.pdf
-   requires 0.12.3 or later to deal with image transparency
-   javascript delay is for rendering mathjax