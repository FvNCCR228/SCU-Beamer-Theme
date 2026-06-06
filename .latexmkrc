# latexmk config
# --------------------
# texdoc latexmk
# https://www.ctan.org/tex-archive/support/latexmk/example_rcfiles
# https://www.ctan.org/tex-archive/support/latexmk/extra-scripts
# --------------------


# ---------- engine commands ----------
# xelatex:: XeTeX engine cmd, .tex → .xdv
#           -shell-escape → allow external commands (for minted, tikz external, etc.)
#           interaction=nonstopmode → never pause on errors
#           synctex=1 → enable SyncTeX for editor-PDF sync
#           file-line-error → show errors as file:line: msg
#           8bit → treat bytes as printable, avoid ^^ escape sequences
$xelatex = 'xelatex ' .
  # ↓ enable only if trusted and needed (e.g. minted ≤v2 / tikz external); comment out otherwise
  # '-shell-escape ' .
  # ↓ can use batchmode for speed, but loses error output
  '-interaction=nonstopmode ' .
  '-synctex=1 -file-line-error -8bit %O %S';

# lualatex:: LuaTeX engine cmd
# $lualatex = 'lualatex ' .
#   '-shell-escape ' .
#   '-interaction=nonstopmode ' .
#   '-synctex=1 -file-line-error -8bit %O %S';

# biber:: bibliography processor for biblatex
$biber = 'biber %O %S';

# xdvipdfmx:: .xdv → .pdf
#             -z 5 → set compression level to 5 (0-9, default 9)
#             -E → force font embedding regardless of licensing flags
#                  fixes https://github.com/CTeX-org/ctex-kit/issues/352
#             -q → quiet mode, suppress non-error messages
$xdvipdfmx = 'xdvipdfmx -z 5 -E -q -o %D %O %S';


# ---------- build optimization ----------
# go mode (recommend 0 or 3)
#   0 : normal, run only when out-of-date (-g-)
#   1 : force each rule to run at least once (-g)
#   2 : full clean then process from scratch (-gg)
#   3 : require at least one run of *latex (-gt)
$go_mode = 3;

# max *latex runs before bail out (default 5, recommend 1 or 5)
$max_repeat = 5;

# aux file directory (create matching subdirs in tmp/build if .tex files are in subdirs)
$aux_dir = 'tmp/build';

# generate pdf via xelatex + xdvipdfmx (5=xelatex, 4=lualatex, 1=pdflatex, 0=none)
$pdf_mode = 5;
# disable postscript and dvi output
$postscript_mode = $dvi_mode = 0;
# continue past minor errors, ignore undefined refs
$force_mode = 1;
# emulate aux dir for TeXLive (MiKTeX supports -aux-directory, TeXLive does not)
$emulate_aux = 1;
# show total compilation time
$show_time = 1;
# extra extensions to remove on cleanup (-c / -C)
$clean_ext = 'bbl glo gls hd loa nav run.xml snm thm xdv';


# ---------- pvc mode (-pvc) ----------
# poll interval (seconds)
$sleep_time = 3;
# avoid viewer flickering on temp files
# $pvc_view_file_via_temporary = 0;
