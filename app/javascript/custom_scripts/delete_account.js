function deleteAccount(){
  if (document.getElementById('remove-account') != null){
    let button_submit_delete_account = document.getElementById('button_for_delete_account')
    let check = document.getElementById('user_check')
    let checkbox = document.getElementById('remove-account')

    checkbox.addEventListener('click', ()=>{
      if (checkbox.checked){
        button_submit_delete_account.removeAttribute('disabled')
        check.value = true
        button_submit_delete_account.classList.remove('disabled')
      }
      else{
        check.value = false
        button_submit_delete_account.setAttribute('disabled', '')
        button_submit_delete_account.classList.add('disabled')
      }
    });
  };
};

document.addEventListener("turbolinks:load", function() {
  deleteAccount();
});
