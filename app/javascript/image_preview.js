// \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\javascript\image_preview.js

document.getElementById('imageInput').addEventListener('change', function(event){
  const file = event.target.files[0];
  const reader = new FileReader();

  reader.onloadend = function() {
    document.getElementById('imagePreview').style.display = "block";
    document.getElementById('imagePreview').src = reader.result;
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    document.getElementById('imagePreview').src = "";
  }
});