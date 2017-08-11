<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Spinner - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    var spinner = $( "#spinner" ).spinner();
   
  } );
  
  
  $(document).on('click', '.ui-button', function(){
	  var nf = Intl.NumberFormat();
	  var x = $('#spinner').val() * 1000;
	  $('#totalPrice').text(nf.format(x));
  });
  
  $(document).on('click', '#btn',function(){
	 alert($('#file').val()); 
  });
  
  </script>
</head>
<body>

<p>
  <label for="spinner">Select a value:</label>
  <input id="spinner" name="value">
</p>
 <div id="totalPrice">123456 </div>
<input type="file" id="file">
 <button id="btn">버튼</button>
 
</body>
</html>