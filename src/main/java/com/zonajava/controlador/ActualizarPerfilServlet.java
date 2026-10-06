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

@WebServlet(name = "ActualizarPerfilServlet", urlPatterns = {"/ActualizarPerfilServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 5,      
    maxRequestSize = 1024 * 1024 * 10    
)
public class ActualizarPerfilServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String nombre = request.getParameter("nombre");
        String profesion = request.getParameter("profesion");
        String sobreMi = request.getParameter("sobreMi");
        Part filePart = request.getPart("fotoPerfil");
        
        String urlCloudinary = null;

        try {
            if (filePart != null && filePart.getSize() > 0) {
                Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", System.getenv("CLOUD_NAME"),
                    "api_key", System.getenv("API_KEY"),
                    "api_secret", System.getenv("API_SECRET"),
                    "secure", true
                ));
                
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

                Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap("resource_type", "image"));
                urlCloudinary = uploadResult.get("secure_url").toString();
                tempFile.delete();
            }

            Conexion conexionDB = new Conexion();
            Connection con = conexionDB.getConnection();
            String sql;
            PreparedStatement ps;

            if (urlCloudinary != null) {
                sql = "UPDATE perfil SET nombre=?, profesion=?, sobre_mi=?, foto_url=? WHERE id=1";
                ps = con.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, profesion);
                ps.setString(3, sobreMi);
                ps.setString(4, urlCloudinary);
            } else {
                sql = "UPDATE perfil SET nombre=?, profesion=?, sobre_mi=? WHERE id=1";
                ps = con.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, profesion);
                ps.setString(3, sobreMi);
            }
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("Error al actualizar perfil: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin.jsp?status=editado&tab=perfil");
    }
}