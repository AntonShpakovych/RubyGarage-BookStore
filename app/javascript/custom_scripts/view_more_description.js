function viewMore(){
  if (document.getElementById('button_for_view_more') !=null){
    const VIEW_MORE = 'View More'
    const VIEW_LESS = 'View Less'

    let btn_view_more = document.getElementById('button_for_view_more');
    let description_all = document.getElementById('book_description_all');
    let description_short = document.getElementById('book_description_short');

    btn_view_more.addEventListener('click', ()=>{
      if(description_all.classList.contains('hide_description')) {
        description_all.classList.remove('hide_description');
        description_short.classList.add('hide_description')
        btn_view_more.textContent = VIEW_LESS
      }
      else{
        description_all.classList.add('hide_description');
        description_short.classList.remove('hide_description')
        btn_view_more.textContent = VIEW_MORE
      }
    });
  };
};

document.addEventListener("turbolinks:load", function() {
  viewMore();
});
