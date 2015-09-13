$("embed").each(function(i, n) {
    var flashvar = $(this).attr('flashvars');
    if (flashvar != null && flashvar != '' && (flashvar.indexOf('&uto_play=') != -1 || flashvar.indexOf('&age=') != -1)) {
        flashvar = flashvar.replace("&u=", "&vu=").replace("&uto_play=", "&auto_play=").replace("&pcflag=", "&gpcflag=").replace("&idth=", "&width=").replace("&eight=", "&height=").replace("&age=", "&page=");
        //$(this).attr("flashvars", flashvar);
        var embedid = new Date().getTime();
        $(this).attr("id", embedid);
        $(this).attr("flashvars", flashvar);
        try {
            document.getElementById(embedid).setAttribute("flashvars", flashvar);
        }
        catch (e) {
            $(this).attr("flashvars", flashvar);
        }
        document.getElementById(embedid).outerHTML = document.getElementById(embedid).outerHTML
    }
})
$("a").each(function(i, n) {
    var href = $(this).attr('href');
    if (href != null && href != '' && (href.indexOf('&uto_play=') != -1 || href.indexOf('&age=') != -1)) {
        href = href.replace("&u=", "&vu=").replace("&uto_play=", "&auto_play=").replace("&pcflag=", "&gpcflag=").replace("&idth=", "&width=480").replace("&eight=", "&height=").replace("&age=", "&page=");
        $(this).attr("href", href);
    }
})