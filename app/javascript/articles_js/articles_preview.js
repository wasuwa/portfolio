// 画像アップロード時のプレビュー機能
window.addEventListener('load', () => {
  const uploader = document.querySelector('.article_posting__form--img_select');
  uploader.addEventListener('change', (e) => {
    const file = uploader.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      const image = reader.result;
      document.querySelector('.article_posting__form--img').setAttribute('src', image);
    }
  });
});

// プレビュー機能から画像を削除する
const delete_button = document.getElementById("delete_button");
delete_button.addEventListener('click', function () {
  const defaultImage = '/assets/article_details_no_img-5387121c74cac5b563ed76a405038049fb52f825d40c1876fbaa1cc32d621c2b.jpg';
  document.querySelector('.article_posting__form--img').setAttribute('src', defaultImage);
  document.querySelector('#delete_hidden').setAttribute('name', "article[image_delete_value]");
  document.getElementById("article_image").value = "";
});