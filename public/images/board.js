function addSenToEventHandle(EHObj,insSen){
var preSen;
if (EHObj!=null){preSen=EHObj.toString();}else{preSen="";} 
var reg=/^(function +[\w|\$|\.]+ *\([\w|\$|\,|\.]*\) *\{)([\W|\w]*)(\})$/;var preBody=preSen.replace(reg,"$2");var newFunObj=new Function(preBody+insSen);return newFunObj; 
} 
function getCookieVal(offset){var endstr=document.cookie.indexOf (";",offset);if (endstr==-1) endstr=document.cookie.length;return unescape(document.cookie.substring(offset,endstr));} 
function GetCookie(name){var arg=name+"=";var alen=arg.length;var clen=document.cookie.length;var i=0;while (i<clen){var j=i+alen;if (document.cookie.substring(i,j)==arg) return getCookieVal(j);i=document.cookie.indexOf(" ",i)+1;if(i==0) break;} return null;} 
function DeleteCookie(name){var exp=new Date();exp.setTime (exp.getTime()-1);var cval=GetCookie (name);document.cookie=name+"="+cval+"; expires="+exp.toGMTString();}
var currentpos,timer; 
function initialize(){timer=setInterval("scrollwindow()",10);} 
function sc(){clearInterval(timer);}
function scrollwindow(){currentpos=document.body.scrollTop;window.scroll(0,++currentpos);if (currentpos != document.body.scrollTop) sc();} 
document.onmousedown=sc
document.ondblclick=initialize
ie = (document.all)?true:false
clckcnt=0;clckcnt1=0;
if (ie){function ctlent(eventobject){if(event.ctrlKey && window.event.keyCode==13){if(clckcntr()){copyyes();this.document.FORM.submit();}}if(event.ctrlKey && window.event.keyCode==83){if(clckcntr()){copyyes();this.document.FORM.submit();}}}}
if (ie){function ctlent1(eventobject){if(event.ctrlKey && window.event.keyCode==13){if(clckcntr1()){copyyes1();this.document.FORM1.submit();}}if(event.ctrlKey && window.event.keyCode==83){if(clckcntr1()){copyyes1();this.document.FORM1.submit();}}}}
function copyyes(){var tempval=eval("document.FORM.inpost");tempval.focus();tempval.select();therange=tempval.createTextRange();therange.execCommand("Copy");}
function copyyes1(){var tempval=eval("document.FORM1.inpost");tempval.focus();tempval.select();therange=tempval.createTextRange();therange.execCommand("Copy");}
function clckcntr() {clckcnt++;if(clckcnt > 1){alert('贴子已经发出了......\n\n'+'请等待片刻......\n\n'+'不要重复按提交键，谢谢！');return false;}else{copyyes();}return true;}
function clckcntr1() {clckcnt1++;if(clckcnt1 > 1){alert('贴子已经发出了......\n\n'+'请等待片刻......\n\n'+'不要重复按提交键，谢谢！');return false;}else{copyyes1();}return true;}
var nn= !!document.layers;var ie= !!document.all;
if (nn){netscape.security.PrivilegeManager.enablePrivilege("UniversalSystemClipboardAccess");  var fr=new java.awt.Frame();var Zwischenablage=fr.getToolkit().getSystemClipboard();}
function copy(textarea){if (nn){textarea.select();Zwischenablage.setContents(new java.awt.datatransfer.StringSelection(textarea.value), null);} else if (ie){textarea.select();cbBuffer=textarea.createTextRange();cbBuffer.execCommand('Copy');}}
function paste(textarea){ if (nn){var Inhalt=Zwischenablage.getContents(null); if (Inhalt!=null) textarea.value=Inhalt.getTransferData(java.awt.datatransfer.DataFlavor.stringFlavor);} else if (ie) {textarea.select();cbBuffer=textarea.createTextRange();cbBuffer.execCommand('Paste');}}
function openScript(url,width,height){var Win = window.open(url,"openScript",'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=yes,status=yes');}
function runEx(){var winEx = window.open("", "winEx", "width=300,height=200,status=yes,menubar=yes,scrollbars=yes,resizable=yes");winEx.document.open("text/html", "replace");winEx.document.write(unescape(event.srcElement.parentElement.children[2].value)); winEx.document.close();}
function saveCode() {var winEx = window.open("", "winEx", "width=300,height=200,status=yes,menubar=yes,scrollbars=yes,resizable=yes");winEx.document.open('text/html', 'replace');winEx.document.write(unescape(event.srcElement.parentElement.children[2].value)); winEx.document.execCommand('saveas','','code.htm');winEx.close();}
var _Num=1;
function Face_Info(face,ImgURL){
var showArray=face.split('-');var s="";
document.write("<DIV id=SHOW"+_Num+" style='padding:0;position:relative;top:0;left:0;width:140;height:226' title=论坛虚拟形象></DIV>");
for (var i=0; i<=25; i++){if(showArray[i] != '0'){s+="<IMG src="+ImgURL+"/face/"+i+"/"+showArray[i]+".gif style='padding:0;position:absolute;top:0;left:0;width:140;height:226;z-index:"+i+";'>";}}
s+="<IMG src="+ImgURL+"/face/blank.gif style='padding:0;position:absolute;top:0;left:0;width:140;height:226;z-index:50;'>";
var _FACE=document.getElementById("SHOW"+_Num);_FACE.innerHTML=s;_Num++;
}
var menuOffX=0;var menuOffY=18;var linkset=new Array()
linkset[0]='<div class=menuitems>&nbsp;<span style=cursor:hand onClick=javascript:openScript("messanger.cgi?action=inbox",600,400) title=悄悄话短讯息中心，和站内的朋友进行联络>短讯中心</span>&nbsp;</div><div class=menuitems>&nbsp;<a href=calendar.cgi title=查看论坛月历和特别事件记录><font color=#000000>论坛月历</font></a>&nbsp;</div><div class=menuitems>&nbsp;<a href=ebank.cgi title=把多余的钱存起来哦><font color=#000000>论坛银行</font></a>&nbsp;</div><div class=menuitems>&nbsp;<a href=face.cgi title=好好打扮自己，设置丰富多彩的个人形象><font color=#000000>虚拟形象</font></a>&nbsp;</div><div class=menuitems>&nbsp;<a href=ftp.cgi title="联盟 FTP 服务器的查看和购买"><font color=#000000>FTP 联盟</font></a>&nbsp;</div><div class=menuitems>&nbsp;<a href=soccer.cgi title="体育博采"><font color=#000000>体育博采</font></a>&nbsp;</div>'
var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1;var ns6=document.getElementById&&!document.all;var ns4=document.layers
function showmenu(e,which){
if (!document.all&&!document.getElementById&&!document.layers)
return
clearhidemenu()
menuobj=ie4? document.all.popmenu:ns6? document.getElementById("popmenu"):ns4? document.popmenu:""
menuobj.thestyle=(ie4||ns6)? menuobj.style:menuobj
if (ie4||ns6)
menuobj.innerHTML=which
else{
menuobj.document.write('<layer name=gui bgColor=#E6E6E6 width=165 onmouseover=clearhidemenu() onmouseout=hidemenu()>'+which+'</layer>')
menuobj.document.close()
}
menuobj.contentwidth=(ie4||ns6)? menuobj.offsetWidth:menuobj.document.gui.document.width
menuobj.contentheight=(ie4||ns6)? menuobj.offsetHeight:menuobj.document.gui.document.height
eventX=ie4? event.clientX:ns6? e.clientX:E.x
eventY=ie4? event.clientY:ns6? e.clientY:E.y
var rightedge=ie4? document.body.clientWidth-eventX:window.innerWidth-eventX
var bottomedge=ie4? document.body.clientHeight-eventY:window.innerHeight-eventY
if (rightedge<menuobj.contentwidth)
menuobj.thestyle.left=ie4? document.body.scrollLeft+eventX-menuobj.contentwidth+menuOffX:ns6? window.pageXOffset+eventX-menuobj.contentwidth:eventX-menuobj.contentwidth
else
menuobj.thestyle.left=ie4? ie_x(event.srcElement)+menuOffX:ns6? window.pageXOffset+eventX:eventX
if (bottomedge<menuobj.contentheight && bottomedge<350)
menuobj.thestyle.top=ie4? document.body.scrollTop+eventY-menuobj.contentheight-event.offsetY+menuOffY-23:ns6? window.pageYOffset+eventY-menuobj.contentheight-10:eventY-menuobj.contentheight
else
menuobj.thestyle.top=ie4? ie_y(event.srcElement)+menuOffY:ns6? window.pageYOffset+eventY+10:eventY
menuobj.thestyle.visibility="visible"
return false
}
function ie_y(e){
var t=e.offsetTop;
while(e=e.offsetParent){t+=e.offsetTop;}
return t;
}
function ie_x(e){
var l=e.offsetLeft;
while(e=e.offsetParent){l+=e.offsetLeft;}
return l;
}
function contains_ns6(a,b){
while (b.parentNode)
if ((b=b.parentNode)==a)
return true;
return false;
}
function hidemenu(){
if (window.menuobj)
menuobj.thestyle.visibility=(ie4||ns6)? "hidden":"hide"
}
function dynamichide(e){
if (ie4&&!menuobj.contains(e.toElement))
hidemenu()
else if (ns6&&e.currentTarget!=E.relatedTarget&& !contains_ns6(e.currentTarget,e.relatedTarget))
hidemenu()
}
function delayhidemenu(){
if (ie4||ns6||ns4)
delayhide=setTimeout("hidemenu()",500)
}
function clearhidemenu(){
if (window.delayhide)
clearTimeout(delayhide)
}
function highlightmenu(e,state){
if (document.all)
source_el=event.srcElement
else if(document.getElementById)
source_el=e.target
if (source_el.className=="menuitems"){
source_el.id=(state=="on")? "mouseoverstyle":""
}
else{
while(source_el.id!="popmenu"){
source_el=document.getElementById? source_el.parentNode:source_el.parentElement
if (source_el.className=="menuitems"){
source_el.id=(state=="on")? "mouseoverstyle":""
}}}}
if (ie4||ns6)
document.onclick=hidemenu
var flashlinks=new Array()
function changelinkcolor(){
for (i=0;i<flashlinks.length;i++){
var flashtype=document.getElementById? flashlinks[i].getAttribute("flashtype")*1:flashlinks[i].flashtype*1
var flashcolor=document.getElementById? flashlinks[i].getAttribute("flashcolor"):flashlinks[i].flashcolor
if (flashtype==0){
if (flashlinks[i].style.color!=flashcolor)
flashlinks[i].style.color=flashcolor
else
flashlinks[i].style.color='#cccccc'
}
else if (flashtype==1){
if (flashlinks[i].style.backgroundColor!=flashcolor)
flashlinks[i].style.backgroundColor=flashcolor
else
flashlinks[i].style.backgroundColor=''
}}}
function init(){
var i=0
if (document.all){
while (eval("document.all.flashlink"+i)!=null){
flashlinks[i]= eval("document.all.flashlink"+i)
i++
}}
else if (document.getElementById){
while (document.getElementById("flashlink"+i)!=null){
flashlinks[i]= document.getElementById("flashlink"+i)
i++
}}
setInterval("changelinkcolor()", 800)
}
if (window.addEventListener)
window.addEventListener("load",init,false)
else if (window.attachEvent)
window.attachEvent("onload",init)
else if (document.all)
window.onload=addSenToEventHandle(window.onload,"init();")
function ConFONT(obj,url,type){
var SCoolZi = new Array(/啊/g,/哎/g,/唉/g,/吧/g,/北/g,/扁/g,/不/g,/大/g,/的/g,/\.\.\./g,/东/g,/多/g,/嗯/g,/发/g,/髮/g,/反/g,/肥/g,/!/g,/！/g,/弓/g,/哈/g,/好/g,/呵/g,/火/g,/金/g,/了/g,/爱/g,/吗/g,/嗎/g,/么/g,/麽/g,/木/g,/南/g,/呢/g,/你/g,/妳/g,/哦/g,/偶/g,/胖/g,/上/g,/什/g,/是/g,/爽/g,/水/g,/谁/g,/雖/g,/她/g,/他/g,/土/g,/？/g,/我/g,/西/g,/下/g,/小/g,/心/g,/右/g,/正/g,/猪/g,/中/g,/左/g,/想/g,/倒/g,/机/g,/家/g,/靠/g,/哭/g,/们/g,/乃/g,/哇/g);
var CCoolZi = new Array("啊","哎","唉","吧","北","扁","不","大","的","...","东","多","嗯","发","髮","反","肥","!","！","东","哈","好","呵","火","金","了","爱","吗","嗎","么","麽","木","南","呢","你","妳","哦","偶","胖","上","什","是","爽","水","谁","雖","她","他","土","？","我","西","下","小","心","右","正","猪","中","左","想","倒","机","家","靠","哭","们","乃","哇");
var DCoolZi = new Array("a","ai","ai2","ba","bei","bian","bu","da","de","dian","dong","duo","en","fa","fa","fang","fei","gant","gant","gong","ha","hao","he","huo","jin","liao","love","ma","ma","me","me","mu","nan","ne","ni","ni","oo","ou","pang","shang","shen","shi","shuang","shui","shui2","shui2","ta","ta2","tu","wen","wo","xi","xia","xiao","xin","you","zeng","zhu","zong","zuo","xiang","dao","ji","jia","kao","ku","men","nai","wa");
var _CA = eval("CArea" + obj);
var _old = _CA.innerHTML;
var _CB = eval("OArea" + obj);
if(type == 1){
if(_old.length > 2000){
if (!(confirm("友情提醒：内容太长！\n\n贴子显示方式：表情模式\n\n因本模式是在本地机器运行，如果您的电脑配置过低，建议取消。\n\n您是否确认工作于 表情模式 ？"))) {_CB.innerHTML = "<span style=cursor:hand onClick=ConFONT('"+obj+"','"+url+"','1') title=切换到表情模式><img src="+url+"/font/mode2.gif border=0 height=15 align=absmiddle>表情</span>";return;}
}
for(j=0;j<SCoolZi.length;j++){_old=_old.replace(SCoolZi[j],"<img src="+url+"/font/"+DCoolZi[j]+".gif title='"+CCoolZi[j]+"'>");}
_CB.innerHTML = "<span style=cursor:hand onClick=ConFONT('"+obj+"','"+url+"','0') title=切换到正常模式><IMG src="+url+"/font/mode1.gif border=0 height=15 align=absmiddle>正常</span>";
}
else{
var _CC = eval("_old" + obj);_old = _CC;_CB.innerHTML = "<span style=cursor:hand onClick=ConFONT('"+obj+"','"+url+"','1') title=切换到表情模式><img src="+url+"/font/mode2.gif border=0 height=15 align=absmiddle>表情</span>";
}
_CA.innerHTML = _old;
}
function SymError(){ return true;}
window.onerror = SymError;
