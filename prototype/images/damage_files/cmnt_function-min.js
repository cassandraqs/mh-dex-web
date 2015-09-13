
function params(location){var url=new String(location);var pos1=url.indexOf("?");if(pos1==-1){return"";}
var pos2=url.lastIndexOf("#");if(pos2!=-1){url=url.substr(0,pos2);}
return url.substr(pos1+1);}
function cgi_param(params,name){if(params==""||name==""){return"";}
var pos1=params.indexOf(name+"=");if(pos1==-1){return"";}
var pos2=params.indexOf("&",pos1);if(pos2==-1){pos2=params.length;}
if(is_ie()){return unescape(params.substring(pos1+name.length+1,pos2));}else{return(params.substring(pos1+name.length+1,pos2));}}
function getUrlParam(name){var reg=new RegExp("(^|&)"+name+"=([^&]*)(&|$)");var r=window.location.search.substr(1).match(reg);if(r!=null){return unescape(r[2]);return null;}}
function set_cookie(name,value,expires,path,domain){var cookie_temp;var now_time=new Date();if(expires!=undefined&&expires!=""){now_time.setTime(now_time.getTime()+(expires*60*1000));cookie_temp=(name+"="+value+";expires="+now_time.toGMTString());}else{cookie_temp=(name+"="+value);}
if(path!=undefined&&path!=""){cookie_temp=cookie_temp+(";path="+path);}
if(domain!=undefined&&domain!=""){cookie_temp=cookie_temp+(";domain="+domain);}
document.cookie=cookie_temp;}
function get_cookie(cookie){var cookies=document.cookie;var clist=cookies.split(";");for(var i=0;i<clist.length;++i){var cpair=clist[i].split("=");if(trim(cpair[0])==cookie){return unescape(trim(cpair[1]));}}
return"";}
function obj(id,doc){if(id==""){return null}
if(doc==undefined||doc==""){return document.getElementById(id);}else{return doc.getElementById(id);}}
function tag_objs(tag,name){if(tag==""||name==""){return null;}
var elem=document.getElementsByTagName(tag);var list=new Array();for(i=0,iarr=0;i<elem.length;++i){var att=elem[i].getAttribute("name");if(att==name){list[iarr]=elem[i];++iarr;}}
return list;}
function obj_attr(obj,attr){if(obj==null){return"";}
return obj.getAttribute(attr)}
function obj_attrs(obj){if(obj==null){return 0;}
var c=0;for(attr in obj){if(obj[attr]!=""){++c;}}
return c;}
function show_obj(obj,style){if(obj==null){return;}
if(style!=undefined){obj.style.display=style;}else{obj.style.display="";}}
function hide_obj(obj){if(obj==null){return;}
obj.style.display="none";}
function is_show(obj){if(obj==null){return false;}
if(obj.style.display!="none"){return true;}else{return false;}}
function parse_int(i,default_value){i=parseInt(i);if(!isNaN(i)){return i}
if(default_value!=undefined&&!isNaN(default_value)){return default_value;}
return 0}
function parse_str(str){if(str==undefined){return"";}else{return str;}}
function strlen(str){if(str==null||str==""){return 0;}
var newstr=new String(str);return newstr.length}
function trim(s){if(s==null||s==""){return"";}
var Str=new String(s);var newstr=Str.replace(/^\s*/,"");return(newstr.replace(/\s*$/,""));}
function xmlhttp_syn(url,param,callback){if(url==""||url==null){return false;}
param+="&t="+Math.random();$.ajax({type:"Post",async:false,url:url,timeout:10000,error:function(){alert("系统繁忙，请稍候再试。");},data:param,success:function(reslut){callback(reslut);}});}
function xmlhttp_asyn(url,param,callback){if(url==""||url==null){return false;}
param+="&t="+Math.random();$.ajax({type:"Post",async:true,url:url,timeout:10000,error:function(){alert("系统繁忙，请稍候再试。");},data:param,success:function(reslut){callback(reslut);}});}
function substr(str,len){if(str==null||str==""){return"";}
var buf=new String(str);return(str.substr(0,len));}
function _splitnum(i){var str=String(i);var pp=0;if(str.indexOf(",")>0){pp=str.indexOf(",");}else if(str.indexOf(".")>0){pp=str.indexOf(".");}else{pp=str.length;}
pp=pp-3;if(pp<=0){return str;}
var s=str.substring(0,pp);var e=str.substring(pp);var str1=s+","+e;return _splitnum(str1);}
function split_number(i){if(i>10000){return _splitnum(i);}else{return i;}}
function len(s){var l=0;var a=s.split("");for(var i=0;i<a.length;i++){if(a[i].charCodeAt(0)<299){l++;}else{l+=2;}}
return l;}
function escape_xml(str,ret_len){if(str==undefined||str==""){return"";}
if(ret_len==undefined||ret_len==null){ret_len=DEFAULT_RETLEN;}
str=strip_enter(str);str=force_return(str,ret_len);str=str.replace(/\t/g,"&nbsp;&nbsp;&nbsp;&nbsp;");str=str.replace(/\n/g,"<br>");str=str.replace(/&lt;\?/g,"");str=str.replace(/&lt;\!/g,"");str=str.replace(/<\?/g,"");str=str.replace(/<\!/g,"");str=str.replace(/&lt;b&gt;/g,"<b>");str=str.replace(/&lt;\/b&gt;/g,"</b>");str=str.replace(/&lt;/g,"<");str=str.replace(/&gt;/g,">");return str;}
function force_return(str,ret_len){if(ret_len<=0){return str;}
var pos=0;var truncated="";for(var i=0;i<str.length;i++){var c=str.charAt(i);truncated+=c;pos++;if(c==" "||c=="\n"){pos=0;}else if(pos>=ret_len){pos=0;if(c=="，"||c=="!"){truncated+="\n";}else{truncated+=" ";}}}
return truncated;}
function strip_enter(str){var strip_str="";while(strip_str!=str){strip_str=str;str=strip_str.replace(/<br><br>/ig,"<br>");}
return str;}
function escape_title(title){if(title==undefined||title==""){return"";}
var escaped_tiele=title.replace(/\'/g,"＇");escaped_tiele=escaped_tiele.replace(/\"/g,"＂");escaped_tiele=escaped_tiele.replace(/[<]([^>]*)[>]/g,"");return escaped_tiele;}
function is_ie(){if(navigator.userAgent.toLowerCase().indexOf('msie')>=0){return true;}else{return false;}}
function is_mozilla(){if(navigator.userAgent.toLowerCase().indexOf('gecko')>=0){return true;}else{return false;}}
function is_opera(){if(navigator.userAgent.toLowerCase().indexOf('opera')>=0){return true;}else{return false;}}
function is_safari(){if(navigator.userAgent.toLowerCase().indexOf('safari')>=0){return true;}else{return false;}}
function datetime_now(){var now=new Date();var month=parse_int(now.getMonth()+1);if(month<10){month="0"+month;}
var date_val=now.getDate();if(date_val<10){date_val="0"+date_val;}
var datetime_string=now.getFullYear()+"-"+month+"-"+date_val+" "+now.toLocaleTimeString();return datetime_string;}
function do_jonp(url){url+="&t="+Math.random();var script=document.createElement('script');script.setAttribute('src',url);document.getElementsByTagName('head')[0].appendChild(script);}