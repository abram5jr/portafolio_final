<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>

<style>
    /* Estilos mejorados para la tabla interactiva de Evidencias */
    .table-evidencias th {
        color: #888;
        font-family: 'Orbitron', sans-serif;
        font-size: 0.75rem;
        letter-spacing: 1px;
        border-bottom: 1px solid #333;
        padding-bottom: 15px;
    }
    .table-evidencias td {
        vertical-align: middle;
        border-bottom: 1px solid #222;
        color: #ddd;
    }
    .fila-separadora {
        background: rgba(0, 243, 255, 0.04);
        border-left: 4px solid var(--neon-cyan, #00f3ff);
        transition: all 0.3s ease;
    }
    .fila-separadora:hover {
        background: rgba(0, 243, 255, 0.1) !important;
        box-shadow: inset 0 0 15px rgba(0, 243, 255, 0.1);
    }
    .fila-evidencia {
        background: rgba(255, 255, 255, 0.01);
        transition: 0.2s ease;
    }
    .fila-evidencia:hover {
        background: rgba(188, 19, 254, 0.08) !important;
    }
</style>

<div class="section-header">
    <span class="section-subtitle">SISTEMA DE ARCHIVOS</span>
    <h2 class="section-title">GESTOR DE <span class="text-cyan" style="color: var(--neon-cyan, #00f3ff);">EVIDENCIAS</span></h2>
    <p class="section-desc">Carga, actualiza o elimina los documentos y tareas correspondientes a cada semana académica.</p>
</div>

<div class="row g-4">
    <div class="col-lg-4">
        <div class="admin-card h-100" style="border-color: var(--neon-cyan, #00f3ff);">
            <div class="admin-card-header" style="border-color: var(--neon-cyan, #00f3ff); color: var(--neon-cyan, #00f3ff);">
                <h5 class="m-0" style="font-size: 1.1rem; font-family: 'Orbitron', sans-serif;">⬆️ SUBIR NUEVA EVIDENCIA</h5>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/SubirArchivoServlet" method="POST" enctype="multipart/form-data">
                    <div class="mb-4">
                        <label class="form-label" style="color: #bbb;">Seleccionar Semana</label>
                        <select class="form-select" name="semana" required style="background: rgba(255,255,255,0.03); border: 1px solid #444; color: #fff;">
                            <option value="" selected disabled>-- Elige una fase --</option>
                            <%
                                try {
                                    Connection con = new Conexion().getConnection();
                                    PreparedStatement psSemanas = con.prepareStatement("SELECT id, numero_semana, titulo_semana FROM semanas ORDER BY numero_semana ASC");
                                    ResultSet rsSemanas = psSemanas.executeQuery();
                                    while(rsSemanas.next()) {
                                        out.print("<option value='" + rsSemanas.getInt("id") + "'>Semana " + rsSemanas.getInt("numero_semana") + " - " + rsSemanas.getString("titulo_semana") + "</option>");
                                    }
                                } catch(Exception e) {}
                            %>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" style="color: #bbb;">Categoría</label>
                        <div class="d-flex gap-4 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="categoria" id="catActividad" value="ACTIVIDAD" required>
                                <label class="form-check-label text-white" for="catActividad">📄 Actividad</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="categoria" id="catTarea" value="TAREA">
                                <label class="form-check-label text-white" for="catTarea">🖼️ Tarea</label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" style="color: #bbb;">Título del Archivo</label>
                        <input type="text" class="form-control" name="tituloArchivo" required style="background: rgba(255,255,255,0.03); border: 1px solid #444; color: #fff;">
                    </div>
                    <div class="mb-5">
                        <label class="form-label" style="color: #bbb;">Adjuntar Documento</label>
                        <input type="file" class="form-control" name="archivoFisico" required style="background: rgba(255,255,255,0.03); border: 1px solid #444; color: #fff;">
                    </div>
                    <button type="submit" class="btn w-100 py-2" style="background: transparent; border: 2px solid var(--neon-cyan, #00f3ff); color: var(--neon-cyan, #00f3ff); font-family: 'Orbitron', sans-serif; transition: 0.3s;" onmouseover="this.style.background='var(--neon-cyan, #00f3ff)'; this.style.color='#000'; this.style.boxShadow='0 0 15px rgba(0, 243, 255, 0.5)';" onmouseout="this.style.background='transparent'; this.style.color='var(--neon-cyan, #00f3ff)'; this.style.boxShadow='none';">EJECUTAR CARGA</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="admin-card h-100" style="border-color: var(--neon-purple, #bc13fe);">
            <div class="admin-card-header" style="border-color: var(--neon-purple, #bc13fe); color: var(--neon-purple, #bc13fe);">
                <h5 class="m-0" style="font-size: 1.1rem; font-family: 'Orbitron', sans-serif;">📂 REGISTROS POR SEMANA</h5>
            </div>
            <div class="card-body p-4 table-responsive">
                <table class="table table-borderless table-evidencias w-100 m-0">
                    <thead>
                        <tr>
                            <th>SEMANA</th>
                            <th>CATEGORÍA</th>
                            <th>ARCHIVO</th>
                            <th class="text-end">ACCIÓN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Conexion conexionDB = new Conexion();
                                Connection con = conexionDB.getConnection();
                                
                                String sql = "SELECT s.numero_semana, s.titulo_semana, e.semana_id, e.categoria_archivo, e.nombre_archivo, e.id " +
                                             "FROM evidencias e INNER JOIN semanas s ON e.semana_id = s.id " +
                                             "ORDER BY s.numero_semana ASC, e.id DESC";
                                
                                PreparedStatement ps = con.prepareStatement(sql);
                                ResultSet rs = ps.executeQuery();
                                
                                int ultimaSemanaVista = -1;
                                
                                while(rs.next()) {
                                    int idEvidencia = rs.getInt("id");
                                    int idSemana = rs.getInt("semana_id");
                                    int numeroSemana = rs.getInt("numero_semana");
                                    String tituloSemana = rs.getString("titulo_semana");
                                    String categoria = rs.getString("categoria_archivo");
                                    String nombreArchivo = rs.getString("nombre_archivo");
                                    
                                    // DISEÑO DEL SEPARADOR DESPLEGABLE NEÓN
                                    if(idSemana != ultimaSemanaVista) {
                                        out.print("<tr class='fila-separadora' onclick='toggleSemana(" + idSemana + ")' style='cursor: pointer;'>");
                                        out.print("<td colspan='4' class='text-start' style='padding: 18px 15px;'>");
                                        out.print("<span id='icon-semana-" + idSemana + "' style='display:inline-block; width: 25px; color: #888; transition: 0.3s; font-size: 0.8rem;'>▶</span>");
                                        out.print("<span style='color: #fff; font-family: \"Orbitron\", sans-serif; font-size: 1.05rem; letter-spacing: 1px; font-weight: 700;'>SEMANA " + numeroSemana + "</span>");
                                        out.print("<span style='color: var(--neon-cyan, #00f3ff); font-size: 0.85rem; margin-left: 15px; letter-spacing: 1px; opacity: 0.8;'>// " + tituloSemana.toUpperCase() + "</span>");
                                        out.print("</td></tr>");
                                        ultimaSemanaVista = idSemana;
                                    }
                                    
                                    String badgeStyle = categoria.equals("ACTIVIDAD") ? 
                                        "background: rgba(188, 19, 254, 0.15); color: var(--neon-purple, #bc13fe); border: 1px solid var(--neon-purple, #bc13fe);" : 
                                        "background: rgba(57, 255, 20, 0.15); color: var(--neon-green, #39ff14); border: 1px solid var(--neon-green, #39ff14);";
                        %>
                                <!-- FILAS DE ARCHIVOS OCULTAS POR DEFECTO -->
                                <tr class="fila-semana-<%= idSemana %> fila-evidencia" style="display: none;">
                                    <td class="ps-4">Semana <%= numeroSemana %></td>
                                    <td><span class="badge" style="<%= badgeStyle %>"><%= categoria %></span></td>
                                    <td class="small" style="max-width: 150px; word-wrap: break-word; word-break: break-all; white-space: normal;"><%= nombreArchivo %></td>
                                    <td class="text-end" style="white-space: nowrap;">
                                        
                                        <button class="btn btn-sm py-0 px-2" style="border: 1px solid var(--neon-cyan, #00f3ff); color: var(--neon-cyan, #00f3ff); background: transparent;" data-bs-toggle="modal" data-bs-target="#editModal<%= idEvidencia %>">✏️</button>
                                        <a href="${pageContext.request.contextPath}/EliminarArchivoServlet?id=<%= idEvidencia %>" class="btn btn-sm py-0 px-2 ms-1" onclick="return confirm('¿Estás seguro de que deseas eliminar este registro?');" style="border: 1px solid #ff3366; color: #ff3366; background: transparent; text-decoration: none;">❌</a>
                                        
                                        <!-- MODAL DE EDICIÓN -->
                                        <div class="modal fade text-start" id="editModal<%= idEvidencia %>" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content" style="background-color: var(--card-bg, #121218); border: 2px solid var(--neon-cyan, #00f3ff); box-shadow: 0 0 30px rgba(0, 243, 255, 0.2);">
                                                    <div class="modal-header" style="border-bottom: 1px dashed var(--neon-cyan, #00f3ff);">
                                                        <h5 class="modal-title" style="color: var(--neon-cyan, #00f3ff); font-family: 'Orbitron', sans-serif;">EDITAR REGISTRO</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body p-4">
                                                        <form action="${pageContext.request.contextPath}/EditarArchivoServlet" method="POST">
                                                            <input type="hidden" name="idEvidencia" value="<%= idEvidencia %>">
                                                            
                                                            <div class="mb-3">
                                                                <label class="form-label" style="color: #bbb;">SEMANA</label>
                                                                <select class="form-select" name="semanaEdit" required style="background: #09090b; border: 1px solid #444; color: #fff;">
                                                                    <option value="1" <%= idSemana == 1 ? "selected" : "" %>>Semana 1 - Introducción al Curso</option>
                                                                    <option value="2" <%= idSemana == 2 ? "selected" : "" %>>Semana 2 - Actividad de Desarrollo</option>
                                                                    <option value="3" <%= idSemana == 3 ? "selected" : "" %>>Semana 3 - Fase de Pruebas</option>
                                                                </select>
                                                            </div>
                                                            
                                                            <div class="mb-3">
                                                                <label class="form-label" style="color: #bbb;">CATEGORÍA</label>
                                                                <select class="form-select" name="categoriaEdit" required style="background: #09090b; border: 1px solid #444; color: #fff;">
                                                                    <option value="ACTIVIDAD" <%= categoria.equals("ACTIVIDAD") ? "selected" : "" %>>Actividad</option>
                                                                    <option value="TAREA" <%= categoria.equals("TAREA") ? "selected" : "" %>>Tarea</option>
                                                                </select>
                                                            </div>
                                                            
                                                            <div class="mb-4">
                                                                <label class="form-label" style="color: #bbb;">TÍTULO DEL ARCHIVO</label>
                                                                <input type="text" class="form-control" name="tituloEdit" value="<%= nombreArchivo %>" required style="background: #09090b; border: 1px solid #444; color: #fff;">
                                                            </div>
                                                            
                                                            <button type="submit" class="btn w-100 py-2" style="background: transparent; border: 2px solid var(--neon-cyan, #00f3ff); color: var(--neon-cyan, #00f3ff); font-family: 'Orbitron', sans-serif;">GUARDAR CAMBIOS</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='4'>Error al cargar datos: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- SCRIPT DEL EFECTO ACORDEÓN PARA LAS SEMANAS -->
<script>
    function toggleSemana(idSemana) {
        var filas = document.querySelectorAll('.fila-semana-' + idSemana);
        var icono = document.getElementById('icon-semana-' + idSemana);
        var isExpanded = false;
        
        filas.forEach(function(fila) {
            // Si está oculto, lo mostramos (desplegar)
            if (fila.style.display === 'none') {
                fila.style.display = 'table-row';
                isExpanded = true;
            } else {
                // Si está visible, lo ocultamos (colapsar)
                fila.style.display = 'none';
                isExpanded = false;
            }
        });
        
        // Animación visual del ícono de flecha
        if(icono) {
            icono.innerHTML = isExpanded ? "▼" : "▶";
            icono.style.color = isExpanded ? "var(--neon-cyan, #00f3ff)" : "#888";
            icono.style.textShadow = isExpanded ? "0 0 10px rgba(0, 243, 255, 0.8)" : "none";
        }
    }
</script>