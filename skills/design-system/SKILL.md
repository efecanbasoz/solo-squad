---
name: design-system
description: "Build a complete design system from scratch: research the landscape, define tokens, create component library, establish patterns, and write documentation."
---

# Design System

You are a design systems architect building foundations that scale.

## Process

1. **Landscape research.** Analyze 3-5 competitors and 3-5 aspirational brands. What works, what's generic, what's distinctive.
2. **Design tokens.** Define: color palette (primary, secondary, neutral, semantic), typography scale, spacing scale, border radii, shadows, breakpoints.
3. **Component inventory.** Start with primitives (Button, Input, Card, Badge, Avatar) then composites (Form, Navigation, Modal, Table).
4. **Pattern library.** Common layouts and interaction patterns with usage guidelines.
5. **Documentation.** For each component: when to use, when not to use, props/variants, accessibility requirements, code examples.

## Starter Templates

When starting from scratch, use one of these templates as a foundation. Adapt to the specific project — these are starting points, not rigid frameworks.

### SaaS Product Template

**Colors:** Primary (brand action color), Secondary (supporting), Neutral (gray scale 50-950), Success/Warning/Error semantic colors. Dark mode: invert neutrals, reduce primary saturation by 10%.

**Typography:** Inter or system font stack. Scale: 12/14/16/18/20/24/30/36/48px. Line heights: 1.5 for body, 1.2 for headings. Weight: 400 (body), 500 (labels), 600 (headings), 700 (emphasis).

**Spacing:** 4px base unit. Scale: 4/8/12/16/20/24/32/40/48/64/80/96px. Use 16px as default component padding. 24px between related elements, 48px between sections.

**Components:** Button (primary/secondary/ghost/danger), Input (text/select/checkbox/radio/toggle), Card, Modal, Toast, Table, Badge, Avatar, Tabs, Dropdown.

### Marketing Site Template

**Colors:** Hero gradient (bold, brand-forward), Accent (CTAs), Neutral (text/backgrounds), Section alternation (light/dark backgrounds). Emphasize contrast and visual impact over subtlety.

**Typography:** Display font (headings) + Body font (content). Larger scale: 14/16/18/20/24/32/40/48/60/72px. More dramatic size contrast between headings and body.

**Spacing:** 8px base unit. Generous whitespace: 32px between elements, 80-120px between sections. Hero sections: 160px+ vertical padding.

**Components:** Hero (image/video/gradient variants), Feature grid, Testimonial carousel, Pricing table, FAQ accordion, CTA banner, Footer with sitemap, Newsletter signup.

### E-Commerce Template

**Colors:** Neutral-dominant (products are the color). Accent for CTAs (add to cart, checkout). Trust signals: green for availability, red for urgency. Minimal brand color — don't compete with product imagery.

**Typography:** Clean, high-readability font. Scale focused on scannability: 12/14/16/18/24/32px. Price typography: larger, bolder, different weight than surrounding text.

**Spacing:** Dense but organized. 8px base. Product grids: 16px gaps. Compact cards to show more products. Generous whitespace in checkout flow to reduce cognitive load.

**Components:** Product card (image/title/price/rating/CTA), Product gallery, Size selector, Quantity stepper, Cart drawer, Checkout steps, Order summary, Review stars, Wishlist toggle, Filter sidebar.

## Rules
- Consistency > creativity for a design system. Save creativity for the product design.
- Every component must meet WCAG 2.1 AA at minimum.
- Document decisions, not just the outputs.
