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

@WebServlet(name = "ActualizarPerfilServlet", urlPatterns = {"/ActualizarPerfilServlet"})
public class ActualizarPerfilServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Recibimos solo los campos que existen en la BD
        String nombre = request.getParameter("nombre");
        String profesion = request.getParameter("profesion");
        String sobreMi = request.getParameter("sobreMi");
        
        try {
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            // Actualizamos la tabla 'perfil'
            String sql = "UPDATE perfil SET nombre=?, profesion=?, sobre_mi=? WHERE id=1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, profesion);
            ps.setString(3, sobreMi);
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("Error al actualizar perfil: " + e.getMessage());
        }
        
        // Redirigir lanzando la alerta de éxito en el admin
        response.sendRedirect("admin.jsp?status=editado&tab=perfil");
    }
}