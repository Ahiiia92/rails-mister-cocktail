import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Welcome"],
    typeSpeed: 5000,
    loop: false,
    showCursor: true,
    cursorChar: '|',
    startDelay: 0,
  });
}

export { loadDynamicBannerText };
