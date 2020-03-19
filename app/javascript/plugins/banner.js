import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Learn to bartender", "Make your own cocktail"],
    typeSpeed: 70,
    loop: false,
    showCursor: true,
    cursorChar: '|',
    startDelay: 0,
  });
}

export { loadDynamicBannerText };
