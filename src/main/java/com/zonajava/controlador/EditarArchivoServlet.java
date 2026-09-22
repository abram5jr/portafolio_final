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

@WebServlet(name = "EditarArchivoServlet", urlPatterns = {"/EditarArchivoServlet"})
public class EditarArchivoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Esto evita que las tildes o eñes se rompan al editar
        request.setCharacterEncoding("UTF-8");
        
        // 1. Recibimos los datos corregidos desde el Modal
        String idEvidencia = request.getParameter("idEvidencia");
        String nuevaSemana = request.getParameter("semanaEdit");
        String nuevaCategoria = request.getParameter("categoriaEdit");
        String nuevoTitulo = request.getParameter("tituloEdit");
        
        try {
            // 2. Nos conectamos a la BD
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            // 3. Preparamos la orden UPDATE para MySQL
            String sql = "UPDATE evidencias SET semana_id=?, categoria_archivo=?, nombre_archivo=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setInt(1, Integer.parseInt(nuevaSemana));
            ps.setString(2, nuevaCategoria);
            ps.setString(3, nuevoTitulo);
            ps.setInt(4, Integer.parseInt(idEvidencia));
            
            // 4. Ejecutamos la actualización
            ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("Error al editar el registro: " + e.getMessage());
        }
        
        // 5. Regresamos al panel recargado
        response.sendRedirect("admin.jsp");
    }
}