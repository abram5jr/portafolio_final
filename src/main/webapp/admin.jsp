<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="dark">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrativo | Mi Portafolio</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            /* Paleta extraída de la imagen de referencia */
            --bg-base: #06070b;          
            --bg-card: #0f111a;          
            --border-color: #1e2130;     
            
            --brand-purple: #a113ff;     
            --brand-cyan: #00d4ff;       
            --brand-pink: #ff007b;       
            --brand-green: #00e676;
            
            --text-main: #ffffff;
            --text-muted: #6e728e;       
        }

        body { 
            background-color: var(--bg-base); 
            color: var(--text-main); 
            font-family: 'Poppins', sans-serif; 
            margin: 0;
            overflow-x: hidden;
            display: flex;
            /* RESPLANDORES AMBIENTALES DE LA REFERENCIA */
            background-image: 
                radial-gradient(circle at 15% 20%, rgba(161, 19, 255, 0.12) 0%, transparent 35%),
                radial-gradient(circle at 85% 15%, rgba(0, 212, 255, 0.08) 0%, transparent 35%);
            background-attachment: fixed;
        }

        h1, h2, h3, h4, h5, h6, .brand-logo { font-family: 'Poppins', sans-serif; }

        /* =========================================
           SIDEBAR LATERAL
           ========================================= */
        .sidebar {
            background-color: transparent;
            width: 260px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            z-index: 1000;
        }

        .brand-logo { 
            padding: 30px 25px 25px 25px; 
            display: flex; 
            align-items: center; 
            gap: 12px; 
            font-weight: 700; 
            font-size: 1.4rem; 
            color: #fff; 
        }
        .brand-logo i { 
            color: var(--brand-purple); 
            font-size: 1.5rem;
            filter: drop-shadow(0 0 12px rgba(161, 19, 255, 0.6)); 
        }
        
        .nav-title { 
            padding: 0 25px; 
            font-size: 0.7rem; 
            color: var(--text-muted); 
            margin: 10px 0 15px; 
            font-weight: 500; 
            letter-spacing: 0.5px; 
        }
        
        .sidebar-link {
            display: flex; 
            align-items: center; 
            justify-content: space-between;
            padding: 12px 20px; 
            margin: 4px 20px 4px 0; 
            color: var(--text-muted); 
            text-decoration: none;
            font-size: 0.9rem; 
            border-radius: 0 10px 10px 0; 
            background: transparent; 
            border: none;
            border-left: 3px solid transparent;
            transition: 0.3s ease;
            width: calc(100% - 20px);
            text-align: left;
        }
        
        .sidebar-link-content { display: flex; align-items: center; gap: 12px; }
        .sidebar-link-content i { font-size: 1.1rem; width: 22px; text-align: center; }
        
        .sidebar-link:hover { color: #fff; }
        
        /* ACTIVO CON DEGRADADO NEÓN */
        .sidebar-link.active { 
            color: #fff; 
            background: linear-gradient(90deg, rgba(161, 19, 255, 0.15) 0%, transparent 100%);
            border-left: 3px solid var(--brand-purple);
            font-weight: 500; 
        }
        .sidebar-link.active i { 
            color: var(--brand-purple); 
            filter: drop-shadow(0 0 8px rgba(161, 19, 255, 0.6));
        }
        
        .badge-notification { 
            background-color: var(--brand-pink); 
            color: #fff; 
            font-size: 0.7rem; 
            padding: 3px 8px; 
            border-radius: 50px; 
            font-weight: 600; 
            box-shadow: 0 0 12px rgba(255, 0, 123, 0.5);
        }

        .sidebar-bottom-card {
            margin: auto 20px 25px 20px;
            padding: 0;
            background: transparent;
            text-align: center;
        }
        .sidebar-bottom-card p {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 15px;
            text-align: left;
        }
        .btn-logout { 
            display: block; width: 100%; padding: 12px; 
            background: linear-gradient(90deg, #9d00ff, #c933ff);
            color: #fff; border-radius: 8px; text-decoration: none; 
            font-size: 0.85rem; font-weight: 600;
            box-shadow: 0 5px 15px rgba(161, 19, 255, 0.3);
            transition: 0.3s; 
        }
        .btn-logout:hover { box-shadow: 0 8px 20px rgba(161, 19, 255, 0.5); color: #fff; }

        /* =========================================
           TOPBAR SUPERIOR
           ========================================= */
        .main-wrapper {
            margin-left: 260px;
            width: calc(100% - 260px);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .topbar {
            height: 80px;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: transparent;
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 999;
        }
        
        .search-box { position: relative; width: 350px; }
        .search-box i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 0.9rem;}
        .search-box input {
            width: 100%; background: var(--bg-base); border: 1px solid var(--border-color);
            border-radius: 20px; padding: 10px 15px 10px 40px; color: #fff; font-size: 0.85rem;
        }
        .search-box input:focus { outline: none; border-color: var(--brand-purple); }

        .topbar-right { display: flex; align-items: center; gap: 20px; }
        .topbar-icon { color: var(--text-muted); font-size: 1.2rem; cursor: pointer; transition: 0.3s; position: relative; }
        .topbar-icon:hover { color: #fff; }
        .topbar-icon .dot { position: absolute; top: 0px; right: 0px; width: 8px; height: 8px; background: var(--brand-pink); border-radius: 50%; box-shadow: 0 0 8px var(--brand-pink);}
        
        .user-profile { display: flex; align-items: center; gap: 12px; cursor: pointer; padding-left: 20px;}
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .user-name { font-size: 0.85rem; font-weight: 500; color: #fff; margin: 0; line-height: 1.2;}
        .user-role { font-size: 0.7rem; color: var(--text-muted); display: block; }

        /* =========================================
           TARJETAS PRINCIPALES Y OVERRIDES
           ========================================= */
        .main-content { padding: 35px 40px; flex-grow: 1; }

        .neon-card, .admin-card { 
            background-color: var(--bg-card) !important; 
            border: 1px solid var(--border-color) !important; 
            border-radius: 14px !important; 
            padding: 22px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.3) !important;
            transition: 0.3s;
        }
        .neon-card:hover { transform: translateY(-2px); border-color: #2a2e40 !important; }
        
        .section-title { font-size: 1.8rem; font-weight: 600; margin: 0 0 5px 0; color: #fff; font-family: 'Poppins', sans-serif;}
        .section-desc { color: var(--text-muted); font-size: 0.9rem; margin-top: 5px; max-width: 800px;}
        
        /* Botones, Tablas y Formularios para mantener vistas limpias */
        .admin-card-header { border-bottom: 1px solid var(--border-color) !important; padding-bottom: 15px; margin-bottom: 20px; color: #fff; }
        .form-label { font-size: 0.8rem; color: var(--text-muted); font-weight: 500; }
        .form-control, .form-select { background-color: var(--bg-base) !important; border: 1px solid var(--border-color) !important; color: #fff !important; border-radius: 8px; padding: 10px; }
        .form-control:focus, .form-select:focus { border-color: var(--brand-purple) !important; box-shadow: none !important; }
        .table-dark { background-color: transparent !important; }
        .table-dark th { border-bottom: 1px solid var(--border-color) !important; color: var(--text-muted); font-weight: 500; font-size: 0.8rem; text-transform: uppercase;}
        .table-dark td { border-bottom: 1px solid var(--border-color) !important; background-color: transparent !important; vertical-align: middle; font-size: 0.9rem; color: #fff;}
    </style>
</head>
<body>

<nav class="sidebar">
    <div class="brand-logo">
        <i class="fa-solid fa-layer-group"></i> MI PORTAFOLIO_
    </div>
    
    <div class="nav flex-column nav-pills mt-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <button class="sidebar-link active" id="tab-dashboard" data-bs-toggle="pill" data-bs-target="#pane-dashboard" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-solid fa-house"></i> Dashboard</div>
        </button>
        <button class="sidebar-link" id="tab-perfil" data-bs-toggle="pill" data-bs-target="#pane-perfil" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-regular fa-user"></i> Mi Perfil</div>
        </button>
        <button class="sidebar-link" id="tab-semanas" data-bs-toggle="pill" data-bs-target="#pane-semanas" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-regular fa-calendar"></i> Semanas</div>
        </button>
        <button class="sidebar-link" id="tab-trabajos" data-bs-toggle="pill" data-bs-target="#pane-trabajos" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-regular fa-folder"></i> Archivos</div>
        </button>
        <button class="sidebar-link" id="tab-usuarios" data-bs-toggle="pill" data-bs-target="#pane-usuarios" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-solid fa-users"></i> Equipo</div>
        </button>
        <button class="sidebar-link" id="tab-mensajes" data-bs-toggle="pill" data-bs-target="#pane-mensajes" type="button" role="tab">
            <div class="sidebar-link-content"><i class="fa-regular fa-envelope"></i> Mensajes</div>
            <span class="badge-notification">3</span>
        </button>
    </div>

    <div class="sidebar-bottom-card">
        <h6 style="color: #fff; text-align: left; font-size: 0.9rem; margin-bottom: 5px;">Sesión Segura</h6>
        <p>Estás operando bajo el modo administrador del sistema.</p>
        <a href="LogoutServlet" class="btn-logout">Cerrar Sesión</a>
    </div>
</nav>

<div class="main-wrapper">
    <header class="topbar">
        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Buscar proyectos, tareas...">
        </div>
        
        <div class="topbar-right">
            <div class="topbar-icon">
                <i class="fa-regular fa-bell"></i>
                <div class="dot"></div>
            </div>
            <div class="user-profile">
                <img src="img/perfil.jpg" alt="User" class="user-avatar" onerror="this.src='https://ui-avatars.com/api/?name=Abraham+Parejas&background=fff&color=000'">
                <div>
                    <p class="user-name">Abraham Parejas</p>
                    <span class="user-role">Administrador</span>
                </div>
                <i class="fa-solid fa-chevron-down" style="font-size: 0.7rem; color: var(--text-muted); margin-left: 5px;"></i>
            </div>
        </div>
    </header>

    <main class="main-content">
        <div class="tab-content" id="v-pills-tabContent">
            <div class="tab-pane fade show active" id="pane-dashboard" role="tabpanel">
                <jsp:include page="vistas/dashboard.jsp" />
            </div>
            <!-- Mantengo las demás vistas iguales -->
            <div class="tab-pane fade" id="pane-perfil" role="tabpanel"><jsp:include page="vistas/perfil.jsp" /></div>
            <div class="tab-pane fade" id="pane-semanas" role="tabpanel"><jsp:include page="vistas/semanas.jsp" /></div>
            <div class="tab-pane fade" id="pane-trabajos" role="tabpanel"><jsp:include page="vistas/trabajos.jsp" /></div>
            <div class="tab-pane fade" id="pane-usuarios" role="tabpanel"><jsp:include page="vistas/usuarios.jsp" /></div>
            <div class="tab-pane fade" id="pane-mensajes" role="tabpanel"><jsp:include page="vistas/mensajes.jsp" /></div>
        </div>
    </main>
</div>

<div id="contenedor-alertas" style="position: fixed; top: 90px; right: 20px; z-index: 9999; display: flex; flex-direction: column; gap: 10px;"></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const parametros = new URLSearchParams(window.location.search);
        const pestaña = parametros.get('tab');
        if (pestaña) {
            const botonPestaña = document.querySelector('#tab-' + pestaña);
            if (botonPestaña) {
                const tabAbierta = new bootstrap.Tab(botonPestaña);
                tabAbierta.show();
            }
        }
    });
</script>

</body>
</html>