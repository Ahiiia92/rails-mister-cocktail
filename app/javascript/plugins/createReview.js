const { data } = require("jquery");

function createReview() {
 const rateBtn = document.getElementsByName('rate-btn');

 rateBtn.addEventListener('click', (event) => {
   event.preventDefault();
   createReview.innerHTML = '';
   data.Search.forEach((result) => {

   })
 })
}
