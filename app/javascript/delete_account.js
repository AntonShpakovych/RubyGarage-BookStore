function deleteAccount(){
  if (document.getElementById('remove-account') != null){
    let button_submit_delete_account = document.getElementById('button_for_delete_account')
    let checkbox = document.getElementById('remove-account')

    checkbox.addEventListener('click', ()=>{
      if (checkbox.checked){
        button_submit_delete_account.classList.remove('disabled')
      }
      else{
        button_submit_delete_account.classList.add('disabled')
      }
    });
  };
};

document.addEventListener("turbolinks:load", function() {
  deleteAccount();
});
