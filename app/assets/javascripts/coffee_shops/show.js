function handleImage(image) {
    let reader = new FileReader();
    reader.onload = function() {
      let imagePreview = document.getElementById("review-image-preview");
      imagePreview.src = reader.result;
      imagePreview.className += "img-fluid w-25";
    };
  reader.readAsDataURL(image[0]);
}