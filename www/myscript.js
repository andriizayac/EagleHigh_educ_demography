window.onload = function () {
  var backgroundImg=["welcome/welcome_img1.png",
                    "welcome/welcome_img2.png",
                    "welcome/welcome_img3.png",
                    "welcome/welcome_img4.png",
                    "welcome/welcome_img5.png",
                    "welcome/welcome_img6.png"
                    ]
    
    setInterval(changeImage, 5000);
   function changeImage() {   
    var i = Math.floor((Math.random() * 5));
    
    document.getElementById("welcomebg").style.backgroundImage = "url('"+backgroundImg[i]+"')";
    
  }
}
