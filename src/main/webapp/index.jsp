<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, config.Conexion" %>
<%
    // Variables por defecto en caso de que la base de datos falle
    String pubNombre = "Abraham Parejas Araujo";
    String pubProfesion = "Estudiante de Diseño y Programación Web | IESTP Andrés A. Cáceres Dorregaray";
    String pubSobreMi = "Soy un apasionado por la intersección entre el desarrollo web y la psicología visual. Me enfoco en aplicar exclusivamente la ley de anexo de Gestalt para crear interfaces intuitivas y equilibradas, tal como lo implementé en la creación de identidad para la tienda virtual Wasi. Además, busco constantemente la formalización profesional, manteniéndome actualizado tanto en nuevas tecnologías de desarrollo como en procesos administrativos y tributarios para ofrecer soluciones integrales.";
    
    try {
        Conexion conexionDB = new Conexion();
        Connection con = conexionDB.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM perfil WHERE id = 1");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            pubNombre = rs.getString("nombre");
            pubProfesion = rs.getString("profesion");
            pubSobreMi = rs.getString("sobre_mi");
        }
    } catch (Exception e) { 
        // Si hay error de conexión, se mostrarán los datos por defecto de arriba
        System.out.println("Error cargando perfil: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="dark">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil | <%= pubNombre %></title>
    
    <!-- Librerías de Fuentes e Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/devicon.min.css" />
    
    <style>
        :root {
            --neon-cyan: #00f3ff;
            --neon-purple: #bc13fe;
            --neon-green: #39ff14;
            --bg-dark: #09090b;
            --card-bg: #121218;
        }

        body { 
            background-color: var(--bg-dark); 
            color: #e0e0e0; 
            font-family: 'Poppins', sans-serif; 
            background-image: radial-gradient(circle at center, #1a1a24 0%, #09090b 100%);
        }

        h1, h4, h5, .navbar-brand { font-family: 'Orbitron', sans-serif; text-transform: uppercase; text-shadow: 0 0 10px currentColor; letter-spacing: 2px; font-weight: 700; }
        .text-primary { color: var(--neon-cyan) !important; }
        .text-success { color: var(--neon-green) !important; }

        .navbar { background-color: rgba(9, 9, 11, 0.95) !important; border-bottom: 2px solid var(--neon-purple); box-shadow: 0 0 15px rgba(188, 19, 254, 0.5); }
        .nav-link { font-family: 'Orbitron', sans-serif; color: #e0e0e0 !important; font-size: 0.9rem; letter-spacing: 1px; text-transform: uppercase; transition: all 0.3s ease; }
        .nav-link:hover { color: var(--neon-cyan) !important; text-shadow: 0 0 8px var(--neon-cyan); }

        .hero-section { padding: 140px 0 80px; }
        .profile-img { width: 200px; height: 200px; object-fit: cover; border-radius: 10px; border: 3px solid var(--neon-cyan); box-shadow: 0 0 25px rgba(0, 243, 255, 0.5); }

        /* Iconos de Redes Sociales */
        .social-icon {
            transition: all 0.3s ease;
            text-shadow: 0 0 15px currentColor;
            opacity: 0.8;
        }
        .social-icon:hover {
            transform: translateY(-5px) scale(1.15);
            opacity: 1;
            filter: brightness(1.2);
        }

        /* Tarjetas de Herramientas (Tech Stack) */
        .tech-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid #333;
            border-radius: 12px;
            width: 110px;
            height: 110px;
            transition: all 0.3s ease;
        }
        .tech-item i {
            font-size: 3rem;
            transition: all 0.3s ease;
        }
        .tech-item span {
            font-family: 'Orbitron', sans-serif;
            font-size: 0.65rem;
            color: #888;
            letter-spacing: 1px;
            text-align: center;
            transition: all 0.3s ease;
        }
        .tech-item:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 5px 15px rgba(0,0,0,0.5), inset 0 0 15px rgba(0, 243, 255, 0.1);
            transform: translateY(-5px);
            background: rgba(0, 243, 255, 0.05);
        }
        .tech-item:hover span {
            color: #fff;
            text-shadow: 0 0 5px var(--neon-cyan);
        }
        .tech-item:hover i {
            filter: drop-shadow(0 0 8px currentColor);
        }

        .btn { font-family: 'Orbitron', sans-serif; font-weight: 700; letter-spacing: 1px; border-radius: 4px; }
        .btn-primary { background-color: transparent; border: 2px solid var(--neon-purple); color: var(--neon-purple); text-transform: uppercase; transition: 0.3s; }
        .btn-primary:hover { background-color: var(--neon-purple); color: #fff; box-shadow: 0 0 20px var(--neon-purple); }

        .footer { padding: 30px 0; margin-top: 60px; border-top: 2px solid var(--neon-purple); font-family: 'Orbitron', sans-serif; letter-spacing: 1px;}
    </style>
</head>
<body>

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

<section class="hero-section text-center">
    <div class="container">
        <!-- Foto de Perfil -->
        <img src="img/perfil.jpg" alt="Foto de perfil" class="profile-img mb-4" onerror="this.src='https://via.placeholder.com/200'">
        
        <!-- Nombre y Título Dinámicos -->
        <h1 class="text-primary mb-2" style="font-size: 2.2rem;"><%= pubNombre %></h1>
        <p class="lead text-success fw-bold mb-4" style="font-family: 'Orbitron', sans-serif; letter-spacing: 1px; font-size: 1rem;"><%= pubProfesion %></p>
        
        <!-- Redes Sociales Neón -->
        <div class="d-flex justify-content-center gap-4 mb-5">
            <a href="#" target="_blank" class="social-icon" style="color: #25D366;" title="WhatsApp"><i class="fa-brands fa-whatsapp fa-2x"></i></a>
            <a href="#" target="_blank" class="social-icon" style="color: #1877F2;" title="Facebook"><i class="fa-brands fa-facebook fa-2x"></i></a>
            <a href="#" target="_blank" class="social-icon" style="color: #ffffff;" title="TikTok"><i class="fa-brands fa-tiktok fa-2x"></i></a>
            <a href="#" target="_blank" class="social-icon" style="color: #E1306C;" title="Instagram"><i class="fa-brands fa-instagram fa-2x"></i></a>
            <a href="#" target="_blank" class="social-icon" style="color: #ffffff;" title="GitHub"><i class="fa-brands fa-github fa-2x"></i></a>
        </div>
        
        <div class="row justify-content-center mt-4">
            <div class="col-md-9 text-center">
                <h4 class="mb-3" style="color: var(--neon-purple); font-size: 1.4rem;">Sobre Mí</h4>
                
                <!-- Descripción Dinámica -->
                <p><%= pubSobreMi %></p>
                
                <h4 class="mt-5 mb-4" style="color: var(--neon-cyan); font-size: 1.4rem;">Tech Stack & Herramientas</h4>
                
                <!-- Grid de Iconos Tech -->
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <div class="tech-item">
                        <i class="devicon-html5-plain colored"></i>
                        <span>HTML5</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-css3-plain colored"></i>
                        <span>CSS3</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-javascript-plain colored"></i>
                        <span>JavaScript</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-bootstrap-plain colored"></i>
                        <span>Bootstrap 5</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-java-plain colored"></i>
                        <span>Java JSP</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-firebase-plain colored"></i>
                        <span>Firebase</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-netlify-plain colored"></i>
                        <span>Netlify</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-flutter-plain colored"></i>
                        <span>FlutterFlow</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-android-plain colored"></i>
                        <span>Kodular</span>
                    </div>
                    <div class="tech-item">
                        <i class="devicon-apache-plain colored"></i>
                        <span>JMeter</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer text-center text-secondary">
    <div class="container">
        <p class="mb-1 small">© 2026 <%= pubNombre %>.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>