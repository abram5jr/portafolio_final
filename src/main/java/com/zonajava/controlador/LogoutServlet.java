package com.zonajava.controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtenemos la sesión actual
        HttpSession session = request.getSession(false);
        
        // 2. Si existe una sesión abierta, la destruimos
        if (session != null) {
            session.invalidate();
        }
        
        // 3. Te redirigimos a la página de login
        response.sendRedirect("login.jsp");
    }
}