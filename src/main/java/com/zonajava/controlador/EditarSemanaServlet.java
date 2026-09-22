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

@WebServlet(name = "EditarSemanaServlet", urlPatterns = {"/EditarSemanaServlet"})
public class EditarSemanaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("idSemana"));
        int numero = Integer.parseInt(request.getParameter("numero"));
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        
        try {
            Connection con = new Conexion().getConnection();
            String sql = "UPDATE semanas SET numero_semana=?, titulo_semana=?, descripcion=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, numero);
            ps.setString(2, titulo);
            ps.setString(3, descripcion);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (Exception e) { }
        
        response.sendRedirect("admin.jsp?status=editado&tab=semanas");
    }
}