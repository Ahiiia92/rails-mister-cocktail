const searchCocktail =  () => {
  const list = document.querySelector('#results');

  const insertCocktails = (data) => {
    data.Search.forEach((result) => {
      const cocktail = `<li>
      <img src="${result.strDrinkThumb}" alt="" />
      <p>${result.strDrink}</p>
    </li>`;
      list.insertAdjacentHTML('beforeend', cocktail);
    });
  };

  const fetchCocktails = (query) => {
    fetch(`https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${query}`)
      .then(checkStatus)
      .then(response => response.json())
      .then(insertCocktails)
      .catch((error) => {
        console.log('There was an error', error);
      });
    fetchCocktails('mojito');

    const form = document.querySelector('#search-cocktails');
    form.addEventListener('submit', (event) => {
      event.preventDefault();
      list.innerHTML = '';
      const input = document.querySelector('#search-keyword');
      fetchCocktails(input.value);
    });


    const checkStatus = (response) => {
      if (response.ok) {
        return response;
      }

      let error = new Error(response.statusText);
      error.response = response;
      return Promise.reject(error);
    };
};

export searchCocktail;
