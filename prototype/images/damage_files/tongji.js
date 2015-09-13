function getExpDate(days, hours, minutes)
{
	var expDate = new Date();
	if(typeof(days) == "number" && typeof(hours) == "number" && typeof(hours) == "number")
	{
		expDate.setDate(expDate.getDate() + parseInt(days));
		expDate.setHours(expDate.getHours() + parseInt(hours));
		expDate.setMinutes(expDate.getMinutes() + parseInt(minutes));
		return expDate.toGMTString();
	}
}

function getCookieVal(offset)
{
	var endstr = document.cookie.indexOf(";", offset);
	if(endstr == -1)
	{
		endstr = document.cookie.length;
	}
	return unescape(document.cookie.substring(offset, endstr));
}

function getCookie(name)
{
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while(i < clen)
	{
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
		{
			return getCookieVal(j);
		}
		i = document.cookie.indexOf(" ", i) + 1;
		if(i == 0) break;
	}
	return;
}

function setCookie(name, value, expires, path, domain, secure)
{
	document.cookie = name + "=" + escape(value) +
		((expires) ? "; expires=" + expires : "") +
		((path) ? "; path=" + path : "") +
		((domain) ? "; domain=" + domain : "") +
		((secure) ? "; secure" : "");
}

function deleteCookie(name, path, domain)
{
	if(getCookie(name))
	{
		document.cookie = name + "=" +
			((path) ? "; path=" + path : "") +
			((domain) ? "; domain=" + domain : "") +
			"; expires=Thu, 01-Jan-70 00:00:01 GMT";
	}
}

function tongji(id) {
	id = id.toLowerCase();
	if(id.indexOf("psp") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30018224\"><\/script>");
	if(id.indexOf("psv") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30042495\"><\/script>");
	if(id.indexOf("nds") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30018225\"><\/script>");
	if(id.indexOf("3ds") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30031986\"><\/script>");
	if(id.indexOf("ps3") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30018226\"><\/script>");
	if(id.indexOf("wii") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30018227\"><\/script>");
	if(id.indexOf("360") > -1) document.writeln("<script language=\"javascript\" src=\"http:\/\/w.cnzz.com\/c.php?id=30018228\"><\/script>");
}

cid = "";
var metaobj = document.getElementsByTagName('meta');
for(i = 0; i < metaobj.length; i++) {
	if(metaobj[i].name != null) {
		if(metaobj[i].name.toLowerCase() == "keywords") cid += "," + metaobj[i].content.toLowerCase();
		if(metaobj[i].name.toLowerCase() == "description") cid += "," + metaobj[i].content.toLowerCase();
	}
}
cid += "," + document.getElementsByTagName('title')[0].innerHTML;

var referrer = document.referrer.toLowerCase();
if(referrer.indexOf("psp.tgbus.com") > -1){ tongji("psp"); }
else if(referrer.indexOf("psv.tgbus.com") > -1){ tongji("psv"); }
else if(referrer.indexOf("nds.tgbus.com") > -1){ tongji("nds"); }
else if(referrer.indexOf("3ds.tgbus.com") > -1){ tongji("3ds"); }
else if(referrer.indexOf("ps3.tgbus.com") > -1){ tongji("ps3"); }
else if(referrer.indexOf("wii.tgbus.com") > -1){ tongji("wii"); }
else if(referrer.indexOf("xbox360.tgbus.com") > -1){ tongji("360"); }
else if(referrer.length > 0) { tongji(cid); }

