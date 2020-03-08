console.log("Hello from app/javascript/packs/application.js!");

import 'bootstrap';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initUpdateNavbarOnScroll } from '../../assets/javascripts/components/navbar';
import { loadDynamicBannerText } from '../../assets/javascripts/components/banner';
import { initMapbox } from '../plugins/init_mapbox';

loadDynamicBannerText();
initUpdateNavbarOnScroll();
initMapbox();
