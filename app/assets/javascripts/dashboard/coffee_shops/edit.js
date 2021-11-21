function handleImage(image) {
    let reader = new FileReader();
    reader.onload = function() {
      let imagePreview = document.getElementById("image-preview");
      imagePreview.src = reader.result;
      imagePreview.className += "img-fluid w-25";
    };
  reader.readAsDataURL(image[0]);
}

// document.addEventListener('DOMContentLoaded', () => {
  
//   const ImageList = document.getElementById('new-image');
  
//   const createImageHTML = (blob) => {  
//     const imageElement = document.createElement('div');
//     imageElement.setAttribute('class', "image-element");
//     let imageElementNum = document.querySelectorAll('.image-element').length;
    
//     const blobImage = document.createElement('img'); 
//     blobImage.setAttribute('class', 'new-img'); 
//     blobImage.setAttribute('src', blob); 
    
//     const inputHTML = document.createElement('input');
//     inputHTML.setAttribute('id', `coffee_shop_images_${imageElementNum}`);
//     inputHTML.setAttribute('class', 'coffee_shop_images');
//     inputHTML.setAttribute('name', 'coffee_shop[images][]');
//     inputHTML.setAttribute('type', 'file');
    
//     imageElement.appendChild(blobImage);
//     if (imageElementNum < 2) {
//       imageElement.appendChild(inputHTML);
//     }
//     ImageList.appendChild(imageElement);
    
//     inputHTML.addEventListener('change', (e) => {
//       const file = e.target.files[0];
//       const blob = window.URL.createObjectURL(file);
//       createImageHTML(blob);
//     });
//   }; 
  
//   document.getElementById('coffee_shop_images').addEventListener('change', (e) =>{
    
//     const file = e.target.files[0];
//     const blob = window.URL.createObjectURL(file); 
//     createImageHTML(blob);
//   });
// });