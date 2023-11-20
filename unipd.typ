#import "@preview/polylux:0.3.1": logic, utils

#let unipd-red = rgb("#9b0014");
#let unipd-gray = rgb("#484f59");
#let unipd-lightgray = rgb("#fbfef9");

#let unipd-title = state("unipd-title", none)
#let unipd-subtitle = state("unipd-subtitle", none)
#let unipd-author = state("unipd-author", none)
#let unipd-date = state("unipd-date", none)
#let unipd-progress-bar = state("unipd-progress-bar", true)

#let unipd-theme(
  aspect-ratio: "16-9",
  author: none,
  date: none,
  title: none,
  subtitle: none,
  progress-bar: true,
  body,
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )
  set text(size: 22pt)
  show footnote.entry: set text(size: .65em)

  unipd-progress-bar.update(progress-bar)
  unipd-title.update(title)
  unipd-subtitle.update(subtitle)
  unipd-author.update(author)
  unipd-date.update(date)

  body
}

#let title-slide(title: "", subtitle: none) = {
  logic.polylux-slide({
    place(image("images/background.svg", width: 100%))
    place(
      bottom + right,
      dx: -2%,
      dy: -2%,
      image("images/logo.svg", width: 30%),
    )
    set text(fill: white)
    v(15%)
    align(
      center,
      box(inset: (x: 2em), text(size: 46pt, title)),
    )
    if (subtitle != none) {
      align(
        center,
        box(inset: (x: 2em), text(size: 26pt, style: "italic", subtitle)),
      )
    }
    v(10%)
    h(7.5%)
    text(size: 24pt, unipd-author.display())
    linebreak()
    h(7.5%)
    text(size: 20pt, unipd-date.display())
  })
}

#let slide(
  title: none,
  header: none,
  footer: none,
  hide-section: false,
  new-section: none,
  body,
) = {
  let body = pad(x: 2em, top: 1em, body)

  let header-text = {
    if header != none {
      header
    } else if title != none {
      if new-section != none {
        utils.register-section(new-section)
      }
      show heading: set text(size: 22pt)
      set text(fill: white)
      pad(
        x: 1.5em,
        y: 1.5em,
        grid(
          columns: (50%, 50%),
          align(horizon + left, heading(level: 2, title)),
          if (hide-section) {
            box()
          } else {
            align(horizon + right, text(
              fill: white,
              utils.current-section,
            ))
          }
        ),
      )
    } else { [] }
  }

  let header = {
    set align(top)
    block(fill: unipd-red, grid(
      rows: (auto, auto),
      header-text,
    ))
  }

  let footer = {
    set text(size: 12pt)
    set align(center + bottom)
    if footer != none {
      footer
    } else {
      show: block.with(width: 100%, height: auto, fill: unipd-red);
      set text(fill: white)
      pad(
        y: 1em,
        x: 2.5em,
        grid(
        columns: (1fr, 1fr, 1fr),
        align(left, unipd-author.display()),
        unipd-title.display(),
        align(right, logic.logical-slide.display() + [~/ ~] + utils.last-slide-number),
      )
      )
    }
  }

  set page(
    margin: (top: 3em, bottom: 2em, x: 0em),
    header: header,
    footer: footer,
    footer-descent: 0.15em,
    header-ascent: .6em,
  )

  logic.polylux-slide(body)
}

#let focus-slide(
  background-color: none,
  background-img: none,
  body,
) = {
  let background-color = if background-img == none and background-color == none {
    unipd-red
  } else {
    background-color
  }

  set page(fill: background-color, margin: 1em) if background-color != none
  set page(
    background: {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    },
    margin: 1em,
  ) if background-img != none

  set text(fill: white, size: 2em)

  logic.polylux-slide(align(horizon, body))
}
