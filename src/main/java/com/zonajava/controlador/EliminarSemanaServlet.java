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

@WebServlet(name = "EliminarSemanaServlet", urlPatterns = {"/EliminarSemanaServlet"})
public class EliminarSemanaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idSemana"));
        
        try {
            Connection con = new Conexion().getConnection();
            // Eliminamos la semana
            PreparedStatement ps = con.prepareStatement("DELETE FROM semanas WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { }
        
        response.sendRedirect("admin.jsp?status=eliminado&tab=semanas");
    }
}