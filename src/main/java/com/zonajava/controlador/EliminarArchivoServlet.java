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

@WebServlet(name = "EliminarArchivoServlet", urlPatterns = {"/EliminarArchivoServlet"})
public class EliminarArchivoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        try {
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            String sql = "DELETE FROM evidencias WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("Error al eliminar: " + e.getMessage());
        }
        
        // REDIRECCIÓN CORRECTA:
        response.sendRedirect("admin.jsp?status=eliminado&tab=trabajos");
    }
}