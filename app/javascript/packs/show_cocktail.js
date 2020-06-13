const showCoktails = (query) => {
  const description = document.querySelector("#description");
  const ingredient = document.querySelector("#doses");

  fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query}`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log(data.drinks[0]);
      data.drinks.forEach((description) => {
        const descript = `
            <p>${description.strIBA}</p>
            <h3>Glass:</h3><span></span><p>${description.strGlass}</p>
            <h3>Glass:</h3><span></span><p>${description.strInstructions}</p>
          `;
        console.log(descript);
        description.insertAdjacentHTML("beforeend", descript);
        description.insertAdjacentHTML("beforeend", ingredient);
      });
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
