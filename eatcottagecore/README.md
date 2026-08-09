# eatcottagecore.com — redesigned site

A single-file static site (`index.html`) for **Cottage Core**, restyled after the
bold CPG storefront look of getcotto.com while keeping all existing brand
information:

- Brand: Cottage Core — cottage cheese snack cups (pre-launch, waitlist)
- Colors: burgundy `#7b1e3a` + cream `#f6f4f1` (from existing brand emails)
- Font: Bungee (existing brand display font) + Bricolage Grotesque for body
- Links kept: Instagram `@cottagecore.cups`, `sales@eatcottagecore.com`

## Before going live

1. **Waitlist form** — the form currently falls back to opening a pre-filled
   email to `sales@eatcottagecore.com`. Replace the submit handler at the bottom
   of `index.html` (see the `TODO` comment) with your Google Form action URL or
   email-marketing endpoint so signups land in the same list as today.
2. **Flavors** — the three product cards are intentionally "mystery flavor /
   coming soon" cards. Drop in real names, photos, and prices when you're ready.
3. **Logo** — the header uses a text wordmark. Swap in your logo image if you
   prefer (`<a class="logo">`).

## Deploying

The current site is hosted on Google Sites, which can't serve custom HTML like
this. Two easy options:

- **GitHub Pages**: enable Pages for this repo pointing at this folder (or move
  `index.html` into `docs/`), add a `CNAME` file containing
  `eatcottagecore.com`, and update the domain's DNS from Google Sites to GitHub
  Pages.
- **Vercel**: `vercel deploy` this folder and attach the custom domain.
