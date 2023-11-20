#import "@preview/polylux:0.3.1": *
#import "unipd.typ": *

#show: unipd-theme.with(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  date: "Date",
  )

#set text(font: (
  "Verdana",
  "Noto Sans",
  "Segoe UI",
  "roboto",
  "Helvetica Neue",
  "Cantarell",
  "sans-serif",
))

#title-slide(
  title: unipd-title.display(),
  subtitle: unipd-subtitle.display(),
)

#slide(
  title: "",
  new-section: "",
)[]