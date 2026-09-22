<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="dark">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactos | Abraham Parejas Araujo</title>
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
            background-color: var(--bg-dark); 
            color: #e0e0e0; 
            font-family: 'Poppins', sans-serif; 
            background-image: radial-gradient(circle at center, #1a1a24 0%, #09090b 100%);
        }

        h1, h2, h4, h5, .navbar-brand { font-family: 'Orbitron', sans-serif; text-transform: uppercase; text-shadow: 0 0 10px currentColor; letter-spacing: 2px; font-weight: 700; }
        .text-primary { color: var(--neon-cyan) !important; }

        .navbar { background-color: rgba(9, 9, 11, 0.95) !important; border-bottom: 2px solid var(--neon-purple); box-shadow: 0 0 15px rgba(188, 19, 254, 0.5); }
        .nav-link { font-family: 'Orbitron', sans-serif; color: #e0e0e0 !important; font-size: 0.9rem; letter-spacing: 1px; text-transform: uppercase; transition: all 0.3s ease; }
        .nav-link:hover { color: var(--neon-cyan) !important; text-shadow: 0 0 8px var(--neon-cyan); }

        .btn { font-family: 'Orbitron', sans-serif; font-weight: 700; letter-spacing: 1px; border-radius: 4px; }
        .btn-primary { background-color: transparent; border: 2px solid var(--neon-purple); color: var(--neon-purple); text-transform: uppercase; transition: 0.3s; }
        .btn-primary:hover { background-color: var(--neon-purple); color: #fff; box-shadow: 0 0 20px var(--neon-purple); }

        .footer { padding: 30px 0; margin-top: 60px; border-top: 2px solid var(--neon-purple); font-family: 'Orbitron', sans-serif; letter-spacing: 1px;}
    </style>
</head>
<body>

<!-- MENÚ SUPERIOR -->
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
                <li class="nav-item px-3"><a class="nav-link" style="color: var(--neon-cyan) !important;" href="contactos.jsp">Contactos</a></li>
            </ul>
            <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0">
                <a href="login.jsp" class="btn btn-primary btn-sm px-4 shadow-sm" style="text-decoration: none;">
                    🔒 Iniciar Sesión
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- SECCIÓN CONTACTOS -->
<section class="container" style="margin-top: 120px; margin-bottom: 80px;">
    <div class="text-center mb-5">
        <h2 class="text-cyan" style="color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; text-transform: uppercase; letter-spacing: 2px; text-shadow: 0 0 8px rgba(0, 243, 255, 0.4);">
            CONTÁCTAME
        </h2>
        <p class="text-secondary" style="font-family: 'Poppins', sans-serif;">¿Tienes un proyecto en mente? Envíame un mensaje y hablemos.</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-7">
            <!-- Tarjeta Neón -->
            <div class="card bg-transparent" style="border: 1px solid var(--neon-cyan); box-shadow: 0 0 15px rgba(0, 243, 255, 0.15); border-radius: 8px;">
                <div class="card-body p-5">
                    
                    <form action="EnviarMensajeServlet" method="POST">
                        <div class="mb-4">
                            <label class="form-label" style="color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-size: 0.85rem;">TU NOMBRE</label>
                            <input type="text" class="form-control" name="remitente" required 
                                   style="background-color: #09090b; border: 1px solid #333; color: #fff; font-family: 'Poppins', sans-serif;"
                                   onfocus="this.style.borderColor='var(--neon-cyan)'; this.style.boxShadow='0 0 10px rgba(0, 243, 255, 0.3)';" 
                                   onblur="this.style.borderColor='#333'; this.style.boxShadow='none';">
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label" style="color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-size: 0.85rem;">TU CORREO</label>
                            <input type="email" class="form-control" name="correo" required 
                                   style="background-color: #09090b; border: 1px solid #333; color: #fff; font-family: 'Poppins', sans-serif;"
                                   onfocus="this.style.borderColor='var(--neon-cyan)'; this.style.boxShadow='0 0 10px rgba(0, 243, 255, 0.3)';" 
                                   onblur="this.style.borderColor='#333'; this.style.boxShadow='none';">
                        </div>

                        <div class="mb-4">
                            <label class="form-label" style="color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-size: 0.85rem;">ASUNTO / MENSAJE</label>
                            <textarea class="form-control" name="mensaje" rows="4" required 
                                      style="background-color: #09090b; border: 1px solid #333; color: #fff; font-family: 'Poppins', sans-serif;"
                                      onfocus="this.style.borderColor='var(--neon-cyan)'; this.style.boxShadow='0 0 10px rgba(0, 243, 255, 0.3)';" 
                                      onblur="this.style.borderColor='#333'; this.style.boxShadow='none';"></textarea>
                        </div>
                        
                        <div class="text-end mt-4">
                            <button type="submit" class="btn fw-bold px-5 py-2" 
                                    style="background-color: transparent; border: 2px solid var(--neon-cyan); color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; transition: 0.3s;"
                                    onmouseover="this.style.backgroundColor='var(--neon-cyan)'; this.style.color='#000'; this.style.boxShadow='0 0 20px var(--neon-cyan)';" 
                                    onmouseout="this.style.backgroundColor='transparent'; this.style.color='var(--neon-cyan)'; this.style.boxShadow='none';">
                                ENVIAR
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer text-center text-secondary">
    <div class="container">
        <p class="mb-1 small">© 2026 Abraham Parejas Araujo.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>