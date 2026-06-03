# Phase 5: Cinematic UI & Branding Integration

This phase will integrate the provided high-fidelity Velsec logo and cinematic banner into the Next.js frontend. The goal is to blend these 2D assets seamlessly with our existing 3D React Three Fiber background, utilizing advanced CSS effects (glassmorphism, neon shadows, and scanlines) to create a premium "hacker environment".

## User Review Required

> [!IMPORTANT]
> **Saving the Images to the Project**
> I can see the awesome Velsec banner and logo you uploaded! However, because they were pasted into the chat, I cannot directly download them to your local hard drive. 
> 
> **Before I execute this plan**, please save those two images into your project's public folder:
> 1. Save the square logo as: `d:\Velsec\velsec-org\frontend\public\velsec-logo.png`
> 2. Save the wide banner as: `d:\Velsec\velsec-org\frontend\public\velsec-banner.png`

## Open Questions

1. **Banner Placement:** The wide banner contains text ("Secure Today. Empower Tomorrow"). Should we use this banner as the primary centerpiece of the main landing page (`velsec.com`), entirely replacing the glowing 3D Globe, or should we display the banner *above/below* the 3D globe?
2. **Logo Placement:** I plan to place the square logo in the top-left corner of the screen across all subdomains as a persistent navigation brand mark. Does that sound good?

## Proposed Changes

### 1. Persistent Navigation Bar (Logo)
We will create a floating navigation bar that sits on top of the 3D canvas across all routes.
#### [NEW] `frontend/src/components/ui/Navbar.tsx`
- Will use `next/image` to load `/velsec-logo.png`.
- Applied CSS filters: `drop-shadow(0 0 10px rgba(0, 240, 255, 0.8))` to make the metallic trident glow with the cyber blue aesthetic.

### 2. Main Landing Page Updates (Banner)
We will update the root landing page to prominently feature the banner.
#### [MODIFY] `frontend/src/app/(subdomains)/velsec/page.tsx`
- Import the banner image using Next.js `<Image />` component.
- Apply a "cinematic" wrapper to the banner:
  - Add a subtle vignette (darkened edges).
  - Add CSS scanline overlays to make it look like a high-tech terminal monitor.
  - Implement a glassmorphic container (`backdrop-blur-md`, border `#39ff14/30`) to frame the banner elegantly against the dark void.

### 3. Global CSS Enhancements
#### [MODIFY] `frontend/src/app/globals.css`
- Add `@keyframes scanline` and `.scanline-overlay` utility classes to enforce the cyberpunk hacker environment.

## Verification Plan

### Manual Verification
- You will save the images to the `public/` folder.
- I will execute the code changes.
- You will check `http://velsec.com:3000` to ensure the logo and banner appear perfectly integrated with the 3D background.
