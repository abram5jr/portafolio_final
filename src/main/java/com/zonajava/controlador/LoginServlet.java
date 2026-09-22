package com.zonajava.controlador;

import config.Conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibir los datos que escribiste en la ventana modal
        String u = request.getParameter("txtUsuario"); // Nombre del input en tu HTML
        String p = request.getParameter("txtPassword"); // Nombre del input en tu HTML
        
        try {
            // 2. Conectarnos a la base de datos db_portafolio
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            // 3. Buscar si el usuario y clave coinciden en la tabla 'usuarios'
            String sql = "SELECT * FROM usuarios WHERE usuario = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u);
            ps.setString(2, p);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // ¡Credenciales correctas! Creamos una sesión y lo mandamos al panel
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogueado", rs.getString("usuario"));
                session.setAttribute("rolUsuario", rs.getString("rol"));
                
                response.sendRedirect("admin.jsp");
            } else {
                // Credenciales incorrectas, lo regresamos al index
                response.sendRedirect("login.jsp?error=1");
            }
            
        } catch (Exception e) {
            System.out.println("Error en el Login: " + e.getMessage());
        }
    }
}