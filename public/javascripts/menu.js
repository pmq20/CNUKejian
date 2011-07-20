function openMenu(thisObj) {
   if (thisObj.name == "upimg") {
      thisObj.name = "downimg";
      thisObj.src = "/images/leftmenu/down.gif";
      thisObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.rows[1].cells[0].children[0].style.display = "none";
   } else {
      thisObj.name = "upimg";
      thisObj.src = "/images/leftmenu/up.gif";
      thisObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.rows[1].cells[0].children[0].style.display = "";
   }
}

function mouseOverFun(thisObj) {
   if (thisObj.name == "upimg") {
      thisObj.src = "/images/leftmenu/up-2.gif"
   } else {
      thisObj.src = "/images/leftmenu/down-2.gif"
   }
}
function mouseOutFun(thisObj) {
   if (thisObj.name == "upimg") {
      thisObj.src = "/images/leftmenu/up.gif"
   } else {
      thisObj.src = "/images/leftmenu/down.gif"
   }
}
function htmlToPlainStr(htmlStr){
  var result = htmlStr.replace("&amp;", "&");
  result = result.replace("&nbsp;", " ");
  result = result.replace("&nbsp;", " ");
  return result;
}
function getCurrentQu(){
	if(document.getElementById('div1').style.display != "none"){
		return "纵览";
	}else if(document.getElementById('div2').style.display != "none"){
		return "下载";
	}else if(document.getElementById('div3').style.display != "none"){
		return "上传";
	}else{
	  return "";
	}
}
function xiaochu(){
	 $('td.selected').removeClass('selected').addClass('default');
}
function select(obj) {
	 var selectTitle = htmlToPlainStr(obj.innerHTML);
	 parent.parent.document.title = "CNU课件交流系统" + " - " + selectTitle.split('[')[0];
	 xiaochu();
	 obj.parentNode.className="selected";
}
function turn_to_settings(){
	select(document.getElementById('da_setting'));
	window.parent.frames[0].eval('softChange(1)');
	window.parent.frames[3].location.href = '/cpan/profile';
}
function turn_to_history(){
	select(document.getElementById('da_history'));
	window.parent.frames[0].eval('softChange(1)');
	window.parent.frames[3].location.href = '/cpan/history';
}
