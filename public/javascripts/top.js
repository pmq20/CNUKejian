function softChange(n){
	$('#td_'+n).removeClass('btn'+n);
	$('#td_'+n).addClass('bg'+n);
	
	var i;
	for(i=1;i<=3;++i){
		if(i!=n){
			$('#td_'+i).removeClass('bg'+i);
			$('#td_'+i).addClass('btn'+i);
			$('#topMenu3').removeClass('bg-line'+i);
			window.parent.frames[1].document.getElementById('div'+i).style.display = "none";
		}
	}
	
	$('#topMenu3').addClass('bg-line'+n);
	window.parent.frames[1].document.getElementById('div'+n).style.display = "block";
}
function changeModule(n){
	softChange(n);
	window.parent.frames[1].eval('xiaochu()')
	window.parent.frames[1].eval('select(document.getElementById("div'+n+'_first"))')
	window.parent.frames[1].document.getElementById('div'+n+'_first').parentNode.className = "selected";
	var new_location;
	switch(n){
		case 1:new_location='/welcome/main';break;
		case 2:new_location='/welcome/download_go';break;
		case 3:new_location='/welcome/upload_go';break;
	}
	window.parent.frames[3].location.href = new_location;
}


