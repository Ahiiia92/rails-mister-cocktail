const searchCocktails = (query) => {
  const results = document.querySelector("#results");

  fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query}`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log(data.drinks[0]);
      data.drinks.forEach((result) => {
        const cocktail = `
        <div class="cards">
          <div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('${result.strDrinkThumb}')">
            <p>${result.strDrink}</p>
          </div>
        </div>
          `;
        console.log(cocktail);
        results.insertAdjacentHTML("beforeend", cocktail);
      });
    });

  const form = document.querySelector('#search-cocktails');

  form.addEventListener('submit', (event) => {
    event.preventDefault();
    const input = event.currentTarget.querySelector('.form-control');
    results.innerHTML = '';
    searchCocktails(input.value);
  });
}

  export { searchCocktails };
