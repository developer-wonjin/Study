function showPic(whichpic) {
    alert("HELLO");
    var source = whichpic.getAttribute("href");
    var placeholder = document.getElementById('placeholder');

    placeholder.setAttribute("src", source);

}