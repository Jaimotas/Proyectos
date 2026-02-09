function togglePassword() {
    const input = document.getElementById("password");
    const icon = document.querySelector(".toggle-password i");

    if (input.type === "password") {
        input.type = "text";
        icon.textContent = "visibility_off";
    } else {
        input.type = "password";
        icon.textContent = "visibility";
    }
}

/*
document.addEventListener("DOMContentLoaded", function () {
    const user = document.getElementById("username");
    if (user) {
        user.focus();
    }
});
*/