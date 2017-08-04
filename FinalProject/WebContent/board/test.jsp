<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<script type="text/javascript">

$('.t').click(function () {
    //general stuff must happen everytime class is clicked
    //get the className from data- attr
    var className = $(this).data('class');
    //toggling to change color
    $(this).toggleClass(className).toggleClass(className + '1');

    //check if its clicked already using data- attribute
    if ($(this).data("clicked")) {
        //remove it if yes
        $("#newDiv").find("#tablefor-" + className).remove();
    } else {
        //new table - note that I've added an id to it indicate where it came from
        var newTable = '<table id="tablefor-' + className + '" style="font-size: 14;float:left;padding-left: 13px;" cellpadding="5"><tr><td style="color: #B2B2B9;">T1' + className + '</td></tr><tr><td id="cap">20</td></tr><tr><td id="minseat">8</td></tr></table>';

        //append table                
        $("#newDiv").append(newTable);
    }
    //reverse the data of clicked
    $(this).data("clicked", !$(this).data("clicked"));
});

</script>
<body>
 <div class="t a" data-class="a"> 8cghfghfghfghfg</div>
 <div class="t b" data-class="b">20cghfghfghfghfg</div>
 <div class="t c" data-class="c"> 4cghfghfghfghfg</div>

 <div id="newDiv"></div>
</body>
</html>