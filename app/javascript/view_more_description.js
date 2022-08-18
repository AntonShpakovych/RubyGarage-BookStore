function myFunc(){
  if (document.getElementById('button_for_view_more') !=null){
    let btn_view_more = document.getElementById('button_for_view_more');
    let description_all = document.getElementById('book_description_all');
    let description_short = document.getElementById('book_description_short');

    btn_view_more.addEventListener('click', ()=>{
      description_all.classList.remove('hide_description');
      description_short.classList.add('hide_description')
    });
  };
};

document.addEventListener("turbolinks:load", function() {
  myFunc();
});
