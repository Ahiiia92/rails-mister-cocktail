const descriptionCocktail = () => {
  const description = document.querySelector("#description");

  if (description !== null) {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito`)
      .then(response => response.json())
      .then((data) => {
        console.log(data.drinks);
        data.drinks.forEach((desc) => {
          const descript = `
          <div class="card-product-description">
            <p>#${desc.strIBA}</p>
            <p>Glass: ${desc.strGlass}</p>
            <p>${desc.strInstructions}</p>
          </div>
          `;
          description.insertAdjacentHTML("beforeend", descript);
        });
      });
  }
}

export { descriptionCocktail };
