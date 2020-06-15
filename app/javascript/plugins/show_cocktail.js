const showCoktails = (query) => {
  const description = document.querySelector("#description");
  const ingredient = document.querySelector("#doses");

  fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query}`)
    .then(response => response.json())
    .then((data) => {
      data.drinks.forEach((description) => {
        const descript = `
            <p>${description.strIBA}</p>
            <h3>Glass:</h3><span></span><p>${description.strGlass}</p>
            <h3>Glass:</h3><span></span><p>${description.strInstructions}</p>
          `;
        console.log(descript);
        description.insertAdjacentHTML("beforeend", descript);
      });
    });

    const cocktails = JSON.parse(ingredient.dataset.drinks);
    cocktails.forEach((cocktail) => {
      console.log(cocktail.strDrink);
    });

  fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?i=${query.doses}`)
    .then(response => response.json())
    .then((data) => {
      data.drinks.forEach((dose) => {
        const ingredient = `
          <h2>${dose.strIngredient}</h2>
          <p>${dose.strDescription}</p>
        `;
        description.insertAdjacentHTML("beforeend", ingredient);
      });
    });

export { showCoktails };
