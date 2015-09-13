var g_user = new Object();
function post_message_login(post_form) {
    var content = post_form.content.value;
    if (content.length > 15000) {
        alert('评论内容不能多余15000字');
        return false;
    }
    if (content == "") {
        alert("请填写您的评论内容");
        return false;
    }

    else {
        var name = $(post_form).find("input[name=username]").attr("value");
        var pwd = $(post_form).find("input[name=pass]").attr("value");

        if (name == null) name = "";
        if (pwd == null) pwd = "";

        if (name != "" && pwd != "" && name !="匿名用户") {
            var url = V2_HOST + "/API/Login_News.aspx";
            var params = "&method=login&name=" + encodeURI(name) + "&pwd=" + pwd + "&callback=loginCallback";
            var script = document.createElement("script");
            script.type = "text/javascript";
            script.charset = "gb2312";
            script.src = url + "?" + params;
            $("head")[0].appendChild(script);
        }

        else {
            post_message();
        }
    }
}

function loginCallback(result) {
    if (result.split('|')[0] <= 0) {
        alert("用户名或密码错误请重新尝试登陆。");
        return false;
    }

    else {
        post_message();
        window.location.href = window.location.href;
    }
}

function post_message() {
    var post_form = document._POST_BOTTOM_;
    var Cmsg = new Object();
    Cmsg.m_channel = post_form.channel.value;
    Cmsg.m_newsid = post_form.newsid.value;
    Cmsg.m_content = post_form.content.value;
    Cmsg.m_user = post_form.user.value;
    Cmsg.m_rid = 0;
    Cmsg.format = "text";
    Cmsg.n_title = post_form.newstitle.value;
    if (Cmsg.m_content == "") {
        post_form.content.focus();
        alert("请填写您的评论内容");
        return false;
    }

    if (Cmsg.m_channel == "" || Cmsg.m_newsid == "") {
        Cmsg.m_channel = g_filter.channel;
        Cmsg.m_newsid = g_filter.newsid;
    }

    cmnt_post(Cmsg);
    post_form.content.value = "";
}

function cmnt_post(Cmsg) {
    if (Cmsg.m_channel == "" || Cmsg.m_newsid == "" || Cmsg.m_content == "") {
        alert('信息不全，请稍后再试。'); //调试代码
        return false;
    }

    if (obj("cmnt_post_span") == null) {
        var cmnt_post_span = document.createElement("span");
        cmnt_post_span.setAttribute("id", "cmnt_post_span");
        cmnt_post_span.setAttribute("style", "display:none");
        document.body.insertBefore(cmnt_post_span, null)
    }

    obj("cmnt_post_span").innerHTML = "<iframe name='cmnt_post_frame' style='display:none' width=0 height=0></iframe>"
        + "<form name='cmnt_post_form' action='" + V2_HOST + POST_CGI + "' method=post target='cmnt_post_frame'>"
        + "<input type=hidden name=anonymous value=1>"
        + "<input type=hidden name=channel>"
        + "<input type=hidden name=newsid>"
        + "<input type=hidden name=content>"
        + "<input type=hidden name=vote>"
        + "<input type=hidden name=qvote>"
        + "<input type=hidden name=rid>"
        + "<input type=hidden name=user>"
        + "<input type=hidden name=pass>"
        + "<input type=hidden name=config>"
        + "<input type=hidden name=newstitle>"
        + "<input type=hidden name=url>"
        + "<input type=hidden name=format>"
        + "<input type=hidden name=charset>" + "</form>";

    document.cmnt_post_form.channel.value = Cmsg.m_channel;
    document.cmnt_post_form.newsid.value = Cmsg.m_newsid;
    document.cmnt_post_form.content.value = encodeURI(Cmsg.m_content);
    document.cmnt_post_form.vote.value = Cmsg.m_vote;
    document.cmnt_post_form.qvote.value = parse_int(Cmsg.m_qvote);
    document.cmnt_post_form.rid.value = parse_int(Cmsg.m_rid);
    document.cmnt_post_form.user.value = encodeURI(parse_str(Cmsg.m_user));
    document.cmnt_post_form.pass.value = parse_str(Cmsg.m_pass);
    document.cmnt_post_form.config.value = parse_str(Cmsg.m_config);
    document.cmnt_post_form.newstitle.value = "";
    document.cmnt_post_form.url.value = parse_str(Cmsg.n_url);
    document.cmnt_post_form.format.value = parse_str(Cmsg.format);
    document.cmnt_post_form.charset.value = parse_str(Cmsg.charset);
    document.cmnt_post_form.submit();
    if (typeof commentExt == "function") { commentExt(Cmsg.m_channel, Cmsg.m_newsid); }
    alert('评论发表成功，请等待审核。');
}
function clean() {
    if (document.getElementById("username").value == "匿名用户")
        document.getElementById("username").value = "";
}
function cleanpass() {
    if (document.getElementById("password").value == "000000")
        document.getElementById("password").value = "";
}