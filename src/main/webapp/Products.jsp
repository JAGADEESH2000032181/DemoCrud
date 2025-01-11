<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>


<form method="GET" action="ProductServlet">
<label for="price_min">Min Price:</label>
<input type="number" name="price_min" id="price_min">
<label for="price_max">Max Price:</label>
<input type="number" name="price_max" id="price_max">
<button type="submit">Filter</button>


</form>

</body>
</html>