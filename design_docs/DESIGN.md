---
name: Atmospheric Design System
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#c4c7c8'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#8e9192'
  outline-variant: '#444748'
  surface-tint: '#c6c6c7'
  primary: '#ffffff'
  on-primary: '#2f3131'
  primary-container: '#e2e2e2'
  on-primary-container: '#636565'
  inverse-primary: '#5d5f5f'
  secondary: '#90cdfd'
  on-secondary: '#00344f'
  secondary-container: '#025781'
  on-secondary-container: '#90cdfd'
  tertiary: '#ffffff'
  on-tertiary: '#2900a0'
  tertiary-container: '#e4dfff'
  on-tertiary-container: '#5f4ed9'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e2e2e2'
  primary-fixed-dim: '#c6c6c7'
  on-primary-fixed: '#1a1c1c'
  on-primary-fixed-variant: '#454747'
  secondary-fixed: '#cae6ff'
  secondary-fixed-dim: '#90cdfd'
  on-secondary-fixed: '#001e30'
  on-secondary-fixed-variant: '#004b70'
  tertiary-fixed: '#e4dfff'
  tertiary-fixed-dim: '#c6bfff'
  on-tertiary-fixed: '#160066'
  on-tertiary-fixed-variant: '#4029ba'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  temp-display:
    fontFamily: Manrope
    fontSize: 96px
    fontWeight: '200'
    lineHeight: 100px
    letterSpacing: -0.04em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 32px
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-caps:
    fontFamily: Space Grotesk
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.1em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  container-padding: 24px
  element-gap: 16px
  section-margin: 40px
  glass-padding: 20px
---

## Brand & Style
The design system is centered on "Contextual Immersion." The goal is to make the user feel the weather before they even read the numbers. The brand personality is serene, observant, and premium. It avoids clinical data visualization in favor of an atmospheric, editorial experience.

The design style is a sophisticated blend of **Minimalism** and **Glassmorphism**. By using high-transparency layers and expansive background blurs, the UI becomes a lens through which the weather conditions are viewed. Every element is designed to feel lightweight and ethereal, reducing cognitive load while maintaining a high sense of polish and technological precision.

## Colors
This design system utilizes a **Dynamic Theming Engine**. While the core interface elements remain white or semi-transparent, the global background is a generative gradient that reflects the current meteorological state. 

- **Primary:** Pure white (#FFFFFF) is used for all critical data and primary icons to ensure maximum legibility against complex backgrounds.
- **Surface:** Glass layers use white with 10% to 20% opacity.
- **Dynamic States:** Colors transition smoothly between palettes (Sunny, Cloudy, Night, Stormy) using long-duration CSS transitions to maintain the "atmospheric" feel. 
- **Overlays:** Use a subtle 15% black tint for lower-level background elements to maintain contrast during brighter "Sunny" conditions.

## Typography
The typography strategy prioritizes a strict visual hierarchy. **Manrope** is selected for its balanced, modern proportions that remain legible even when placed over vibrant, moving backgrounds. 

- **Temperature Readings:** Use the `temp-display` style. The light font weight (200) at a large scale creates a premium, editorial look without feeling "heavy."
- **Data Labels:** **Space Grotesk** is used for secondary data points (e.g., Humidity, UV Index) to provide a subtle technical, geometric contrast to the organic feel of the backgrounds.
- **Clarity:** Always use a subtle text-shadow (0px 2px 4px rgba(0,0,0,0.1)) for white text to ensure accessibility across all dynamic background colors.

## Layout & Spacing
The layout follows a **Fluid Grid** model with a focus on vertical storytelling. Content is grouped into logical "Atmospheric Cards" that sit on a 12-column grid for tablet/desktop and a single-column stack for mobile.

- **Rhythm:** Use a 4px baseline shift. All components should use multiples of 8px for internal padding (e.g., 16px, 24px, 32px).
- **Safe Areas:** Maintain a generous 24px margin from the screen edges to allow the background gradients to "breathe" around the content.
- **Grouping:** Use the `element-gap` (16px) for items within a card (e.g., hourly forecast dots) and `section-margin` (40px) to separate major weather modules (e.g., Current Weather vs. 10-Day Forecast).

## Elevation & Depth
Depth is achieved through **Glassmorphism** rather than traditional drop shadows. This design system treats the screen as a series of translucent physical planes.

- **Surface 1 (Base):** The dynamic background gradient.
- **Surface 2 (Glass Cards):** White fill at 12% opacity with a `backdrop-filter: blur(20px)`. This creates the "frosted" look.
- **Surface 3 (Active Elements):** White fill at 25% opacity with a soft, diffused shadow (0px 10px 30px rgba(0,0,0,0.08)).
- **Accents:** Use a 1px solid border with 20% white opacity on the top and left edges of cards to simulate a light source and give the glass "thickness."

## Shapes
The shape language is organic and approachable. Standard cards and containers use a **16px (1rem)** corner radius to complement the soft nature of the blurred backgrounds. 

Small interactive elements like buttons or chips should utilize the **rounded-xl (24px)** or pill-shaped setting to distinguish them from informational cards. Avoid sharp corners entirely to maintain the "atmospheric" and "soft" aesthetic of the system.

## Components
- **Weather Cards:** The core container. Must include a 20px backdrop blur, a 1px semi-transparent border, and 20px internal padding.
- **Action Buttons:** Use a high-contrast treatment—either a solid white background with dark text or a heavy glass effect (40% opacity) for secondary actions.
- **Segmented Controls (Time Toggles):** A single pill-shaped glass container with a sliding "active" state that uses a 30% white fill.
- **Data Chips:** Small, highly-rounded tags used for weather alerts or "now" indicators. These should use a subtle tint of the "Accent" color from the dynamic palette.
- **Weather Icons:** Custom, thin-stroke (1.5px) glyphs. For premium feel, use "Glass-icons"—icons that incorporate subtle gradients and transparency rather than flat solid colors.
- **Interactive Graphs:** Line charts for temperature should use a gradient stroke that matches the "Accent" color of the current weather state, with a soft glow effect.