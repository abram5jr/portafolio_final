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
        }
        .back-link:hover {
            color: var(--neon-cyan);
            text-shadow: 0 0 8px var(--neon-cyan);
        }

        /* Contenedor principal tipo tarjeta de cristal */
        .login-container {
            width: 100%;
            max-width: 380px;
            background: rgba(18, 18, 24, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 40px 30px;
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5), inset 0 0 20px rgba(0, 243, 255, 0.03);
            text-align: center;
        }

        /* Icono de perfil superior */
        .icon-top {
            width: 70px;
            height: 70px;
            background: rgba(0, 243, 255, 0.05);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 32px;
            color: var(--neon-cyan);
            border: 1px dashed rgba(0, 243, 255, 0.3);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.1);
        }

        .form-title {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            font-size: 1.6rem;
            margin-bottom: 5px;
        }

        .form-subtitle {
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 30px;
        }

        /* Inputs con iconos internos */
        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }
        .input-wrapper i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 1.1rem;
            transition: 0.3s;
        }
        .form-control-custom {
            width: 100%;
            padding: 14px 14px 14px 48px;
            background: var(--input-bg);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            color: #fff;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .form-control-custom:focus {
            outline: none;
            border-color: var(--neon-cyan);
            background: rgba(0, 243, 255, 0.02);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.15);
        }
        .form-control-custom:focus + i, 
        .input-wrapper:focus-within i {
            color: var(--neon-cyan);
            text-shadow: 0 0 8px var(--neon-cyan);
        }

        /* Fila de opciones (Recordarme / Olvidó) */
        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.8rem;
            margin-bottom: 25px;
        }
        .form-check-label { color: #888; cursor: pointer; }
        .forgot-link { color: var(--neon-cyan); text-decoration: none; transition: 0.3s; }
        .forgot-link:hover { text-shadow: 0 0 8px var(--neon-cyan); }

        /* Botón principal */
        .btn-login {
            background: linear-gradient(45deg, rgba(0,243,255,0.1), transparent);
            border: 1px solid var(--neon-cyan);
            color: var(--neon-cyan);
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            padding: 14px;
            width: 100%;
            border-radius: 12px;
            transition: 0.3s;
        }
        .btn-login:hover {
            background: var(--neon-cyan);
            color: #000;
            box-shadow: 0 0 20px rgba(0, 243, 255, 0.4);
        }

        /* Divisor y Redes Sociales */
        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            font-size: 0.75rem;
            color: #555;
        }
        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            margin: 0 10px;
        }

        .social-group {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .social-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--input-bg);
            border: 1px solid rgba(255, 255, 255, 0.08);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
            font-size: 1.1rem;
            transition: 0.3s;
            text-decoration: none;
        }
        .social-btn:hover {
            border-color: var(--neon-purple);
            color: var(--neon-purple);
            box-shadow: 0 0 15px rgba(188, 19, 254, 0.3);
            transform: translateY(-3px);
        }

        /* Alerta de Error */
        .alert-error {
            background: rgba(255,0,60,0.1); 
            border: 1px dashed var(--neon-red, #ff003c); 
            color: #ff003c; 
            font-size: 0.8rem; 
            font-weight: bold;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <a href="index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> INICIO</a>

    <div class="login-container">
        
        <!-- Icono Superior -->
        <div class="icon-top">
            <i class="fa-regular fa-user"></i>
        </div>

        <h2 class="form-title">INICIAR SESIÓN</h2>
        <p class="form-subtitle">¡Bienvenido de nuevo! Ingresa tus credenciales.</p>

        <!-- Mensaje de Error Dinámico -->
        <%
            String error = request.getParameter("error");
            if(error != null && error.equals("1")) {
        %>
            <div class="alert-error">
                ❌ Usuario o contraseña incorrectos.
            </div>
        <% } %>

        <!-- Formulario Conectado a tu Servlet -->
        <form action="LoginServlet" method="POST">
            
            <div class="input-wrapper">
                <input type="text" class="form-control-custom" name="txtUsuario" placeholder="Usuario o Correo" required autocomplete="off">
                <i class="fa-solid fa-user"></i>
            </div>
            
            <div class="input-wrapper">
                <input type="password" class="form-control-custom" name="txtPassword" placeholder="Contraseña" required>
                <i class="fa-solid fa-lock"></i>
            </div>

            <div class="options-row">
                <div class="form-check text-start m-0">
                    <input class="form-check-input" type="checkbox" id="rememberMe" style="background-color: transparent; border-color: #555;">
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

</body>
</html>