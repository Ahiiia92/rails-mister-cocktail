console.log("Hello from app/javascript/packs/application.js!");

import 'bootstrap';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initUpdateNavbarOnScroll } from '../plugins/navbar';
import { loadDynamicBannerText } from '../plugins/banner';
import { initMapbox } from '../plugins/init_mapbox';
import { readMore } from '../plugins/read_more';

loadDynamicBannerText();
initUpdateNavbarOnScroll();
initMapbox();
readMore();
