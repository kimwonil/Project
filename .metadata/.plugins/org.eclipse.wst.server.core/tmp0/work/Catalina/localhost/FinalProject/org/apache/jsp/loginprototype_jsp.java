/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.44
 * Generated at: 2017-08-02 05:37:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class loginprototype_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js\" charset=\"utf-8\"></script>\r\n");
      out.write("<script src=\"//developers.kakao.com/sdk/js/kakao.min.js\"></script>\r\n");
      out.write("<script src=\"//ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js\" ></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"http://code.jquery.com/jquery-3.2.1.min.js\"></script>\r\n");
      out.write("<script src = \"https://plus.google.com/js/client:platform.js\" async defer></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\r\n");
      out.write("<meta name=\"viewport\" content=\"user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width\"/>\r\n");
      out.write("<meta name=\"google-signin-client_id\" content=\"427985089734-bhj7cddethlpgqgm0jqgh7i7071en55t.apps.googleusercontent.com\"></meta>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<title>이메일 주소로 로그인</title>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\"undefined\"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:\"50873\",secure:\"50882\"},c={nonSecure:\"http://\",secure:\"https://\"},r={nonSecure:\"127.0.0.1\",secure:\"gapdebug.local.genuitec.com\"},n=\"https:\"===window.location.protocol?\"secure\":\"nonSecure\";script=e.createElement(\"script\"),script.type=\"text/javascript\",script.async=!0,script.src=c[n]+r[n]+\":\"+t[n]+\"/codelive-assets/bundle.js\",e.getElementsByTagName(\"head\")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>\r\n");
      out.write("<body data-genuitec-lp-enabled=\"false\" data-genuitec-file-id=\"wc1-27\" data-genuitec-path=\"/FinalProject/WebContent/loginprototype.jsp\">\r\n");
      out.write("\r\n");
      out.write("<!--                        Login - Naver                         -->\r\n");
      out.write("\r\n");
      out.write("<!-- 네이버 로그인에 한해 로그인 작업을 끝내면\r\n");
      out.write("http://localhost:8080/FinalProject/printEmailN.jsp로 redirect 후 \r\n");
      out.write("해당 페이지에서 이메일주소가 출력됨\r\n");
      out.write("-->\r\n");
      out.write("<!-- 네이버 아이디로 로그인 버튼 -->\r\n");
      out.write("<div id=\"naver_id_login\" data-genuitec-lp-enabled=\"false\" data-genuitec-file-id=\"wc1-27\" data-genuitec-path=\"/FinalProject/WebContent/loginprototype.jsp\"></div>\r\n");
      out.write("<!-- 네이버 아이디로 로그인 버튼 -->\r\n");
      out.write("\r\n");
      out.write("<!-- 초기화 -->\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("//첫값은 키값(naver developer에서 받아와야 함) / 두번째 값은 redirect 주소값\r\n");
      out.write("\tvar naver_id_login = new naver_id_login(\"4hbqrclSjqpbsBAmXZy9\", \"http://localhost:8080/FinalProject/printEmailN.jsp\");\r\n");
      out.write("\tvar state = naver_id_login.getUniqState();\r\n");
      out.write("\tnaver_id_login.setButton(\"white\", 2,40);\r\n");
      out.write("\r\n");
      out.write("// 얘는 콜백도메인이랑 네아로 로그인 버튼 달린 페이지랑 도메인이 다를때 씀. https://developers.naver.com/docs/login/web/ 접근 토큰 요청 참조\r\n");
      out.write("\t//naver_id_login.setDomain(\".service.com\");\r\n");
      out.write("// 얘는 콜백도메인이랑 네아로 로그인 버튼 달린 페이지랑 도메인이 다를때 씀. https://developers.naver.com/docs/login/web/ 접근 토큰 요청 참조\r\n");
      out.write("\r\n");
      out.write("\tnaver_id_login.setState(state);\r\n");
      out.write("\t\r\n");
      out.write("\t//여기서부터 팝업설정\r\n");
      out.write("//\tnaver_id_login.setPopup();\r\n");
      out.write("\t//여기까지 팝업설정\r\n");
      out.write("\tnaver_id_login.init_naver_id_login();\r\n");
      out.write("\t\r\n");
      out.write("</script>\r\n");
      out.write("<!-- 초기화 -->\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("<!--                        Login - Naver                         -->\r\n");
      out.write("\r\n");
      out.write("<!--                        Login - Kakao                         -->\r\n");
      out.write("\r\n");
      out.write("<!-- 해당 주석처리된 코드는 kakao 로그인 성공시 토큰값을 반환하고 있음.-->\r\n");
      out.write("<!-- \r\n");
      out.write("<a id=\"custom-login-btn\" href=\"javascript:loginWithKakao()\">\r\n");
      out.write("<img src=\"//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg\" width=\"300\"/>\r\n");
      out.write("</a>\r\n");
      out.write("<script type='text/javascript'>\r\n");
      out.write("  //<![CDATA[\r\n");
      out.write("    // 사용할 앱의 JavaScript 키를 설정 : kakao developer 내부에서 설정\r\n");
      out.write("    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');\r\n");
      out.write("    function loginWithKakao() {\r\n");
      out.write("      // 로그인 창을 띄우고(팝업)\r\n");
      out.write("      Kakao.Auth.login({\r\n");
      out.write("        \r\n");
      out.write("    \t  //성공시 토큰정보 출력\r\n");
      out.write("    \t success: function(authObj) {\r\n");
      out.write("          alert(JSON.stringify(authObj));\r\n");
      out.write("          \r\n");
      out.write("        },\r\n");
      out.write("        fail: function(err) {\r\n");
      out.write("          alert(JSON.stringify(err));\r\n");
      out.write("        }\r\n");
      out.write("      });\r\n");
      out.write("    };\r\n");
      out.write("  //]]>\r\n");
      out.write("</script>\r\n");
      out.write(" -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" src=\"http://code.jquery.com/jquery-3.2.1.min.js\"></script>\r\n");
      out.write("<script src=\"//developers.kakao.com/sdk/js/kakao.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<!-- 카카오 로그인 버튼 -->\r\n");
      out.write("<a id=\"kakao-login-btn\"></a>\r\n");
      out.write("<!-- 카카오 로그인 버튼 -->\r\n");
      out.write("<script type='text/javascript'>\r\n");
      out.write("\r\n");
      out.write("    // 사용할 앱의 JavaScript 키를 설정 : kakao developer 에서 설정\r\n");
      out.write("    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');\r\n");
      out.write("    // 카카오 아이디로 로그인 버튼 생성시 호출되는 기능\r\n");
      out.write("    Kakao.Auth.createLoginButton({\r\n");
      out.write("      container: '#kakao-login-btn',\r\n");
      out.write("      success: function(authObj) {\r\n");
      out.write("        // 로그인 성공시 API 호출 - /v1/user/me : 개인정보 호출(kakaodeveloper 제공)\r\n");
      out.write("        Kakao.API.request({\r\n");
      out.write("          url: '/v1/user/me',\r\n");
      out.write("          success: function(res) {\r\n");
      out.write("            // 호출된 개인정보 중 이메일주소만 EmailK에 출력 \r\n");
      out.write("    \t\t$('#EmailK').append(JSON.stringify(res.kaccount_email));\r\n");
      out.write("          },\r\n");
      out.write("          fail: function(error) {\r\n");
      out.write("            alert(JSON.stringify(error));\r\n");
      out.write("          }\r\n");
      out.write("        });\r\n");
      out.write("      },\r\n");
      out.write("      fail: function(err) {\r\n");
      out.write("        alert(JSON.stringify(err));\r\n");
      out.write("      }\r\n");
      out.write("    });\r\n");
      out.write("    \r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("카카오 이메일 : <div id=EmailK></div><br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!--                        Login - Kakao                         -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!--                        Login - Google                         -->\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("<!-- 구글 로그인 버튼 -->\r\n");
      out.write("    <div id=\"gConnect\" class=\"button\">\r\n");
      out.write("      <button class=\"g-signin\"\r\n");
      out.write("          data-scope=\"email\"\r\n");
      out.write("          data-clientid=\"427985089734-bhj7cddethlpgqgm0jqgh7i7071en55t.apps.googleusercontent.com\"\r\n");
      out.write("          data-callback=\"onSignInCallback\"\r\n");
      out.write("          data-theme=\"dark\"\r\n");
      out.write("          data-cookiepolicy=\"single_host_origin\">\r\n");
      out.write("      </button>\r\n");
      out.write("    </div>\r\n");
      out.write("<!-- 구글 로그인 버튼 -->\r\n");
      out.write("  <script>\r\n");
      out.write("  /**\r\n");
      out.write("   * Handler for the signin callback triggered after the user selects an account.\r\n");
      out.write("   */\r\n");
      out.write("   \r\n");
      out.write("   //콜백시 무슨 행동을 할 것인가? -> 정보 불러오기\r\n");
      out.write("  function onSignInCallback(resp) {\r\n");
      out.write("    gapi.client.load('plus', 'v1', apiClientLoaded);\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  /**\r\n");
      out.write("   * Sets up an API call after the Google API client loads.\r\n");
      out.write("   */\r\n");
      out.write("   \r\n");
      out.write("  //handleEmailResopnse로 가져온 이메일 주소를 가져오는 기능(콜백함수에서 호출하는 그 기능) \r\n");
      out.write("  function apiClientLoaded() {\r\n");
      out.write("    gapi.client.plus.people.get({userId: 'me'}).execute(handleEmailResponse);\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  /**\r\n");
      out.write("   * Response callback for when the API client receives a response.\r\n");
      out.write("   *\r\n");
      out.write("   * @param resp The API response object with the user email and profile information.\r\n");
      out.write("   */\r\n");
      out.write("\r\n");
      out.write("//이메일 값을 받아서 출력하는 함수\r\n");
      out.write("\r\n");
      out.write("  function handleEmailResponse(resp) {\r\n");
      out.write("    var primaryEmail;\t\r\n");
      out.write("   for (var i=0; i < resp.emails.length; i++) {\r\n");
      out.write("      if (resp.emails[i].type === 'account') primaryEmail = resp.emails[i].value;\r\n");
      out.write("    }\r\n");
      out.write("\t$('#EmailG').append(primaryEmail);\r\n");
      out.write("\t \r\n");
      out.write(" }\r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("\r\n");
      out.write("Google 이메일 : <div id=\"EmailG\"> </div>\r\n");
      out.write("\r\n");
      out.write("<!--                        Login - Google                         -->\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
