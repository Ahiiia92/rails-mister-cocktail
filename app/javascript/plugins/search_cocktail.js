import { showCocktail } from "./show_cocktail";

const searchCocktails = (query) => {
  const results = document.querySelector("#results");

  if (results !== null) {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query}`)
      .then(response => response.json())
      .then((data) => {
        data.drinks.forEach((result) => {
          const cocktail = `
              <div class="cards">
                <div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('${result.strDrinkThumb}')">
                  <p>${result.strDrink}</p>
                </div>
              </div>
            `;
          results.insertAdjacentHTML("beforeend", cocktail);
        });
      });
    };

    const form = document.querySelector('#search-cocktails');

  if (results !== null) {
      form.addEventListener('submit', (event) => {
        event.preventDefault();
        const input = event.currentTarget.querySelector('.form-control');
        results.innerHTML = '';
        if (input !== null) {
          searchCocktails(input.value);
        }
      });
    }
  }

  searchCocktails();

const clickAble = () => {
  const card = document.getElementsByClassName('card-category');

  card.addEventListener('click', (e) => {
    console.log("gonna call the api by id");
    console.log(showCocktail());
  })
}

export { searchCocktails, clickAble };
