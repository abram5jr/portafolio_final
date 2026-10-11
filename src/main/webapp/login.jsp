<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso al Sistema | Portafolio</title>
    
    <!-- Librerías -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --neon-cyan: #00f3ff;
            --neon-purple: #bc13fe;
            --bg-dark: #09090b;
            --input-bg: rgba(255, 255, 255, 0.03);
            /* Color e intensidad de la luz de la lámpara */
            --lamp-light: rgba(0, 243, 255, 0.18); 
            --transition-speed: 0.8s;
        }

        /* FONDO A PANTALLA COMPLETA SIN DIVISIONES */
        body, html { 
            min-height: 100vh; 
            width: 100vw;
            margin: 0; 
            padding: 0;
            font-family: 'Poppins', sans-serif; 
            background-color: var(--bg-dark);
            background-image: radial-gradient(circle at center, #1a1a24 0%, #09090b 100%);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Evitar barras de desplazamiento */
        }

        /* Enlace de regreso al inicio */
        .back-link {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: #666;
            text-decoration: none;
            font-family: 'Orbitron', sans-serif;
            font-size: 0.85rem;
            transition: 0.3s;
            z-index: 100;
        }
        .back-link:hover {
            color: var(--neon-cyan);
            text-shadow: 0 0 8px var(--neon-cyan);
        }

        /* --- ANIMACIÓN CUTE LAMP LOGIN --- */
        .wrapper {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 120px; /* Separación perfecta entre lámpara y formulario para escritorio */
            width: 100%;
            max-width: 1100px;
            height: 100vh;
            z-index: 10;
        }

        /* 1. La Lámpara */
        .lamp-section {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 20;
            margin-top: -15vh; /* Levantar un poco la lámpara */
        }

        /* Estructura de la lámpara */
        .lamp-top {
            width: 140px;
            height: 90px;
            background: #222;
            border-radius: 70px 70px 0 0;
            position: relative;
            border-bottom: 6px solid #111;
            z-index: 2;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            padding-bottom: 12px;
            box-shadow: inset 0 5px 15px rgba(255,255,255,0.05);
        }

        /* Carita (Ojos y boca) */
        .face {
            display: flex;
            gap: 18px;
            align-items: center;
            justify-content: center;
            width: 100%;
            transition: var(--transition-speed);
        }
        .eye {
            width: 14px;
            height: 5px; /* Ojos cerrados por defecto */
            background-color: #555;
            border-radius: 10px;
            transition: var(--transition-speed);
        }
        .mouth {
            width: 18px;
            height: 5px;
            background-color: #555;
            border-radius: 10px;
            position: absolute;
            bottom: 6px;
            transition: var(--transition-speed);
            opacity: 0; /* Boca invisible apagado */
        }

        /* Foco inferior de la lámpara */
        .lamp-bulb {
            width: 100px;
            height: 25px;
            background: #333;
            border-radius: 0 0 50px 50px;
            position: relative;
            z-index: 1;
            transition: var(--transition-speed);
        }

        /* Haz de luz (GIGANTE para que no deje líneas cortadas en el monitor) */
        .light-beam {
            position: absolute;
            top: 100px; /* Empieza debajo del foco */
            left: 50%;
            transform: translateX(-50%);
            width: 250vw; /* Ultra ancho para bañar la pantalla entera */
            height: 150vh; /* Alto infinito hacia abajo */
            background: radial-gradient(ellipse at top, var(--lamp-light) 0%, transparent 60%);
            clip-path: polygon(48% 0, 52% 0, 100% 100%, 0 100%); /* Cono ancho y suave */
            opacity: 0;
            pointer-events: none;
            transition: opacity var(--transition-speed) ease-in-out;
            z-index: -1; /* Detrás de todo el contenido */
        }

        /* Cuerda para encender (Pull string) */
        .pull-string {
            width: 4px;
            height: 160px;
            background: #444;
            position: relative;
            cursor: grab;
            transition: height 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            justify-content: center;
        }
        .pull-string:active {
            cursor: grabbing;
        }
        .pull-string::after {
            content: '';
            position: absolute;
            bottom: -8px;
            width: 18px;
            height: 18px;
            background: #555;
            border-radius: 50%;
        }

        /* 2. El Formulario (El "Welcome Back") */
        .form-section {
            position: relative;
            width: 100%;
            max-width: 420px;
            background: rgba(18, 18, 24, 0.65);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 45px 35px;
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            text-align: center;
            
            /* Estado apagado: Oscuro, escondido a la izquierda e invisible */
            opacity: 0;
            transform: translateX(-120px) scale(0.95);
            visibility: hidden;
            transition: all var(--transition-speed) cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 15;
            box-shadow: 0 0 0 rgba(0,0,0,0);
        }

        /* --- CLASES ACTIVAS (CUANDO SE ENCIENDE LA LUZ) --- */
        body.light-on .eye {
            height: 14px; /* Ojos abiertos */
            background-color: var(--neon-cyan);
            box-shadow: 0 0 8px var(--neon-cyan);
        }
        body.light-on .mouth {
            opacity: 1;
            height: 10px; /* Boca feliz */
            width: 24px;
            border-radius: 0 0 24px 24px;
            background-color: var(--neon-cyan);
            box-shadow: 0 0 8px var(--neon-cyan);
        }
        body.light-on .lamp-bulb {
            background: #fff;
            box-shadow: 0 0 25px #fff, 0 0 50px var(--neon-cyan);
        }
        body.light-on .light-beam {
            opacity: 1; /* El haz de luz gigante aparece */
        }
        body.light-on .form-section {
            opacity: 1;
            transform: translateX(0) scale(1); /* El formulario se desliza y revela */
            visibility: visible;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6), -20px 0 45px rgba(0, 243, 255, 0.12);
            border-left: 1px solid rgba(0, 243, 255, 0.35); /* Reflejo sutil de la luz en el borde */
        }
        /* --- FIN ESTILOS ANIMACIÓN --- */

        /* Estilos internos del formulario (Conservados) */
        .icon-top {
            width: 75px; height: 75px; background: rgba(0, 243, 255, 0.05); border-radius: 50%;
            display: flex; align-items: center; justify-content: center; margin: 0 auto 20px;
            font-size: 34px; color: var(--neon-cyan); border: 1px dashed rgba(0, 243, 255, 0.3);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.1);
        }
        .form-title { font-family: 'Orbitron', sans-serif; font-weight: 700; font-size: 1.7rem; margin-bottom: 5px; }
        .form-subtitle { font-size: 0.9rem; color: #aaa; margin-bottom: 35px; }
        
        .input-wrapper { position: relative; margin-bottom: 22px; }
        .input-wrapper i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #666; font-size: 1.15rem; transition: 0.3s; }
        .form-control-custom {
            width: 100%; padding: 15px 15px 15px 50px; background: var(--input-bg); border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px; color: #fff; font-size: 0.95rem; transition: all 0.3s ease; box-sizing: border-box;
        }
        .form-control-custom:focus { outline: none; border-color: var(--neon-cyan); background: rgba(0, 243, 255, 0.02); box-shadow: 0 0 15px rgba(0, 243, 255, 0.15); }
        .form-control-custom:focus + i, .input-wrapper:focus-within i { color: var(--neon-cyan); text-shadow: 0 0 8px var(--neon-cyan); }

        .options-row { display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem; margin-bottom: 25px; }
        .form-check-label { color: #aaa; cursor: pointer; margin-left: 8px;}
        .forgot-link { color: var(--neon-cyan); text-decoration: none; transition: 0.3s; }
        .forgot-link:hover { text-shadow: 0 0 8px var(--neon-cyan); }

        .btn-login {
            background: linear-gradient(45deg, rgba(0,243,255,0.1), transparent); border: 1px solid var(--neon-cyan);
            color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-weight: 700; letter-spacing: 2px;
            text-transform: uppercase; padding: 15px; width: 100%; border-radius: 12px; transition: 0.3s; cursor: pointer;
        }
        .btn-login:hover { background: var(--neon-cyan); color: #000; box-shadow: 0 0 20px rgba(0, 243, 255, 0.4); transform: scale(1.02); }

        .divider { display: flex; align-items: center; margin: 25px 0; font-size: 0.8rem; color: #666; }
        .divider::before, .divider::after { content: ""; flex: 1; border-bottom: 1px solid rgba(255, 255, 255, 0.05); margin: 0 15px; }

        .social-group { display: flex; justify-content: center; gap: 15px; }
        .social-btn {
            width: 48px; height: 48px; border-radius: 50%; background: var(--input-bg); border: 1px solid rgba(255, 255, 255, 0.08);
            display: flex; align-items: center; justify-content: center; color: #888; font-size: 1.2rem; transition: 0.3s; text-decoration: none;
        }
        .social-btn:hover { border-color: var(--neon-purple); color: var(--neon-purple); box-shadow: 0 0 15px rgba(188, 19, 254, 0.3); transform: translateY(-4px); }

        .alert-error { background: rgba(255,0,60,0.1); border: 1px dashed #ff003c; color: #ff003c; font-size: 0.85rem; font-weight: bold; padding: 12px; border-radius: 8px; margin-bottom: 25px; text-align: center;}

        /* Responsividad básica para pantallas pequeñas */
        @media (max-width: 850px) {
            .wrapper { flex-direction: column; gap: 50px; }
            .lamp-section { margin-top: 5vh; }
            .form-section { transform: translateY(-50px) scale(0.95); }
            body.light-on .form-section { transform: translateY(0) scale(1); border-left: 1px solid rgba(255, 255, 255, 0.05); border-top: 1px solid rgba(0, 243, 255, 0.35); }
        }
    </style>
</head>
<body>

    <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> INICIO</a>

    <div class="wrapper">
        
        <!-- SECCIÓN DE LA LÁMPARA -->
        <div class="lamp-section">
            <div class="lamp-top">
                <div class="face">
                    <div class="eye"></div>
                    <div class="mouth"></div>
                    <div class="eye"></div>
                </div>
            </div>
            <div class="lamp-bulb"></div>
            <!-- El haz de luz cian gigante y difuminado -->
            <div class="light-beam"></div>
            
            <!-- Cuerda interactiva -->
            <div class="pull-string" id="pullString"></div>
            
            <!-- Texto indicador -->
            <span id="instructionText" style="color: #666; font-family: 'Orbitron'; font-size: 0.75rem; margin-top: 25px; letter-spacing: 3px; font-weight: 700;">TIRA DE LA CUERDA</span>
        </div>

        <!-- SECCIÓN DEL FORMULARIO -->
        <div class="form-section">
            <div class="icon-top">
                <i class="fa-regular fa-user"></i>
            </div>
            <h2 class="form-title">INICIAR SESIÓN</h2>
            <p class="form-subtitle">¡Bienvenido de nuevo! Ingresa tus credenciales.</p>

            <%
                String error = request.getParameter("error");
                if(error != null && error.equals("1")) {
            %>
                <div class="alert-error">❌ Usuario o contraseña incorrectos.</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                <div class="input-wrapper">
                    <input type="text" class="form-control-custom" name="txtUsuario" placeholder="Usuario o Correo" required autocomplete="off">
                    <i class="fa-solid fa-user"></i>
                </div>
                
                <div class="input-wrapper">
                    <input type="password" class="form-control-custom" name="txtPassword" placeholder="Contraseña" required>
                    <i class="fa-solid fa-lock"></i>
                </div>

                <div class="options-row">
                    <div class="d-flex align-items-center">
                        <input type="checkbox" id="rememberMe" style="accent-color: var(--neon-cyan); width: 16px; height: 16px;">
                        <label class="form-check-label" for="rememberMe">Recordarme</label>
                    </div>
                    <a href="#" class="forgot-link">¿Olvidaste tu clave?</a>
                </div>
                
                <button type="submit" class="btn-login">INGRESAR</button>
            </form>

            <div class="divider">o continuar con</div>

            <div class="social-group">
                <a href="#" class="social-btn"><i class="fa-brands fa-google"></i></a>
                <a href="#" class="social-btn"><i class="fa-brands fa-apple"></i></a>
                <a href="#" class="social-btn"><i class="fa-brands fa-facebook-f"></i></a>
            </div>
        </div>

    </div>

    <!-- SCRIPT DE INTERACCIÓN DE LA LÁMPARA -->
    <script>
        const pullString = document.getElementById('pullString');
        const body = document.body;
        const instructionText = document.getElementById('instructionText');
        
        let isLightOn = false;

        // Función para cambiar el estado
        function toggleLight() {
            // Animación física de la cuerda bajando y subiendo
            pullString.style.height = "190px";
            setTimeout(() => {
                pullString.style.height = "160px";
            }, 200);

            // Cambiar luz
            isLightOn = !isLightOn;
            if (isLightOn) {
                body.classList.add('light-on');
                instructionText.style.opacity = "0"; // Ocultar texto
            } else {
                body.classList.remove('light-on');
                setTimeout(() => {
                    instructionText.style.opacity = "1"; // Mostrar texto
                    instructionText.innerText = "TIRA DE LA CUERDA";
                }, 800);
            }
        }

        // Lógica de arrastre de la cuerda (Soporte Mouse y Touch)
        let isDragging = false;
        let startY;

        pullString.addEventListener('mousedown', (e) => { isDragging = true; startY = e.clientY; });
        pullString.addEventListener('touchstart', (e) => { isDragging = true; startY = e.touches[0].clientY; }, {passive: true});

        window.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            const deltaY = e.clientY - startY;
            if (deltaY > 25) { // Si arrastró suficiente hacia abajo
                toggleLight();
                isDragging = false; // Soltar para no disparar múltiple
            }
        });
        window.addEventListener('touchmove', (e) => {
            if (!isDragging) return;
            const deltaY = e.touches[0].clientY - startY;
            if (deltaY > 25) {
                toggleLight();
                isDragging = false;
            }
        }, {passive: true});

        window.addEventListener('mouseup', () => { isDragging = false; });
        window.addEventListener('touchend', () => { isDragging = false; });
        
        // También funciona con un simple click en la cuerda
        pullString.addEventListener('click', toggleLight);

        // Si hay error en credenciales, la luz se enciende sola al cargar
        <% if(error != null && error.equals("1")) { %>
            setTimeout(() => {
                toggleLight();
            }, 500);
        <% } %>
    </script>
</body>
</html>