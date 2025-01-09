<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
    <h1>Edit Product</h1>
    <form action="EditProductServlet" method="post">
        <%
            // Step 1: Retrieve the product ID from the URL (query parameter 'id')
            int id = Integer.parseInt(request.getParameter("id"));

            // Step 2: Connect to the database and fetch product details using the id
            try (Connection conn = com.demo.DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE id = ?")) {
                stmt.setInt(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) { // If product with this id exists, populate the form with its details
        %>
        <!-- Step 3: Hidden field to store the product ID -->
        <input type="hidden" name="id" value="<%= id %>">

        <!-- Step 4: Display the product details in editable fields -->
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required><br><br>

        <label for="price">Price:</label>
        <input type="number" step="0.01" id="price" name="price" value="<%= rs.getDouble("price") %>" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description"><%= rs.getString("description") %></textarea><br><br>

        <button type="submit">Update Product</button>

        <%
                    } else {
                        // If the product doesn't exist, display a message
                        out.println("<p>Product not found!</p>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </form>
</body>
</html>

