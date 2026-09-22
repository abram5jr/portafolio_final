<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>
<div class="section-header">
    <span class="section-subtitle">SISTEMA DE ARCHIVOS</span>
    <h2 class="section-title">GESTOR DE <span class="text-cyan">EVIDENCIAS</span></h2>
    <p class="section-desc">Carga, actualiza o elimina los documentos y tareas correspondientes a cada semana académica.</p>
</div>

<div class="row g-4">
    <div class="col-lg-4">
        <div class="admin-card h-100" style="border-color: var(--neon-cyan);">
            <div class="admin-card-header" style="border-color: var(--neon-cyan); color: var(--neon-cyan);">
                <h5 class="m-0" style="font-size: 1.1rem;">⬆️ SUBIR NUEVA EVIDENCIA</h5>
            </div>
            <div class="card-body p-4">
                <form action="SubirArchivoServlet" method="POST" enctype="multipart/form-data">
                    <div class="mb-4">
                        <label class="form-label">Seleccionar Semana</label>
                        <select class="form-select" name="semana" required>
                            <option value="" selected disabled>-- Elige una fase --</option>
                            <option value="1">Semana 1 - Introducción al Curso</option>
                            <option value="2">Semana 2 - Actividad de Desarrollo</option>
                            <option value="3">Semana 3 - Fase de Pruebas</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Categoría</label>
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
                        <label class="form-label">Título del Archivo</label>
                        <input type="text" class="form-control" name="tituloArchivo" required>
                    </div>
                    <div class="mb-5">
                        <label class="form-label">Adjuntar Documento</label>
                        <input type="file" class="form-control" name="archivoFisico" required>
                    </div>
                    <button type="submit" class="btn btn-neon btn-success-neon w-100 py-2">EJECUTAR CARGA</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="admin-card h-100" style="border-color: var(--neon-purple);">
            <div class="admin-card-header" style="border-color: var(--neon-purple); color: var(--neon-purple);">
                <h5 class="m-0" style="font-size: 1.1rem;">📂 REGISTROS RECIENTES</h5>
            </div>
            <div class="card-body p-4 table-responsive">
                <table class="table table-dark table-hover text-white m-0">
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
                                    
                                    if(idSemana != ultimaSemanaVista) {
                                        out.print("<tr class='fila-separadora'><td colspan='4' class='text-center'>▶ SEMANA " + numeroSemana + ": " + tituloSemana.toUpperCase() + " ◀</td></tr>");
                                        ultimaSemanaVista = idSemana;
                                    }
                                    
                                    String badgeStyle = categoria.equals("ACTIVIDAD") ? 
                                        "background: rgba(188, 19, 254, 0.2); color: var(--neon-purple); border: 1px solid var(--neon-purple);" : 
                                        "background: rgba(57, 255, 20, 0.2); color: var(--neon-green); border: 1px solid var(--neon-green);";
                        %>
                                <tr>
                                    <td>Semana <%= numeroSemana %></td>
                                    <td><span class="badge" style="<%= badgeStyle %>"><%= categoria %></span></td>
                                    <td class="small" style="max-width: 150px; word-wrap: break-word; word-break: break-all; white-space: normal;"><%= nombreArchivo %></td>
                                    <td class="text-end" style="white-space: nowrap;">
                                        
                                        <button class="btn btn-sm btn-neon btn-cyan-neon py-0 px-2" data-bs-toggle="modal" data-bs-target="#editModal<%= idEvidencia %>">✏️</button>
                                        <a href="EliminarArchivoServlet?id=<%= idEvidencia %>" class="btn btn-sm btn-neon btn-danger-neon py-0 px-2" onclick="return confirm('¿Estás seguro de que deseas eliminar este registro?');" style="text-decoration: none;">❌</a>
                                        
                                        <div class="modal fade text-start" id="editModal<%= idEvidencia %>" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">EDITAR REGISTRO</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body p-4">
                                                        <form action="EditarArchivoServlet" method="POST">
                                                            <input type="hidden" name="idEvidencia" value="<%= idEvidencia %>">
                                                            
                                                            <div class="mb-3">
                                                                <label class="form-label">SEMANA</label>
                                                                <select class="form-select" name="semanaEdit" required>
                                                                    <option value="1" <%= idSemana == 1 ? "selected" : "" %>>Semana 1 - Introducción al Curso</option>
                                                                    <option value="2" <%= idSemana == 2 ? "selected" : "" %>>Semana 2 - Actividad de Desarrollo</option>
                                                                    <option value="3" <%= idSemana == 3 ? "selected" : "" %>>Semana 3 - Fase de Pruebas</option>
                                                                </select>
                                                            </div>
                                                            
                                                            <div class="mb-3">
                                                                <label class="form-label">CATEGORÍA</label>
                                                                <select class="form-select" name="categoriaEdit" required>
                                                                    <option value="ACTIVIDAD" <%= categoria.equals("ACTIVIDAD") ? "selected" : "" %>>Actividad</option>
                                                                    <option value="TAREA" <%= categoria.equals("TAREA") ? "selected" : "" %>>Tarea</option>
                                                                </select>
                                                            </div>
                                                            
                                                            <div class="mb-4">
                                                                <label class="form-label">TÍTULO DEL ARCHIVO</label>
                                                                <input type="text" class="form-control" name="tituloEdit" value="<%= nombreArchivo %>" required>
                                                            </div>
                                                            
                                                            <button type="submit" class="btn btn-neon btn-cyan-neon w-100 py-2">GUARDAR CAMBIOS</button>
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
