function checkAll(str,checked) {
    var a = document.getElementsByName(str);
    var n = a.length;

    for (var i = 0; i < n; i++) {
        a[i].checked = checked;
    }
    em_size(str);
}

function download(str, i, first) {
    var a = document.getElementsByName(str);
    var n = a.length;

    for (var i = i; i < n; i++) {
        if(a[i].checked) {
            window.location=a[i].value;
            if (first)
                timeout = 6000;
            else
                timeout = 500;
            i++;
            window.setTimeout("download('"+str+"', "+i+", 0)", timeout);
            break;
        }
    }

}

function copy(str) {
    var a = document.getElementsByName(str);
    var n = a.length;
    var ed2kcopy = document.getElementById("ed2kcopy_"+str)
    ed2kcopy.innerHTML = ""
    for (var i = 0; i < n; i++) {
        if(a[i].checked)
        {
            ed2kcopy.innerHTML += a[i].value;
            ed2kcopy.innerHTML += "<br />";
        }
    }
        var rng = document.body.createTextRange();
        rng.moveToElementText(ed2kcopy)
        rng.scrollIntoView();
        rng.select();
        rng.execCommand("Copy");
        rng.collapse(false);
}

function em_size(str) {
    var a = document.getElementsByName(str);
    var n = a.length;
    try {
        var input_checkall = document.getElementById("checkall_"+str);
        var size = 0;
        input_checkall.checked = true ;
        for (var i=0; i < n; i++) {
            if (a[i].checked) {
                var piecesArray = a[i].value.split( "|" );
                size += piecesArray[3]*1;
            } else {
                input_checkall.checked = false;
            }
        }
        test = document.getElementById("size_"+str);
        test.innerHTML = gen_size(size, 3, 2);
    } catch (e) {

    }
}

function gen_size(val, li, sepa ) {
    sep = Math.pow(10, sepa); //小数点后的位数
    li = Math.pow(10, li); //开始截断的长度
    retval  = val;
    unit    = 'Bytes';
    if (val >= li*1000000000) {
        val = Math.round( val / (1099511627776/sep) ) / sep;
        unit  = 'TB';
    } else if (val >= li*1000000) {
        val = Math.round( val / (1073741824/sep) ) / sep;
        unit  = 'GB';
    } else if (val >= li*1000) {
        val = Math.round( val / (1048576/sep) ) / sep;
        unit  = 'MB';
    } else if (val >= li) {
        val = Math.round( val / (1024/sep) ) / sep;
        unit  = 'KB';
    }
    return val + unit;
}
