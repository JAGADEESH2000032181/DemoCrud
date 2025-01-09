<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %> 
<!DOCTYPE html>
<html>
<head>
    <title>View Products</title>
</head>
<body>
    <h1>Product List</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <% 
            try (Connection conn = com.demo.DBConnection.getConnection();
                 java.sql.Statement stmt = conn.createStatement();
                 java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getString("description") %></td>
            <td>
                <a href="editProduct.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                <a href="DeleteProductServlet?id=<%= rs.getInt("id") %>">Delete</a>
            </td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } 
        %>
    </table>
    <br>
    <a href="addProduct.jsp">Add New Product</a>
</body>
</html>
