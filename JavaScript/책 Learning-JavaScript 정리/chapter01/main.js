$(document).ready(function(){
    'use strict';
    paper.install(window);//Paper.js를 전역스코프에 설치
    paper.setup(document.getElementById('mainCanvas'));//canvas와 paper연결
    //TODO
      /*
        바둑판 원그리기
        var c;
        for(var x=25;x<400;x+=50){
            for(var y=25;y<400;y+=50){
                c = Shape.Circle(x,y,20);
                c.fillColor='yellow';
            }
        } 
   */

   var c = Shape.Circle(200,200,80);
   c.fillColor = 'black';
   
   var text = new PointText(200,200);
   text.justification = 'center';
   text.fillColor = 'white';
   text.fontSize = 20;
   text.content = 'hello world';

    var tool = new Tool();//Tool객체를 통해 이벤트 핸들로 등록가능함
    //이벤트 핸들로 등록
    tool.onMouseDown = function(event){
       // var c = Shape.Circle(event.point.x,event.point.y,20);
       var c = Shape.Circle(event.point,20);
        c.fillColor = 'green';
    };



    

    paper.view.draw();
    // console.log('Jquery main.js is loaded');
});