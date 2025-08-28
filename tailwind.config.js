/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        // Food categories (warm tones)
        'food-primary': '#FF6B6B',  // reddish for pizza
        'food-secondary': '#FFD166', // yellowish for coffee

        // Lifestyle categories (cool tones)
        'lifestyle-primary': '#06D6A0',   // teal for gyms
        'lifestyle-secondary': '#118AB2', // blue for neighborhoods

        // Events (vibrant)
        'events-primary': '#9B5DE5',      // purple for festivals

        // General UI colors
        'ui-primary': '#073B4C',          // dark blue for text
        'ui-secondary': '#F8F9FA',        // light gray for backgrounds
        'ui-accent': '#FF9F1C',           // orange for accents/CTAs
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        heading: ['Poppins', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
