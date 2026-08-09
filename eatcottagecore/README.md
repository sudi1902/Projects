# eatcottagecore.com — redesigned site

A single-file static site (`index.html`) for **Cottage Core**, restyled after
getcotto.com's retro-Americana design system — solid red header bar, giant
full-width wordmark hero, circus-awning stripe flavor band, script accents,
scalloped stickers, block-print snack illustrations, and a blue "join the club"
email band — while keeping all existing brand information:

- Brand: Cottage Core — "a sweet new spin on a protein packed dairy product"
- Current flavor: Strawberry Cheesecake; founder story (former collegiate
  athlete); real testimonials from the existing site
- Colors: brand burgundy `#7b1e3a` + warm cream, sticker blue, strawberry pink
- Fonts: Bungee (existing logo font), Oswald (condensed retro caps),
  Yellowtail (script), Bricolage Grotesque (body)
- Links kept: Instagram `@cottagecore.cups`, `sales@eatcottagecore.com`

## Before going live

1. **Waitlist form** — the form currently falls back to opening a pre-filled
   email to `sales@eatcottagecore.com`. Replace the submit handler at the bottom
   of `index.html` (see the `TODO` comment) with your Google Form action URL or
   email-marketing endpoint so signups land in the same list as today.
2. **Images** — the Strawberry Cheesecake card and the cow mascot use inline
   SVG placeholders (marked with `TODO` comments). Swap in the real tub photo
   and mascot artwork for full brand fidelity.
3. **Testimonials** — 3 of the site's 9 quotes are included (the ones legible
   in screenshots). Add the remaining quotes to the `.q-grid` section.
4. **Logo** — the header uses a text wordmark. Swap in your logo image if you
   prefer (`<a class="logo">`).

## Deploying

The current site is hosted on Google Sites, which can't serve custom HTML like
this. Two easy options:

- **GitHub Pages**: enable Pages for this repo pointing at this folder (or move
  `index.html` into `docs/`), add a `CNAME` file containing
  `eatcottagecore.com`, and update the domain's DNS from Google Sites to GitHub
  Pages.
- **Vercel**: `vercel deploy` this folder and attach the custom domain.
