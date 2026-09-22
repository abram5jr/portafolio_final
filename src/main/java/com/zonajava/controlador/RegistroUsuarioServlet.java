package com.zonajava.controlador;

import config.Conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroUsuarioServlet", urlPatterns = {"/RegistroUsuarioServlet"})
public class RegistroUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Capturamos los datos del formulario (usuarios.jsp)
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        
        // 2. Insertamos en la Base de Datos
        try {
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            String sql = "INSERT INTO usuarios (usuario, password, rol) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, password);
            ps.setString(3, rol);
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("Error al registrar usuario: " + e.getMessage());
        }
        
        // 3. Redirigimos al admin.jsp activando la notificación "registrado"
        response.sendRedirect("admin.jsp?status=registrado&tab=usuarios");
    }
}