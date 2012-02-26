function Adv(){
var nowTime = new Date();
var BasePath = IsRoot ? "" : "../";
bust = Math.floor(1000000*Math.random());
if(arguments.length>2){
sImg=arguments[3];
if (document.all)document.write("<div id=waiting style=position:absolute;top:0px;left:0px;z-index:1;visibility:hidden>");
else document.write("<layer name=waiting top=0 left=0 visibility=hide zIndex=2>");
document.write("<table border=2 cellspacing=1 cellpadding=0 bordercolorlight=#FFFFFF bordercolordark=#C0C0C0 bgcolor=#E0E0E0><tr><td bgcolor=#E0E0E0>"+sImg+"</td></tr><tr><td bgcolor=#E0E0E0>");
if(document.all)document.write("<img src=images/space.gif width=1 height=10 name=sbar style=background-color:#6699cc></td></tr></table></div>");
else {
document.write("<img src=images/space.gif width=1 height=10></td></tr></table></layer>");
document.write("<layer name=rating top=0 left=0 visiblity=hide zIndex=1 bgcolor=#6699CC height=10></layer>");
}
window.onerror = null;
bwidth = 0;
if (document.all) swidth = document.all.waiting.clientWidth;
else swidth = document.waiting.clip.width;
if (arguments[0].search("http://")==0){
if(document.all) document.write("<IFRAME STYLE=\"z-index:1\" WIDTH=468 HEIGHT=60 MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0 VSPACE=0 FRAMEBORDER=0 SCROLLING=no SRC="+arguments[0]+"&number="+nowTime.getTime()+bust+"><\/IFRAME>");
else document.write("<SC"+"RIPT LANGUAGE=JavaScript SRC="+arguments[1]+"&number="+nowTime.getTime()+bust+"></SC"+"RIPT></td>");}
else document.write(arguments[0]);
if (arguments.length>4){
}
}
else{
if(document.all)document.onclick = CheckClick;
else{
window.captureEvents(Event.MOUSEUP|Event.MOUSEDOWN);
window.onmousedown = CheckClick;}
}
eval(AutoRegStr);
}
function CheckClick(e){
if (e == 1){
if (bwidth<swidth*0.98){
bwidth += (swidth - bwidth) * 0.025;
if (document.all)document.sbar.width = bwidth;
else document.rating.clip.width = bwidth;
setTimeout('CheckClick(1);',150);}
}
else{
if(document.all){
if(document.all.waiting.style.visibility == 'visible')
{document.all.waiting.style.visibility = 'hidden';
bwidth = 1;}
whichIt = event.srcElement;
while (whichIt.tagName != "A") {
whichIt = whichIt.parentElement;
if (whichIt == null)return true;
}
if(whichIt.href.substring(0,5)=="http:"){
document.all.waiting.style.pixelTop = (document.body.offsetHeight - document.all.waiting.clientHeight) / 2 + document.body.scrollTop;
document.all.waiting.style.pixelLeft = (document.body.offsetWidth - document.all.waiting.clientWidth) / 2 + document.body.scrollLeft;
document.all.waiting.style.visibility = 'visible';
if(!bwidth)CheckClick(1);
bwidth = 1;}
}
else{
if(document.waiting.visibility == 'show')
{document.waiting.visibility = 'hide';
document.rating.visibility = 'hide';
bwidth = 1;}
if(e.target.href.toString() != ''){
document.waiting.top = (window.innerHeight - document.waiting.clip.height) / 2 + self.pageYOffset;
document.waiting.left = (window.innerWidth - document.waiting.clip.width) / 2 + self.pageXOffset;
document.waiting.visibility = 'show';
document.rating.top = (window.innerHeight - document.waiting.clip.height) / 2 + self.pageYOffset+document.waiting.clip.height-10;
document.rating.left = (window.innerWidth - document.waiting.clip.width) / 2 + self.pageXOffset;
document.rating.visibility = 'show';
if(!bwidth)CheckClick(1);
bwidth = 1;
}}
return true;
}}
var AutoRegStr="";
var IsRoot = false;
