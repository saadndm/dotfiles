return {
  {
    prefix = "liminf",
    body = "display(lim_($1->infinity)) $0",
    desc = "Typst ∞ Limit",
  },
  {
    prefix = "lim",
    body = "display(lim_($1->$2)) $0",
    desc = "Typst Limit",
  },
  {
    prefix = "sum",
    body = "sum_($1)^($2) $0",
    desc = "Summation"
  },
  {
    prefix = "align",
    body = [[
#align(
  center,
  $
    $1 & = $0 \
  $,
)]],
    desc = "Align Center"
  },
}
