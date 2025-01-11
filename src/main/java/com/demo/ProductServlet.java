package com.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        // Set default page value if not provided
        int page = 1; // Default to page 1
        int limit = 5; // Number of products per page

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                response.getWriter().println("<p>Invalid page number. Defaulting to page 1.</p>");
            }
        }

        int offset = (page - 1) * limit;

        try (
        		Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(
                 "SELECT * FROM products LIMIT ? OFFSET ?")) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();

            response.getWriter().println("<table border='1'><tr><th>ID</th><th>Name</th><th>Price</th><th>Description</th></tr>");
            while (rs.next()) {
                response.getWriter().println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("name") +
                        "</td><td>" + rs.getDouble("price") + "</td><td>" + rs.getString("description") + "</td></tr>");
            }
            response.getWriter().println("</table>");

            // Add pagination links
            response.getWriter().println("<div>");
            if (page > 1) {
                response.getWriter().println("<a href='ProductServlet?page=" + (page - 1) + "'>Previous</a> ");
            }
            response.getWriter().println("<a href='ProductServlet?page=" + (page + 1) + "'>Next</a>");
            response.getWriter().println("</div>");
        } catch (Exception e) {
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
