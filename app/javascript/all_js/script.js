document.addEventListener("DOMContentLoaded", function () {
    // ハンバーガーメニュー
    function toggleNav() {
        let hamburger_nav = document.getElementById('hamburger_nav_id');
        let hamburger_btn = document.getElementById('hamburger_btn_id');
        let hamburger_bg = document.getElementById('hamburger_bg_id');
        hamburger_btn.addEventListener('click', function() {
            hamburger_nav.classList.add('open_nav');
            hamburger_bg.classList.add('open_bg');
        });
        hamburger_bg.addEventListener('click', function() {
            hamburger_nav.classList.remove('open_nav');
            hamburger_bg.classList.remove('open_bg');
        });
    }
    toggleNav();
    function toggleMenu() {
        let triangle_btn = document.getElementById('header__triangle_id');
        let triangle_menu = document.getElementById('header__click_menu_id');
        triangle_btn.addEventListener('click', function () {
            triangle_menu.classList.toggle('open_menu');
        });
    }
    toggleMenu();
}, false);