document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("logout-form");
  if (form) {
    form.addEventListener("submit", function (e) {
      if (!confirm("Bạn chắc chắn muốn đăng xuất?")) {
        e.preventDefault();
      }
    });
  }
});