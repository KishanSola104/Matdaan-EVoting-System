window.initAdminProfile = function () {
  console.log("Admin Profile page initialized");

  // get the My Account , Reset Passowrd and Logout buttons
  const myAccountBtn = document.getElementById("myAccountBtn");
  const resetPasswordBtn = document.getElementById("resetPasswordBtn");
  const logoutBtn = document.getElementById("logoutBtn");

  // add the event listeners to the buttons
  myAccountBtn.addEventListener("click", function () {
    console.log("My Accoutn Button Clickes");
    loadContent("/admin/adminProfile.html");
  });

  resetPasswordBtn.addEventListener("click",function(){
    console.log("Reset Passwrod button clicked");
    loadContent("/admin/adminResetPassword.html");
  });

    logoutBtn.addEventListener("click",()=>{
        console.log("Logout Button Clicked");
        sessionStorage.clear();
        localStorage.clear();
        location.replace("/index.html");
    });  
};
