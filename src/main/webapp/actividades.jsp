<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="dark">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actividades | Portafolio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --neon-cyan: #00f3ff;
            --neon-purple: #bc13fe;
            --neon-green: #39ff14;
            --bg-dark: #09090b;
            --card-bg: #121218;
        }

        body { 
            background-color: transparent; 
            color: #e0e0e0; 
            font-family: 'Poppins', sans-serif; 
            margin: 0;
            overflow-x: hidden;
        }

        /* --- INICIO DEL FONDO COMBINADO (MANCHAS + BURBUJAS BRILLANTES) --- */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: -1;
            background-color: var(--bg-dark);
            background-image: radial-gradient(circle at center, #1a1a24 0%, #09090b 100%);
            overflow: hidden;
        }

        .corner-glow {
            position: absolute;
            border-radius: 50%;
            filter: blur(150px);
            opacity: 0.6;
            z-index: 0;
        }
        .glow-purple {
            width: 50vw;
            height: 50vw;
            max-width: 600px;
            max-height: 600px;
            background: var(--neon-purple);
            top: -20%;
            left: -10%;
        }
        .glow-cyan {
            width: 55vw;
            height: 55vw;
            max-width: 700px;
            max-height: 700px;
            background: var(--neon-cyan);
            bottom: -20%;
            right: -10%;
        }

        .bubble {
            position: absolute;
            border-radius: 50%;
            z-index: 1;
            animation: floatUp infinite ease-in;
            opacity: 0;
            filter: blur(1px);
        }

        .bubble-1 { width: 35px; height: 35px; background: rgba(0, 243, 255, 0.7); box-shadow: 0 0 15px var(--neon-cyan); left: 15%; animation-duration: 12s; animation-delay: 0s; }
        .bubble-2 { width: 55px; height: 55px; background: rgba(188, 19, 254, 0.7); box-shadow: 0 0 15px var(--neon-purple); left: 35%; animation-duration: 15s; animation-delay: 3s; }
        .bubble-3 { width: 25px; height: 25px; background: rgba(57, 255, 20, 0.7); box-shadow: 0 0 15px var(--neon-green); left: 55%; animation-duration: 10s; animation-delay: 1s; }
        .bubble-4 { width: 65px; height: 65px; background: rgba(0, 243, 255, 0.7); box-shadow: 0 0 15px var(--neon-cyan); left: 75%; animation-duration: 18s; animation-delay: 5s; }
        .bubble-5 { width: 45px; height: 45px; background: rgba(188, 19, 254, 0.7); box-shadow: 0 0 15px var(--neon-purple); left: 85%; animation-duration: 14s; animation-delay: 2s; }
        .bubble-6 { width: 40px; height: 40px; background: rgba(0, 243, 255, 0.7); box-shadow: 0 0 15px var(--neon-cyan); left: 5%; animation-duration: 16s; animation-delay: 6s; }

        @keyframes floatUp {
            0% { transform: translateY(110vh) scale(0.5); opacity: 0; }
            20% { opacity: 0.85; }
            80% { opacity: 0.85; }
            100% { transform: translateY(-10vh) scale(1.2); opacity: 0; }
        }
        /* --- FIN DEL FONDO COMBINADO --- */

        h2, h4, h5, h6, .navbar-brand { font-family: 'Orbitron', sans-serif; text-transform: uppercase; text-shadow: 0 0 10px currentColor; letter-spacing: 2px; font-weight: 700; }
        .text-primary { color: var(--neon-cyan) !important; }
        
        .navbar { background-color: rgba(9, 9, 11, 0.95) !important; border-bottom: 2px solid var(--neon-purple); box-shadow: 0 0 15px rgba(188, 19, 254, 0.5); }
        .nav-link { font-family: 'Orbitron', sans-serif; color: #e0e0e0 !important; font-size: 0.9rem; letter-spacing: 1px; text-transform: uppercase; transition: all 0.3s ease; }
        .nav-link:hover { color: var(--neon-cyan) !important; text-shadow: 0 0 8px var(--neon-cyan); }

        .btn-nav-login { background-color: transparent; border: 2px solid var(--neon-purple); color: var(--neon-purple); font-family: 'Orbitron', sans-serif; text-transform: uppercase; transition: 0.3s; }
        .btn-nav-login:hover { background-color: var(--neon-purple); color: #fff; box-shadow: 0 0 20px var(--neon-purple); }

        /* --- REDISEÑO DE LAS TARJETAS DE SEMANA --- */
        .semana-card {
            border: 2px solid rgba(57, 255, 20, 0.3); /* Borde inicial más sutil */
            border-radius: 12px;
            background: rgba(18, 18, 24, 0.6); /* Efecto Glassmorphism */
            backdrop-filter: blur(8px);
            min-height: 250px;
            display: flex;
            flex-direction: column;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); /* Animación más fluida */
            position: relative;
            overflow: hidden; /* Para contener brillos internos si se añaden */
        }
        
        .semana-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(57,255,20,0.1) 0%, transparent 50%, rgba(0,243,255,0.1) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .semana-card:hover {
            border-color: var(--neon-green);
            box-shadow: 0 0 25px rgba(57, 255, 20, 0.4), inset 0 0 15px rgba(57, 255, 20, 0.1);
            transform: translateY(-8px) scale(1.02);
        }

        .semana-card:hover::before {
            opacity: 1;
        }

        .semana-header {
            border-bottom: 2px dashed rgba(57, 255, 20, 0.4);
            color: var(--neon-green);
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            padding: 18px;
            text-align: center;
            letter-spacing: 3px;
            text-shadow: 0 0 5px rgba(57, 255, 20, 0.5);
            background: rgba(0,0,0,0.2); /* Oscurece un poco el header */
        }
        
        .semana-body {
            padding: 25px;
            text-align: center;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative; /* Para asegurar que el texto quede sobre el ::before */
            z-index: 1;
        }

        /* Títulos y textos dentro de la tarjeta */
        .semana-body h5 {
            color: #fff;
            text-shadow: 0 0 8px rgba(255,255,255,0.3);
        }

        /* VISTA PREVIA ANIMADA (Aparece en Hover) */
        .preview-archivos {
            max-height: 0;
            opacity: 0;
            visibility: hidden;
            overflow: hidden;
            transition: all 0.4s ease-in-out;
            text-align: left;
            background: rgba(0,0,0,0.3); /* Fondo para la vista previa */
            border-radius: 6px;
            padding: 0 10px; /* Padding animado */
        }
        .semana-card:hover .preview-archivos {
            max-height: 180px; 
            opacity: 1;
            visibility: visible;
            margin-top: 15px;
            padding: 10px;
            border: 1px solid rgba(0, 243, 255, 0.2);
        }
        .preview-item {
            font-size: 0.75rem;
            color: #ddd;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis; 
            margin-bottom: 5px;
            border-left: 2px solid var(--neon-cyan);
            padding-left: 8px;
        }

        /* Botón de la tarjeta */
        .btn-detalles {
            background-color: transparent;
            border: 2px solid var(--neon-cyan);
            color: var(--neon-cyan);
            font-family: 'Orbitron', sans-serif;
            font-size: 0.9rem;
            letter-spacing: 2px;
            transition: all 0.3s ease;
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            text-transform: uppercase;
            border-radius: 6px;
            font-weight: 700;
        }
        .btn-detalles:hover {
            background-color: var(--neon-cyan);
            color: #000;
            box-shadow: 0 0 20px rgba(0, 243, 255, 0.6);
            transform: scale(1.05);
        }

        /* PANTALLA EMERGENTE Y CONTENEDORES DE ARCHIVOS */
        .modal-content {
            background-color: var(--card-bg); 
            border: 2px solid var(--neon-cyan); 
            box-shadow: 0 0 35px rgba(0, 243, 255, 0.2);
        }
        .modal-header { border-bottom: 1px dashed var(--neon-cyan); padding: 20px 30px;}
        .modal-title { color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-size: 1.3rem; }
        
        .archivo-box {
            background-color: rgba(255, 255, 255, 0.03);
            border: 1px solid #333;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 12px;
            transition: 0.3s;
            word-wrap: break-word;
            word-break: break-all;
            white-space: normal;
        }
        .archivo-box:hover {
            border-color: var(--neon-cyan);
            background-color: rgba(0, 243, 255, 0.05);
        }

        .btn-action-view {
            border: 1px solid var(--neon-cyan);
            color: var(--neon-cyan);
            background: transparent;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-family: 'Orbitron', sans-serif;
            transition: 0.3s;
        }
        .btn-action-view:hover { background: var(--neon-cyan); color: #000; }

        .btn-action-download {
            border: 1px solid var(--neon-purple);
            color: var(--neon-purple);
            background: transparent;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-family: 'Orbitron', sans-serif;
            transition: 0.3s;
        }
        .btn-action-download:hover { background: var(--neon-purple); color: #fff; }
    </style>
</head>
<body>

<!-- CONTENEDOR DEL FONDO: MANCHAS Y BURBUJAS -->
<div class="animated-bg">
    <div class="corner-glow glow-purple"></div>
    <div class="corner-glow glow-cyan"></div>
    <div class="bubble bubble-1"></div>
    <div class="bubble bubble-2"></div>
    <div class="bubble bubble-3"></div>
    <div class="bubble bubble-4"></div>
    <div class="bubble bubble-5"></div>
    <div class="bubble bubble-6"></div>
</div>

<nav class="navbar navbar-expand-lg fixed-top shadow-sm">
    <div class="container">
        <span class="navbar-brand text-primary fs-5">MI PORTAFOLIO</span>
        <button class="navbar-toggler border-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item px-3"><a class="nav-link" href="index.jsp">Mi Perfil</a></li>
                <li class="nav-item px-3"><a class="nav-link" href="actividades.jsp">Actividades</a></li>
                <li class="nav-item px-3"><a class="nav-link" href="contactos.jsp">Contactos</a></li>
            </ul>
            <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0">
                <a href="login.jsp" class="btn btn-primary btn-sm px-4 shadow-sm" style="text-decoration: none;">
                    🔒 Iniciar Sesión
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container" style="margin-top: 140px; margin-bottom: 80px;">
    <h2 class="text-primary text-center mb-5" style="font-size: 2.2rem;">EVIDENCIAS POR SEMANA</h2>

    <div class="row g-4">
        <%
            try {
                Conexion conexionDB = new Conexion();
                Connection con = conexionDB.getConnection();
                
                String sqlSemanas = "SELECT * FROM semanas ORDER BY numero_semana ASC";
                PreparedStatement psSemanas = con.prepareStatement(sqlSemanas);
                ResultSet rsSemanas = psSemanas.executeQuery();
                
                while(rsSemanas.next()) {
                    int idSemana = rsSemanas.getInt("id");
                    int numeroSemana = rsSemanas.getInt("numero_semana");
                    String tituloSemana = rsSemanas.getString("titulo_semana");
                    String descripcion = rsSemanas.getString("descripcion");
        %>
            
            <div class="col-md-4">
                <!-- TARJETA PRINCIPAL -->
                <div class="semana-card">
                    <div class="semana-header">
                        SEMANA <%= numeroSemana %>
                    </div>
                    <div class="semana-body">
                        <div>
                            <h5 class="mb-3" style="font-size: 1.1rem; text-transform: uppercase;"><%= tituloSemana %></h5>
                            <p class="text-secondary small m-0" style="line-height: 1.6;"><%= descripcion %></p>
                            
                            <!-- SECCIÓN QUE APARECE SOLO AL PASAR EL MOUSE -->
                            <div class="preview-archivos pt-2 mt-2">
                                <span class="d-block mb-2 text-muted" style="font-family: 'Orbitron'; font-size: 0.7rem; letter-spacing: 1px;">VISTA PREVIA:</span>
                                
                                <%
                                    // Variables para el modal y la vista previa
                                    String sqlEvidencias = "SELECT * FROM evidencias WHERE semana_id = ?";
                                    PreparedStatement psEvidencias = con.prepareStatement(sqlEvidencias);
                                    psEvidencias.setInt(1, idSemana);
                                    ResultSet rsEvidencias = psEvidencias.executeQuery();
                                    
                                    StringBuilder htmlActividades = new StringBuilder();
                                    StringBuilder htmlTareas = new StringBuilder();
                                    StringBuilder htmlPreview = new StringBuilder();
                                    
                                    boolean hayActividades = false;
                                    boolean hayTareas = false;
                                    boolean hayPreview = false;
                                    
                                    while(rsEvidencias.next()) {
                                        String categoria = rsEvidencias.getString("categoria_archivo");
                                        String nombreArc = rsEvidencias.getString("nombre_archivo");
                                        String rutaArc = rsEvidencias.getString("ruta_archivo");
                                        
                                        // Armamos la vista previa compacta para la tarjeta (Hover)
                                        hayPreview = true;
                                        String icono = categoria.equals("ACTIVIDAD") ? "📄" : "🖼️";
                                        htmlPreview.append("<div class='preview-item'>").append(icono).append(" ").append(nombreArc).append("</div>");
                                        
                                        // Armamos los bloques complejos para la pantalla emergente
                                        String botones = "<div class='mt-3 d-flex gap-2'>" +
                                                         "<a href='" + rutaArc + "' target='_blank' class='btn btn-action-view py-1 px-3'>👁️ Visualizar</a>" +
                                                         "<a href='" + rutaArc + "' download class='btn btn-action-download py-1 px-3'>⬇️ Descargar</a>" +
                                                         "</div>";
                                        
                                        String itemHTML = "<div class='archivo-box'>" +
                                                          "<span class='text-white' style='font-size: 0.9rem;'>" + nombreArc + "</span>" +
                                                          botones + 
                                                          "</div>";
                                        
                                        if(categoria.equals("ACTIVIDAD")) {
                                            htmlActividades.append(itemHTML);
                                            hayActividades = true;
                                        } else if(categoria.equals("TAREA")) {
                                            htmlTareas.append(itemHTML);
                                            hayTareas = true;
                                        }
                                    }
                                    
                                    // Pintamos la lista en el hover
                                    if(hayPreview) {
                                        out.print(htmlPreview.toString());
                                    } else {
                                        out.print("<div class='preview-item fst-italic' style='border-left-color: #555;'>Sin archivos asignados.</div>");
                                    }
                                %>
                            </div>
                        </div>
                        
                        <!-- EL BOTÓN SE MANTIENE SIEMPRE VISIBLE ABAJO -->
                        <button type="button" class="btn btn-detalles" data-bs-toggle="modal" data-bs-target="#modalSemana<%= idSemana %>">
                            VER DETALLES
                        </button>
                    </div>
                </div>
            </div>

            <!-- MODAL AMPLIADO (Pantalla Emergente) -->
            <div class="modal fade" id="modalSemana<%= idSemana %>" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">SEMANA <%= numeroSemana %> - RECURSOS Y EVIDENCIAS</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-4">
                            
                            <div class="row">
                                <!-- PANEL IZQUIERDO: TEXTOS DESCRIPTIVOS -->
                                <div class="col-lg-5 border-end border-secondary mb-4 mb-lg-0 pe-lg-4">
                                    <h6 class="text-white mb-2" style="font-family: 'Orbitron'; font-size: 0.85rem;">TEMA A TRATAR:</h6>
                                    <p class="text-secondary small mb-4"><%= tituloSemana %></p>
                                    
                                    <h6 class="text-white mb-2" style="font-family: 'Orbitron'; font-size: 0.85rem;">DESCRIPCIÓN DE LA FASE:</h6>
                                    <p class="text-secondary small mb-4"><%= descripcion %></p>

                                    <h6 class="text-white mb-2" style="font-family: 'Orbitron'; font-size: 0.85rem; border-top: 1px dashed var(--neon-purple); padding-top: 15px;">ENFOQUE TÉCNICO:</h6>
                                    <p class="text-secondary" style="font-size: 0.8rem; line-height: 1.7;">
                                        Durante el desarrollo de esta fase, el enfoque principal radicó en la estructuración de la interfaz visual aplicando de forma exclusiva la <strong>ley de anexo</strong> (Gestalt). El objetivo de estos recursos es evidenciar una distribución espacial lógica, garantizando que el diseño web sea intuitivo, moderno y altamente funcional para el usuario final.
                                    </p>
                                </div>

                                <!-- PANEL DERECHO: ARCHIVOS SEPARADOS -->
                                <div class="col-lg-7 ps-lg-4">

                                    <!-- CONTENEDOR 1: ACTIVIDADES -->
                                    <div class="mb-4">
                                        <h6 class="mb-3" style="font-family: 'Orbitron'; font-size: 0.9rem; color: var(--neon-purple);">
                                            <span style="border-bottom: 2px solid var(--neon-purple); padding-bottom: 4px;">ACTIVIDADES</span>
                                        </h6>
                                        <% if(hayActividades) { out.print(htmlActividades.toString()); } else { %>
                                            <p class="text-secondary small fst-italic">No hay actividades registradas.</p>
                                        <% } %>
                                    </div>

                                    <!-- CONTENEDOR 2: TAREAS -->
                                    <div>
                                        <h6 class="mb-3" style="font-family: 'Orbitron'; font-size: 0.9rem; color: var(--neon-green);">
                                            <span style="border-bottom: 2px solid var(--neon-green); padding-bottom: 4px;">TAREAS ASIGNADAS</span>
                                        </h6>
                                        <% if(hayTareas) { out.print(htmlTareas.toString()); } else { %>
                                            <p class="text-secondary small fst-italic">No hay tareas registradas.</p>
                                        <% } %>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        <%
                }
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error al cargar la base de datos: " + e.getMessage() + "</div>");
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>