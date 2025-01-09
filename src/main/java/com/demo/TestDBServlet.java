package com.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/TestDBServlet")
public class TestDBServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                response.getWriter().println("<h1>Database Connection Successful!</h1>");
            } else {
                response.getWriter().println("<h1>Database Connection Failed!</h1>");
            }
        } catch (Exception e) {
            response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
        }
    }
}
