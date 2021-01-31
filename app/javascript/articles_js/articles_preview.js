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