import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('.banner-typed-js', {
    strings: ["Learn to bartender", "Make your own cocktail"],
    typeSpeed: 70,
    loop: true,
    showCursor: true,
    cursorChar: '|',
    startDelay: 0,
  });
}

export { loadDynamicBannerText };
