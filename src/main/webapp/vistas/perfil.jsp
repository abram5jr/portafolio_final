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
    
    // Si la BD no tiene foto, muestra un placeholder transparente o predeterminado
    String avatarMostrado = (dbFotoUrl != null && !dbFotoUrl.trim().isEmpty()) ? dbFotoUrl : "https://via.placeholder.com/150/09090b/00f3ff?text=FOTO";
%>

<style>
    /* Estilos Neón para la Vista Previa */
    .profile-preview-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px dashed rgba(188, 19, 254, 0.3);
    }
    .profile-preview-img {
        width: 160px;
        height: 160px;
        object-fit: cover;
        border-radius: 50%;
        border: 3px solid var(--neon-cyan, #00f3ff);
        box-shadow: 0 0 25px rgba(0, 243, 255, 0.4);
        transition: all 0.4s ease;
        background-color: #121218;
    }
    .profile-preview-img:hover {
        box-shadow: 0 0 40px rgba(0, 243, 255, 0.7);
        transform: scale(1.05);
    }
    .file-input-neon {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid #333;
        color: #fff;
        transition: 0.3s;
    }
    .file-input-neon:focus {
        border-color: var(--neon-purple, #bc13fe);
        box-shadow: 0 0 15px rgba(188, 19, 254, 0.3);
    }
</style>

<div class="section-header">
    <span class="section-subtitle" style="color: var(--brand-cyan);">CONFIGURACIÓN</span>
    <h2 class="section-title">DATOS DEL <span style="color: var(--brand-purple);">USUARIO</span></h2>
    <p class="section-desc">Modifica la información y tu foto de perfil para el portafolio público.</p>
</div>

<div class="admin-card" style="border-color: var(--brand-purple) !important;">
    <div class="admin-card-header">
        <h5 class="m-0" style="font-size: 1.1rem; font-weight: 600;">👤 INFORMACIÓN PÚBLICA</h5>
    </div>
    <div class="card-body p-4">
        <form action="${pageContext.request.contextPath}/ActualizarPerfilServlet" method="POST" enctype="multipart/form-data">
            
            <!-- VISTA PREVIA INTERACTIVA DE LA FOTO -->
            <div class="profile-preview-container">
                <img id="previewFoto" src="<%= avatarMostrado %>" alt="Vista previa de foto" class="profile-preview-img">
                <span class="mt-3" style="color: var(--brand-cyan, #00f3ff); font-size: 0.8rem; font-family: 'Orbitron', sans-serif; letter-spacing: 2px;">VISTA PREVIA EN VIVO</span>
            </div>

            <div class="mb-4">
                <label class="form-label" style="color: var(--brand-purple);">Foto de Perfil (Opcional - Dejar vacío para mantener la actual)</label>
                <!-- EVENTO ONCHANGE PARA ACTUALIZAR LA VISTA PREVIA -->
                <input type="file" class="form-control file-input-neon" name="fotoPerfil" accept="image/*" onchange="previewImage(event)">
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label" style="color: var(--brand-purple);">Nombre Completo</label>
                    <input type="text" class="form-control file-input-neon" name="nombre" value="<%= dbNombre %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label" style="color: var(--brand-purple);">Profesión / Título</label>
                    <input type="text" class="form-control file-input-neon" name="profesion" value="<%= dbProfesion %>" required>
                </div>
            </div>

            <div class="mb-4 mt-5">
                <label class="form-label" style="color: var(--brand-cyan);">SÍNTESIS PROFESIONAL (SOBRE MÍ)</label>
                <textarea class="form-control file-input-neon" name="sobreMi" rows="5" required><%= dbSobreMi %></textarea>
            </div>
            
            <div class="text-end mt-4">
                <button type="submit" class="btn py-2 px-5" style="background: rgba(0, 230, 118, 0.1); color: var(--brand-green); border: 1px solid var(--brand-green); font-weight: 600; border-radius: 8px; transition: 0.3s;" onmouseover="this.style.background='var(--brand-green)'; this.style.color='#000'; this.style.boxShadow='0 0 20px rgba(57, 255, 20, 0.5)';" onmouseout="this.style.background='rgba(0, 230, 118, 0.1)'; this.style.color='var(--brand-green)'; this.style.boxShadow='none';">
                    ACTUALIZAR DATOS
                </button>
            </div>
        </form>
    </div>
</div>

<!-- SCRIPT PARA EL CAMBIO DINÁMICO DE LA FOTO -->
<script>
    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function() {
            var output = document.getElementById('previewFoto');
            output.src = reader.result;
            output.style.boxShadow = "0 0 35px rgba(188, 19, 254, 0.6)"; // Cambia a morado al subir nueva foto para indicar cambio
            output.style.borderColor = "var(--neon-purple, #bc13fe)";
        }
        if(event.target.files[0]) {
            reader.readAsDataURL(event.target.files[0]);
        }
    }
</script>