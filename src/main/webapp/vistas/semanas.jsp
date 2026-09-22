<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>

<div class="section-header d-flex justify-content-between align-items-end">
    <div>
        <span class="section-subtitle" style="color: var(--brand-cyan);">ESTRUCTURA DE APRENDIZAJE</span>
        <h2 class="section-title">CONTROL DE <span style="color: var(--brand-green);">FASES</span></h2>
        <p class="section-desc mb-0">Define los bloques de semanas académicas para agrupar tus evidencias.</p>
    </div>
    <!-- Botón que abre el Modal de Crear -->
    <button class="btn py-2 px-4" data-bs-toggle="modal" data-bs-target="#modalCrearSemana" style="background: rgba(0, 230, 118, 0.1); color: var(--brand-green); border: 1px solid var(--brand-green); font-weight: 600; border-radius: 8px; transition: 0.3s;" onmouseover="this.style.background='var(--brand-green)'; this.style.color='#000';" onmouseout="this.style.background='rgba(0, 230, 118, 0.1)'; this.style.color='var(--brand-green)';">
        + CREAR SEMANA
    </button>
</div>

<div class="admin-card" style="border-color: var(--brand-green) !important; padding: 0 !important; overflow: hidden;">
    <div class="card-body p-0 table-responsive">
        <table class="table table-dark table-hover m-0">
            <thead>
                <tr>
                    <th class="ps-4" style="padding-top: 20px; padding-bottom: 20px;">N° SEMANA</th>
                    <th style="padding-top: 20px; padding-bottom: 20px;">TÍTULO DE FASE</th>
                    <th style="padding-top: 20px; padding-bottom: 20px;">DESCRIPCIÓN</th>
                    <th class="text-end pe-4" style="padding-top: 20px; padding-bottom: 20px;">HERRAMIENTAS</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Conexion conexionDB = new Conexion();
                        Connection con = conexionDB.getConnection();
                        // Se listan las semanas ordenadas por número
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM semanas ORDER BY numero_semana ASC");
                        ResultSet rs = ps.executeQuery();
                        
                        while(rs.next()) {
                            int id = rs.getInt("id");
                            int numero = rs.getInt("numero_semana");
                            String titulo = rs.getString("titulo_semana");
                            String descripcion = rs.getString("descripcion");
                %>
                <tr>
                    <td class="ps-4 fw-bold" style="color: var(--brand-green); font-size: 1.2rem;"><%= numero %></td>
                    <td class="fw-bold" style="color: #fff;"><%= titulo %></td>
                    <td class="text-muted small" style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= descripcion %></td>
                    <td class="text-end pe-4">
                        <!-- Botón Editar -->
                        <button class="btn btn-sm py-1 px-2 me-1" data-bs-toggle="modal" data-bs-target="#modalEditar<%= id %>" style="background: rgba(0, 212, 255, 0.1); border: 1px solid var(--brand-cyan); color: var(--brand-cyan); transition: 0.3s;" onmouseover="this.style.background='var(--brand-cyan)'; this.style.color='#000';" onmouseout="this.style.background='rgba(0, 212, 255, 0.1)'; this.style.color='var(--brand-cyan)';">✏️</button>
                        
                        <!-- Botón Eliminar -->
                        <button class="btn btn-sm py-1 px-2" data-bs-toggle="modal" data-bs-target="#modalEliminar<%= id %>" style="background: rgba(255, 0, 123, 0.1); border: 1px solid var(--brand-pink); color: var(--brand-pink); transition: 0.3s;" onmouseover="this.style.background='var(--brand-pink)'; this.style.color='#fff';" onmouseout="this.style.background='rgba(255, 0, 123, 0.1)'; this.style.color='var(--brand-pink)';">❌</button>
                    </td>
                </tr>

                <!-- MODAL EDITAR SEMANA -->
                <div class="modal fade" id="modalEditar<%= id %>" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content" style="background-color: var(--bg-card); border: 1px solid var(--brand-cyan); border-radius: 16px;">
                            <div class="modal-header" style="border-bottom: 1px solid var(--border-color);">
                                <h5 class="modal-title" style="color: var(--brand-cyan); font-family: 'Poppins'; font-weight: 600;">Editar Semana</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="EditarSemanaServlet" method="POST">
                                <div class="modal-body p-4">
                                    <input type="hidden" name="idSemana" value="<%= id %>">
                                    <div class="mb-3">
                                        <label class="form-label" style="color: var(--text-muted);">Número de Semana</label>
                                        <input type="number" class="form-control" name="numero" value="<%= numero %>" required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" style="color: var(--text-muted);">Título de la Fase</label>
                                        <input type="text" class="form-control" name="titulo" value="<%= titulo %>" required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" style="color: var(--text-muted);">Descripción</label>
                                        <textarea class="form-control" name="descripcion" rows="3" required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;"><%= descripcion %></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer" style="border-top: 1px solid var(--border-color);">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn" style="background: var(--brand-cyan); color: #000; font-weight: 600;">Guardar Cambios</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- MODAL ELIMINAR SEMANA -->
                <div class="modal fade" id="modalEliminar<%= id %>" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content" style="background-color: var(--bg-card); border: 1px solid var(--brand-pink); border-radius: 16px;">
                            <div class="modal-header" style="border-bottom: 1px solid var(--border-color);">
                                <h5 class="modal-title" style="color: var(--brand-pink); font-family: 'Poppins'; font-weight: 600;">⚠️ Confirmar Eliminación</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-4 text-center">
                                <p style="color: #fff;">¿Estás seguro de que deseas eliminar la <strong>Semana <%= numero %></strong>?</p>
                                <p style="color: var(--brand-pink); font-size: 0.85rem;">Nota: Se perderán las evidencias asociadas a esta semana.</p>
                            </div>
                            <div class="modal-footer" style="border-top: 1px solid var(--border-color);">
                                <form action="EliminarSemanaServlet" method="POST">
                                    <input type="hidden" name="idSemana" value="<%= id %>">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn" style="background: var(--brand-pink); color: #fff; font-weight: 600;">Sí, Eliminar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='4' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL CREAR SEMANA -->
<div class="modal fade" id="modalCrearSemana" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background-color: var(--bg-card); border: 1px solid var(--brand-green); border-radius: 16px;">
            <div class="modal-header" style="border-bottom: 1px solid var(--border-color);">
                <h5 class="modal-title" style="color: var(--brand-green); font-family: 'Poppins'; font-weight: 600;">➕ Nueva Semana</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="CrearSemanaServlet" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label" style="color: var(--text-muted);">Número de Semana (Ej. 1, 2, 3...)</label>
                        <input type="number" class="form-control" name="numero" required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="color: var(--text-muted);">Título de la Fase</label>
                        <input type="text" class="form-control" name="titulo" placeholder="Ej. Introducción al Curso" required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="color: var(--text-muted);">Descripción</label>
                        <textarea class="form-control" name="descripcion" rows="3" placeholder="Resumen de los temas tratados..." required style="background: var(--bg-base); border: 1px solid var(--border-color); color: #fff;"></textarea>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 1px solid var(--border-color);">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn" style="background: var(--brand-green); color: #000; font-weight: 600;">Crear Fase</button>
                </div>
            </form>
        </div>
    </div>
</div>