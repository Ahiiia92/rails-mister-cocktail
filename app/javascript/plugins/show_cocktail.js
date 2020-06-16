const showCocktail = () => {
  const ingredient = document.getElementById('doses');

  if (ingredient !== null) {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito`)
      .then(response => response.json())
      .then((data) => {
        data.drinks.forEach((dose) => {
          const ingredients = `
          <div class="card-product">
            <div class="card-infos">
              <div class="card-product-actions">
                <h2>${dose.strIngredient1}</h2>
                <p>${dose.strMeasure1}</p>
              </div>
            </div>
          </div>
        `;
          console.log(ingredients);
          ingredient.insertAdjacentHTML("beforeend", ingredients);
        });
      });
    };
  }


export { showCocktail };


