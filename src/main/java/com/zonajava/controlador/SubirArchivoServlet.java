package com.zonajava.controlador;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import config.Conexion;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "SubirArchivoServlet", urlPatterns = {"/SubirArchivoServlet"})
// Configuramos el Servlet para recibir archivos multipart de hasta 10MB
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 50    
)
public class SubirArchivoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // 1. Recibir datos del formulario
        int idSemana = Integer.parseInt(request.getParameter("semana"));
        String categoria = request.getParameter("categoria");
        String tituloArchivo = request.getParameter("tituloArchivo");
        Part filePart = request.getPart("archivoFisico");

        try {
            // Código nuevo (Seguro - Lee las variables de Render)
            Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", System.getenv("CLOUD_NAME"),
                "api_key", System.getenv("API_KEY"),
                "api_secret", System.getenv("API_SECRET"),
                "secure", true
            ));
            // 3. Crear un archivo temporal seguro en el servidor para el traspaso
            String fileName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            File tempFile = new File(System.getProperty("java.io.tmpdir") + "/" + fileName);
            
            try (InputStream is = filePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(tempFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // 4. Subir a la nube y obtener la URL permanente
            Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
            String urlCloudinary = uploadResult.get("secure_url").toString();
            
            // Limpieza del archivo temporal
            tempFile.delete();

            // 5. Registrar la evidencia en TiDB con el enlace absoluto
            Connection con = new Conexion().getConnection();
            String sql = "INSERT INTO evidencias (semana_id, categoria_archivo, nombre_archivo, ruta_archivo) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idSemana);
            ps.setString(2, categoria);
            ps.setString(3, tituloArchivo);
            ps.setString(4, urlCloudinary);
            ps.executeUpdate();

            // Redirigir con alerta de éxito
            response.sendRedirect(request.getContextPath() + "/admin.jsp?status=exito&tab=trabajos");

        } catch (Exception e) {
            System.out.println("Error grave al procesar la evidencia: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin.jsp?status=error&tab=trabajos");
        }
    }
}