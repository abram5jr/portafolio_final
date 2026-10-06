<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>

<%
    String dbNombre = "";
    String dbProfesion = "";
    String dbSobreMi = "";
    String dbFotoUrl = "";
    
    try {
        Conexion conexionDB = new Conexion();
        Connection con = conexionDB.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM perfil WHERE id = 1");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            dbNombre = rs.getString("nombre");
            dbProfesion = rs.getString("profesion");
            dbSobreMi = rs.getString("sobre_mi");
            dbFotoUrl = rs.getString("foto_url");
        }
    } catch (Exception e) { }
%>

<div class="section-header">
    <span class="section-subtitle" style="color: var(--brand-cyan);">CONFIGURACIÓN</span>
    <h2 class="section-title">DATOS DEL <span style="color: var(--brand-purple);">USUARIO</span></h2>
    <p class="section-desc">Modifica la información y tu foto de perfil para el portafolio público.</p>
</div>

<div class="admin-card" style="border-color: var(--brand-purple) !important;">
    <div class="admin-card-header">
        <h5 class="m-0" style="font-size: 1.1rem; font-weight: 600;">👤 INFORMACIÓN PÚBLICA</h5>
    </div>
    <div class="card-body p-1">
        <form action="${pageContext.request.contextPath}/ActualizarPerfilServlet" method="POST" enctype="multipart/form-data">
            
            <div class="mb-4">
                <label class="form-label" style="color: var(--brand-purple);">Foto de Perfil (Opcional - Dejar vacío para mantener la actual)</label>
                <input type="file" class="form-control" name="fotoPerfil" accept="image/*">
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label" style="color: var(--brand-purple);">Nombre Completo</label>
                    <input type="text" class="form-control" name="nombre" value="<%= dbNombre %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label" style="color: var(--brand-purple);">Profesión / Título</label>
                    <input type="text" class="form-control" name="profesion" value="<%= dbProfesion %>" required>
                </div>
            </div>

            <div class="mb-4 mt-5">
                <label class="form-label" style="color: var(--brand-cyan);">SÍNTESIS PROFESIONAL (SOBRE MÍ)</label>
                <textarea class="form-control" name="sobreMi" rows="5" required><%= dbSobreMi %></textarea>
            </div>
            
            <div class="text-end mt-4">
                <button type="submit" class="btn py-2 px-5" style="background: rgba(0, 230, 118, 0.1); color: var(--brand-green); border: 1px solid var(--brand-green); font-weight: 600; border-radius: 8px; transition: 0.3s;" onmouseover="this.style.background='var(--brand-green)'; this.style.color='#000';" onmouseout="this.style.background='rgba(0, 230, 118, 0.1)'; this.style.color='var(--brand-green)';">
                    ACTUALIZAR DATOS
                </button>
            </div>
        </form>
    </div>
</div>