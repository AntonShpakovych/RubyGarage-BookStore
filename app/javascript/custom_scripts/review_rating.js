function calculationRating(){
  let default_rating = document.getElementById('review_rating');
  let stars_icons = document.querySelectorAll('#rating i')
  const EMPTY_STAR = 'rate-empty'
  const FILLED_STAR = 'rate-star'

  for (let star of stars_icons) {
    star.addEventListener('click', ()=>{
      default_rating.value = star.getAttribute('data-value')
      for (let i = 0; i < default_rating.value; i++) {
        stars_icons[i].classList.remove(EMPTY_STAR)
        stars_icons[i].classList.add(FILLED_STAR)
      }
    })
  }
}


document.addEventListener("turbolinks:load", function() {
  calculationRating();
});
