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
            /* Variables para la animación de la lámpara */
            --lamp-light: rgba(0, 243, 255, 0.15); /* Color de luz suave cian */
            --transition-speed: 0.8s;
        }

        body, html { 
            height: 100%; 
            margin: 0; 
            font-family: 'Poppins', sans-serif; 
            background-color: var(--bg-dark);
            background-image: radial-gradient(circle at center, #1a1a24 0%, #09090b 100%);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Evitar scroll en esta pantalla */
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
            width: 800px; /* Ancho suficiente para lámpara + formulario */
            height: 500px;
        }

        /* 1. La Lámpara */
        .lamp-section {
            position: absolute;
            left: 0;
            width: 400px;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            z-index: 10;
        }

        /* Estructura de la lámpara */
        .lamp-top {
            width: 120px;
            height: 80px;
            background: #222;
            border-radius: 60px 60px 0 0;
            position: relative;
            border-bottom: 5px solid #111;
            z-index: 2;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            padding-bottom: 10px;
            box-shadow: inset 0 5px 15px rgba(255,255,255,0.05);
        }

        /* Carita (Ojos y boca) */
        .face {
            display: flex;
            gap: 15px;
            align-items: center;
            justify-content: center;
            width: 100%;
            transition: var(--transition-speed);
        }
        .eye {
            width: 12px;
            height: 4px; /* Ojos cerrados por defecto */
            background-color: #555;
            border-radius: 10px;
            transition: var(--transition-speed);
        }
        .mouth {
            width: 15px;
            height: 4px;
            background-color: #555;
            border-radius: 10px;
            position: absolute;
            bottom: 5px;
            transition: var(--transition-speed);
            opacity: 0; /* Boca invisible apagado */
        }

        /* Foco inferior de la lámpara */
        .lamp-bulb {
            width: 90px;
            height: 20px;
            background: #333;
            border-radius: 0 0 45px 45px;
            position: relative;
            z-index: 1;
            transition: var(--transition-speed);
        }

        /* Haz de luz (Oculto por defecto) */
        .light-beam {
            position: absolute;
            top: 100px; /* Debajo del foco */
            left: 50%;
            transform: translateX(-50%);
            width: 450px;
            height: 600px;
            background: radial-gradient(ellipse at top, var(--lamp-light) 0%, transparent 70%);
            clip-path: polygon(40% 0, 60% 0, 100% 100%, 0 100%); /* Forma de cono de luz */
            opacity: 0;
            pointer-events: none;
            transition: opacity var(--transition-speed) ease-in-out;
            z-index: 0;
        }

        /* Cuerda para encender (Pull string) */
        .pull-string {
            width: 4px;
            height: 150px; /* Largo inicial */
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
            width: 16px;
            height: 16px;
            background: #555;
            border-radius: 50%;
        }

        /* 2. El Formulario (El "Welcome Back") */
        .form-section {
            position: absolute;
            right: 50px;
            width: 380px;
            background: rgba(18, 18, 24, 0.8);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 40px 30px;
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            text-align: center;
            
            /* Estado apagado: Oscuro, escondido a la izquierda e invisible */
            opacity: 0;
            transform: translateX(-150px) scale(0.9);
            visibility: hidden;
            transition: all var(--transition-speed) cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 5;
            box-shadow: 0 0 0 rgba(0,0,0,0);
        }

        /* --- CLASES ACTIVAS (CUANDO SE ENCIENDE LA LUZ) --- */
        body.light-on .eye {
            height: 12px; /* Ojos abiertos */
            background-color: var(--neon-cyan);
            box-shadow: 0 0 5px var(--neon-cyan);
        }
        body.light-on .mouth {
            opacity: 1;
            height: 8px; /* Boca feliz */
            width: 20px;
            border-radius: 0 0 20px 20px;
            background-color: var(--neon-cyan);
            box-shadow: 0 0 5px var(--neon-cyan);
        }
        body.light-on .lamp-bulb {
            background: #fff;
            box-shadow: 0 0 20px #fff, 0 0 40px var(--neon-cyan);
        }
        body.light-on .light-beam {
            opacity: 1; /* El haz de luz aparece */
        }
        body.light-on .form-section {
            opacity: 1;
            transform: translateX(0) scale(1); /* El formulario se desliza y revela */
            visibility: visible;
            box-shadow: 0 20px 40px rgba(0,0,0,0.5), -15px 0 30px rgba(0, 243, 255, 0.1);
            border-left: 1px solid rgba(0, 243, 255, 0.3); /* Reflejo de luz en el borde izquierdo */
        }
        /* --- FIN ESTILOS ANIMACIÓN --- */

        /* Estilos internos del formulario (Conservados de tu diseño) */
        .icon-top {
            width: 70px; height: 70px; background: rgba(0, 243, 255, 0.05); border-radius: 50%;
            display: flex; align-items: center; justify-content: center; margin: 0 auto 20px;
            font-size: 32px; color: var(--neon-cyan); border: 1px dashed rgba(0, 243, 255, 0.3);
        }
        .form-title { font-family: 'Orbitron', sans-serif; font-weight: 700; font-size: 1.6rem; margin-bottom: 5px; }
        .form-subtitle { font-size: 0.85rem; color: #888; margin-bottom: 30px; }
        
        .input-wrapper { position: relative; margin-bottom: 20px; }
        .input-wrapper i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #666; font-size: 1.1rem; transition: 0.3s; }
        .form-control-custom {
            width: 100%; padding: 14px 14px 14px 48px; background: var(--input-bg); border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px; color: #fff; font-size: 0.9rem; transition: all 0.3s ease; box-sizing: border-box;
        }
        .form-control-custom:focus { outline: none; border-color: var(--neon-cyan); background: rgba(0, 243, 255, 0.02); box-shadow: 0 0 15px rgba(0, 243, 255, 0.15); }
        .form-control-custom:focus + i, .input-wrapper:focus-within i { color: var(--neon-cyan); text-shadow: 0 0 8px var(--neon-cyan); }

        .options-row { display: flex; justify-content: space-between; align-items: center; font-size: 0.8rem; margin-bottom: 25px; }
        .form-check-label { color: #888; cursor: pointer; margin-left: 5px;}
        .forgot-link { color: var(--neon-cyan); text-decoration: none; transition: 0.3s; }
        .forgot-link:hover { text-shadow: 0 0 8px var(--neon-cyan); }

        .btn-login {
            background: linear-gradient(45deg, rgba(0,243,255,0.1), transparent); border: 1px solid var(--neon-cyan);
            color: var(--neon-cyan); font-family: 'Orbitron', sans-serif; font-weight: 700; letter-spacing: 1px;
            text-transform: uppercase; padding: 14px; width: 100%; border-radius: 12px; transition: 0.3s; cursor: pointer;
        }
        .btn-login:hover { background: var(--neon-cyan); color: #000; box-shadow: 0 0 20px rgba(0, 243, 255, 0.4); }

        .divider { display: flex; align-items: center; margin: 25px 0; font-size: 0.75rem; color: #555; }
        .divider::before, .divider::after { content: ""; flex: 1; border-bottom: 1px solid rgba(255, 255, 255, 0.05); margin: 0 10px; }

        .social-group { display: flex; justify-content: center; gap: 15px; }
        .social-btn {
            width: 45px; height: 45px; border-radius: 50%; background: var(--input-bg); border: 1px solid rgba(255, 255, 255, 0.08);
            display: flex; align-items: center; justify-content: center; color: #888; font-size: 1.1rem; transition: 0.3s; text-decoration: none;
        }
        .social-btn:hover { border-color: var(--neon-purple); color: var(--neon-purple); box-shadow: 0 0 15px rgba(188, 19, 254, 0.3); transform: translateY(-3px); }

        .alert-error { background: rgba(255,0,60,0.1); border: 1px dashed #ff003c; color: #ff003c; font-size: 0.8rem; font-weight: bold; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;}
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
            <!-- El haz de luz cian -->
            <div class="light-beam"></div>
            
            <!-- Cuerda interactiva -->
            <div class="pull-string" id="pullString"></div>
            
            <!-- Texto indicador -->
            <span id="instructionText" style="color: #555; font-family: 'Orbitron'; font-size: 0.7rem; margin-top: 20px; letter-spacing: 2px;">TIRA PARA ENCENDER</span>
        </div>

        <!-- SECCIÓN DEL FORMULARIO (Se muestra con la luz) -->
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
                <!-- Si hay error, encendemos la lámpara por defecto en el script abajo para que se vea -->
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
                        <input type="checkbox" id="rememberMe" style="accent-color: var(--neon-cyan);">
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
            pullString.style.height = "180px";
            setTimeout(() => {
                pullString.style.height = "150px";
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
                    instructionText.innerText = "TIRA PARA ENCENDER";
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
            if (deltaY > 20) { // Si arrastró suficiente hacia abajo
                toggleLight();
                isDragging = false; // Soltar para no disparar múltiple
            }
        });
        window.addEventListener('touchmove', (e) => {
            if (!isDragging) return;
            const deltaY = e.touches[0].clientY - startY;
            if (deltaY > 20) {
                toggleLight();
                isDragging = false;
            }
        }, {passive: true});

        window.addEventListener('mouseup', () => { isDragging = false; });
        window.addEventListener('touchend', () => { isDragging = false; });
        
        // También funciona con un simple click en la cuerda
        pullString.addEventListener('click', toggleLight);

        // Si la página carga con un mensaje de error (credenciales incorrectas),
        // encendemos la luz automáticamente para que el usuario vea el error.
        <% if(error != null && error.equals("1")) { %>
            setTimeout(() => {
                toggleLight();
            }, 500); // Pequeño retraso para que el usuario aprecie la animación al entrar
        <% } %>
    </script>
</body>
</html>