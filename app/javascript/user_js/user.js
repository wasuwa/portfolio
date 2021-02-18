// 画像アップロード時のプレビュー機能
window.addEventListener('load', () => {
    const uploader = document.querySelector('.settings__icon--img_select');
    uploader.addEventListener('change', (e) => {
    const file = uploader.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
        const image = reader.result;
        document.querySelector('.settings__icon--img').setAttribute('src', image);
    }
    });
});

// プレビュー機能から画像を削除する
const delete_button = document.getElementById("icon_delete_button");
delete_button.addEventListener('click', function () {
    const defaultImage = '/assets/default_icon-43b9fbf38c3e2e5ea4de759a502cd7672bd431a1b56ca7ae8d00dc80e9909588.jpg';
    document.querySelector('.settings__icon--img').setAttribute('src', defaultImage);
    document.querySelector('#icon_delete_hidden').setAttribute('name', "user[icon_delete_value]");
    document.getElementById("user_icon").value = "";
});