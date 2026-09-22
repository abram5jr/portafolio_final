package com.zonajava.controlador;

import config.Conexion;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// 1. Configuración del Servlet y habilitación para recibir archivos (MultipartConfig)
@WebServlet(name = "SubirArchivoServlet", urlPatterns = {"/SubirArchivoServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB de memoria temporal
    maxFileSize = 1024 * 1024 * 10,       // 10MB máximo por archivo
    maxRequestSize = 1024 * 1024 * 50     // 50MB máximo en total
)
public class SubirArchivoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 2. Capturar los datos de texto del formulario admin.jsp
        String semanaIdStr = request.getParameter("semana");
        String categoria = request.getParameter("categoria");
        String tituloArchivo = request.getParameter("tituloArchivo");
        
        // 3. Capturar el archivo físico
        Part filePart = request.getPart("archivoFisico");
        String fileName = filePart.getSubmittedFileName();
        
        // 4. Definir dónde se va a guardar el archivo (En la carpeta 'docs' de tu proyecto)
        String uploadPath = getServletContext().getRealPath("") + File.separator + "docs";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Si la carpeta docs no existe en la ruta de construcción, la crea
        }
        
        // 5. Guardar el archivo físicamente en el servidor
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        
        // 6. Guardar los datos en la Base de Datos (MySQL)
        try {
            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            
            // Ruta relativa que leerá el HTML (ej: docs/mi_archivo.pdf)
            String rutaRelativa = "docs/" + fileName;
            int semanaId = Integer.parseInt(semanaIdStr);
            
            String sql = "INSERT INTO evidencias (semana_id, categoria_archivo, nombre_archivo, ruta_archivo) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, semanaId);
            ps.setString(2, categoria);
            ps.setString(3, tituloArchivo);
            ps.setString(4, rutaRelativa);
            
            ps.executeUpdate();
            
            System.out.println("Archivo subido y registrado exitosamente.");
            
        } catch (Exception e) {
            System.out.println("Error al guardar en BD: " + e.getMessage());
        }
        
        // 7. Redirigir de vuelta al panel de control (puedes enviar un mensaje de éxito por URL)
        response.sendRedirect("admin.jsp?status=exito&tab=trabajos");
    }
}