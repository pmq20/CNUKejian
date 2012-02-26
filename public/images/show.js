var bgcolor='#ffffff';var titlecolor='#6699ff';var bordercolor='#6699ff';tPopWait=0;tPopShow=5000;showPopStep=1000;popOpacity=100;sPop=null;curShow=null;tFadeOut=null;tFadeIn=null;tFadeWaiting=null;
document.write("<style type='text/css'id='defaultPopstyle'>");
document.write(".cPopText {  background-color: "+bgcolor+";color:"+titlecolor+"; border: 1px "+bordercolor+"  solid;font-color: font-size: 12px; padding-right: 4px; padding-left: 5px; height: 20px; padding-top: 2px; padding-bottom:  2px; filter: Alpha(Opacity=0)}");
document.write("</style>");
document.write("<div id='dypopLayer' style='position:absolute;'  class='cPopText'></div>");
function showPopupText(){var o=window.event.srcElement;MouseX=event.x;MouseY=event.y;
if(o.atta!=null && o.atta!=""){
o.dypop=o.atta;
o.atta="";
}
if(o.dypop!=sPop) {sPop=o.dypop;clearTimeout(curShow);clearTimeout(tFadeOut);clearTimeout(tFadeIn);clearTimeout(tFadeWaiting);
if(sPop==null || sPop=="") {dypopLayer.innerHTML="";dypopLayer.style.filter="Alpha()";dypopLayer.filters.Alpha.opacity=0;}
else {
if(o.dyclass!=null) popstyle=o.dyclass 
else popstyle="cPopText";
curShow=setTimeout("showIt()",tPopWait);
}}}
function showIt(){
dypopLayer.className=popstyle;dypopLayer.innerHTML=sPop;popWidth=dypopLayer.clientWidth;popHeight=dypopLayer.clientHeight;
if(MouseX+12+popWidth>document.body.clientWidth) popLeftAdjust=-popWidth-24
else  popLeftAdjust=0;
if(MouseY+12+popHeight>document.body.clientHeight) popTopAdjust=-popHeight-24
else popTopAdjust=0;
dypopLayer.style.left=MouseX+12+document.body.scrollLeft+popLeftAdjust;dypopLayer.style.top=MouseY+12+document.body.scrollTop+popTopAdjust;dypopLayer.style.filter="Alpha(Opacity=0)";fadeOut();
}
function fadeOut(){
if(dypopLayer.filters.Alpha.opacity<popOpacity) {dypopLayer.filters.Alpha.opacity+=showPopStep;tFadeOut=setTimeout("fadeOut()",1);} else {dypopLayer.filters.Alpha.opacity=popOpacity;tFadeWaiting=setTimeout("fadeIn()",tPopShow);}
}
function fadeIn(){if(dypopLayer.filters.Alpha.opacity>0){dypopLayer.filters.Alpha.opacity-=1;tFadeIn=setTimeout("fadeIn()",1);}}
document.onmouseover=showPopupText;
