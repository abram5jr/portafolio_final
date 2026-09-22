<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>

<div class="section-header">
    <span class="section-subtitle">CONTROL DE ACCESO</span>
    <h2 class="section-title">GESTOR DE <span class="text-cyan" style="color: #fff !important; text-shadow: 0 0 10px #fff;">ROLES</span></h2>
    <p class="section-desc">Agrega nuevos administradores o estudiantes al sistema.</p>
</div>

<div class="row g-4">
    <!-- 1. FORMULARIO DE REGISTRO -->
    <div class="col-lg-4">
        <div class="admin-card h-100" style="border-color: #fff;">
            <div class="admin-card-header" style="border-color: #fff; color: #fff;">
                <h5 class="m-0" style="font-size: 1.1rem;">👤 NUEVO USUARIO</h5>
            </div>
            <div class="card-body p-4">
                <!-- Apuntamos al nuevo Servlet -->
                <form action="RegistroUsuarioServlet" method="POST">
                    <div class="mb-4">
                        <label class="form-label" style="color: #ccc;">Nombre de Usuario</label>
                        <input type="email" class="form-control" name="usuario" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" style="color: #ccc;">Contraseña</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-5">
                        <label class="form-label" style="color: #ccc;">Asignar Rol</label>
                        <select class="form-select" name="rol" required>
                            <option value="ADMINISTRADOR">Administrador</option>
                            <option value="ESTUDIANTE" selected>Estudiante</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-neon w-100 py-2" style="border: 2px solid #fff; color: #fff;">CREAR CUENTA</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 2. TABLA DINÁMICA DE USUARIOS -->
    <div class="col-lg-8">
        <div class="admin-card h-100" style="border-color: #fff;">
            <div class="admin-card-header" style="border-color: #fff; color: #fff;">
                <h5 class="m-0" style="font-size: 1.1rem;">👥 USUARIOS REGISTRADOS</h5>
            </div>
            <div class="card-body p-4 table-responsive">
                <table class="table table-dark table-hover text-white m-0">
                    <thead>
                        <tr>
                            <th style="border-bottom-color: #fff; color: #fff;">USUARIO</th>
                            <th style="border-bottom-color: #fff; color: #fff;">ROL</th>
                            <th class="text-end" style="border-bottom-color: #fff; color: #fff;">ACCIÓN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Conexion conexionDB = new Conexion();
                                Connection con = conexionDB.getConnection();
                                
                                // Consultamos a la tabla usuarios
                                String sql = "SELECT id, usuario, rol FROM usuarios ORDER BY id ASC";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ResultSet rs = ps.executeQuery();
                                
                                while(rs.next()) {
                                    int idUser = rs.getInt("id");
                                    String nombreUser = rs.getString("usuario");
                                    String rolUser = rs.getString("rol");
                                    
                                    // Estilo condicional según el rol
                                    String badgeStyle = "";
                                    if(rolUser != null && rolUser.equals("ADMINISTRADOR")) {
                                        badgeStyle = "background: rgba(57, 255, 20, 0.2); color: var(--neon-green); border: 1px solid var(--neon-green);";
                                    } else {
                                        badgeStyle = "background: rgba(0, 243, 255, 0.2); color: var(--neon-cyan); border: 1px solid var(--neon-cyan);";
                                    }
                        %>
                                <tr>
                                    <td class="fw-bold"><%= nombreUser %></td>
                                    <td><span class="badge" style="<%= badgeStyle %>"><%= (rolUser != null) ? rolUser : "ESTUDIANTE" %></span></td>
                                    <td class="text-end">
                                        <!-- Botón de eliminar provisional (lo conectaremos luego) -->
                                        <button class="btn btn-sm btn-neon btn-danger-neon py-0 px-2" title="Eliminar Usuario">❌</button>
                                    </td>
                                </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.print("<tr><td colspan='3'>Error al cargar usuarios: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>