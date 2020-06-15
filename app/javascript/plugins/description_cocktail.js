const descriptionCocktail = () => {
  const description = document.querySelector("#description");

  if (description !== null) {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito`)
      .then(response => response.json())
      .then((data) => {
        console.log(data.drinks[0]);
        data.drinks.forEach((desc) => {
          const descript = `
          <div class="card-product">
            <p>${desc.strIBA}</p>
            <h3>Glass:</h3><span></span><p>${desc.strGlass}</p>
            <h3>Glass:</h3><span></span><p>${desc.strInstructions}</p>
          </div>
          `;
          console.log(descript);
          description.insertAdjacentHTML("beforeend", descript);
        });
      });
  }

}

export { descriptionCocktail };
