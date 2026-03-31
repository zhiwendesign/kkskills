# KKStyle Design Rules

## Core Mood

The visual language should feel:

- cute
- bold
- sticker-like
- mascot-driven
- easy to read at a glance

It should not feel:

- corporate
- editorial
- futuristic neon
- luxury minimal

## Palette

Use this order of importance:

1. `#276BEA` as the base blue background
2. `#FCFCFC` as the main card surface
3. `#313A48` for softened outlines and major text
4. `#A4CEFF` / `#62AAFF` for pixel-frame blocks
5. `#FF4D00`, `#FFED00`, `#C2FF2E` as small accents only

## Mascot Shape

The main card should echo a seal peeking over the top edge:

- two rounded bumps at the top edge
- visible dark pupils so the face feels alive, not like two blank white domes
- two eyebrow-like arcs floating above
- a large white body card below

Do not overdraw a complex animal illustration unless the user explicitly asks for it.
The silhouette cue is enough.
Keep a safe zone under the eyes so badges or title chips do not collide with the face.

## Layout Bias

The default `3:4` poster should feel full, not airy:

- one large hero title
- one breakout sticker or number card near the upper-right
- one summary bubble directly under the title
- two dense information panels in the middle
- one bottom strip for source, advice, or final takeaway

The title should not feel jammed against the mascot area:

- give it a little top breathing room under the badge row
- prefer slightly looser line-height on two-line titles
- lift footer notes upward so the lower-left does not sag
- reserve a small cute date chip at the upper-right of the mascot area
- let the date chip sit on the top shell edge instead of floating too high

If the page feels empty, add support blocks.
Do not solve emptiness by only enlarging the title.

## Fixed IP Slot

Every poster should also include the bundled IP character image:

- use `assets/contact-code.png` as the default contact QR
- place the QR to the left of the IP slot
- keep the QR caption as `合作交流`
- use `assets/kk-character.jpeg`
- keep it in a fixed lower-right zone by default
- default to a vertical arrangement: character on top, `是卡卡呀` below
- treat it like a signature sticker, not like the main title
- keep the caption restrained; a compact label works better than a loud sticker

The IP slot should feel intentional:

- softened but clear outline
- cute sticker framing
- enough breathing room from body copy
- consistent placement across outputs
- keep the IP sticker above nearby card edges and never let the shell border clip it

The contact QR and IP slot should behave as one cluster:

- keep the QR card and IP card the same size
- keep `合作交流` and `是卡卡呀` as short captions below each card
- keep both items in the same top-layer cluster

## Date Chip

Every poster should also include a top date chip:

- place it at the far right of the eye area
- let it overlap the top edge of the white shell a little
- use the format `YYYY年MM月DD日`
- make it cute and compact, but large enough to read at a glance

## Typography

- Use rounded or friendly sans-serif text for body copy.
- Use bold title treatment with softened dark-ink edges, not pure black slabs.
- Keep titles short and chunky.
- Labels can look like stickers, tabs, or little chips.

## Decorative Language

Preferred decoration:

- pixel squares
- chunky borders
- sticker tabs
- speech-bubble strips
- a few offset cards
- one breakout card that can cross the white shell edge a little

Avoid:

- delicate lines
- glassmorphism
- soft grayscale-only palettes
- too many gradients

## Content Rules

- One strong title block should dominate the page.
- Support points should be compact and scannable.
- Dense content must be summarized before layout.
- If the card feels empty, add a sticker note or support block instead of shrinking the card.
- A high-value number, ratio, or short phrase should usually occupy the breakout card.
- Bottom notes should be lifted enough that they do not feel detached from the main card.
- Lower-right captions should clarify identity or contact purpose, not compete for attention.

## Final Check

Before returning HTML, verify:

- the mascot silhouette is obvious
- the blue background reads immediately
- the kk character is present in the fixed slot
- the phrase `是卡卡呀` is visible near the character
- the upper-right breakout card is visible and feels intentionally emphasized
- the page does not have large dead zones
- the title has enough air under the top silhouette and chips
- the top date chip is visible, correctly formatted, and not colliding with the eyes
- footer notes feel lifted, not dropped to the bottom edge
- text remains the main payload
- accents stay small and controlled
- the page still works as a screenshot, not as a scrolling web page
