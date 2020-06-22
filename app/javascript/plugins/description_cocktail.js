import { searchCocktails } from "./search_cocktail";

const descriptionCocktail = () => {
  const description = document.querySelector("#description");

  if (description !== null) {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito`)
      .then(response => response.json())
      .then((data) => {
        console.log(data.drinks);
          const descript = `
          <div class="card-product-description">
            <p>#${data.drinks[1].strIBA}</p>
            <p>Glass: ${data.drinks[1].strGlass}</p>
            <p>${data.drinks[1].strInstructions}</p>
          </div>
          `;
          description.insertAdjacentHTML("beforeend", descript);
      });
  }
}

export { descriptionCocktail };
