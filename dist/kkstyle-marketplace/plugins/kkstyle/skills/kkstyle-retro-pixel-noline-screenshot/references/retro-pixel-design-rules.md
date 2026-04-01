# Retro Pixel Design Rules

## Core Mood

The visual language should feel:

- playful
- chunky
- game-like
- readable
- energetic

It should not feel:

- cyberpunk neon overload
- sleek SaaS dashboard
- scrapbook paper craft
- flat generic poster

## Palette

Use this order of importance:

1. `#0d1428` / `#11192f` as the dark background
2. `#e9f3ff` / `#f7fbff` as the light panel surface
3. `#32363d` as the softened ink soft text and ghost separators
4. `#6ef2c0`, `#45d0ff`, `#ffe45b`, `#ff7a59` as limited pixel accents
5. keep the brightest color for status emphasis only

## Layout Bias

The default `3:4` poster should feel like a handheld game HUD:

- one dominant title area
- one top-right status card
- one summary panel
- two main information panels
- one lifted footer info area

The title should feel strong, not cramped:

- allow breathing room below top HUD elements
- keep multi-line titles bold and clear
- preserve a strong left alignment

## Date HUD

Every poster should include a date HUD:

- place it near the upper-right
- make it look like a status chip
- use `YYYY年MM月DD日`
- keep it readable at a glance

## Contact Cluster

Every poster should include the bundled contact cluster:

- use `assets/contact-code.png` as the QR card
- use `assets/kk-character.jpeg` as the IP card
- place the QR to the left of the IP
- keep both cards the same size
- keep `合作交流` and `是卡卡呀` as compact captions below
- keep the cluster above nearby edges and panels

## Typography

- Use strong, chunky headings.
- Body text should remain clean and modern.
- Labels should feel like HUD chips or status strips.
- Titles should resemble a game cover headline.

## Content Rules

- One title should dominate.
- Support points should be grouped into compact cards.
- Dense material must be summarized before layout.
- If the page feels empty, add another structured HUD panel.
- If the page feels noisy, reduce accent colors before reducing hierarchy.

## No-Line Rule

- avoid visible black outlines
- separate sections with fill, shadow, blur, or spacing first
- if a separator is needed, keep it low-contrast and secondary

## Final Check

Before returning HTML, verify:

- the retro-pixel mood reads immediately
- the title is the primary focal point
- the date HUD is visible and correctly formatted
- the QR and Kaka IP are both present
- the two contact cards are the same size
- footer notes feel lifted, not sunk
- text remains the main payload
