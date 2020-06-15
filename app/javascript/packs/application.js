// External Libraries
import 'bootstrap';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initUpdateNavbarOnScroll } from '../plugins/navbar';
import { loadDynamicBannerText } from '../plugins/banner';
import { initMapbox } from '../plugins/init_mapbox';
import { readMore } from '../plugins/read_more';
import { searchCocktails } from '../plugins/search_cocktail';
import { showCocktail } from '../plugins/show_cocktail';
import { descriptionCocktail } from '../plugins/description_cocktail';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  loadDynamicBannerText();
  initUpdateNavbarOnScroll();
  readMore();
  searchCocktails();
  showCocktail();
  descriptionCocktail();
});
