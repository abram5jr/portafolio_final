<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="d-flex justify-content-between align-items-center mb-1">
    <h2 class="section-title">¡Bienvenido de nuevo, Abraham! 👋</h2>
    <div class="d-flex align-items-center gap-3">
        <span style="color: var(--text-muted); font-size: 0.85rem;">Lunes, 15 Sep 2026<br>¡Que tengas un día productivo!</span>
    </div>
</div>
<p class="section-desc mb-4">Aquí tienes el resumen de tu portafolio hoy.</p>

<!-- LAS 4 TARJETAS PRINCIPALES CON SUS ICONOS BRILLANTES -->
<div class="row g-4 mb-4">
    <!-- Tarjeta 1: Azul/Púrpura -->
    <div class="col-md-3">
        <div class="neon-card d-flex align-items-center gap-3" style="border: 1px solid rgba(161, 19, 255, 0.4) !important;">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(161, 19, 255, 0.15); color: #a113ff; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; box-shadow: 0 0 15px rgba(161, 19, 255, 0.2);">
                <i class="fa-solid fa-layer-group"></i>
            </div>
            <div>
                <div style="color: var(--text-muted); font-size: 0.75rem; margin-bottom: 2px;">Semanas Activas</div>
                <div style="color: #fff; font-size: 1.4rem; font-weight: 600; line-height: 1;">16</div>
                <div style="color: #a113ff; font-size: 0.7rem; margin-top: 5px;"><i class="fa-solid fa-arrow-up"></i> +2 este mes</div>
            </div>
        </div>
    </div>
    
    <!-- Tarjeta 2: Cian -->
    <div class="col-md-3">
        <div class="neon-card d-flex align-items-center gap-3">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(0, 212, 255, 0.15); color: #00d4ff; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; box-shadow: 0 0 15px rgba(0, 212, 255, 0.2);">
                <i class="fa-regular fa-square-check"></i>
            </div>
            <div>
                <div style="color: var(--text-muted); font-size: 0.75rem; margin-bottom: 2px;">Evidencias Totales</div>
                <div style="color: #fff; font-size: 1.4rem; font-weight: 600; line-height: 1;">12</div>
                <div style="color: #00d4ff; font-size: 0.7rem; margin-top: 5px;"><i class="fa-solid fa-arrow-up"></i> +12%</div>
            </div>
        </div>
    </div>
    
    <!-- Tarjeta 3: Rosa -->
    <div class="col-md-3">
        <div class="neon-card d-flex align-items-center gap-3">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(255, 0, 123, 0.15); color: #ff007b; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; box-shadow: 0 0 15px rgba(255, 0, 123, 0.2);">
                <i class="fa-solid fa-user-tie"></i>
            </div>
            <div>
                <div style="color: var(--text-muted); font-size: 0.75rem; margin-bottom: 2px;">Nivel de Acceso</div>
                <div style="color: #fff; font-size: 1.1rem; font-weight: 600; line-height: 1;">ADMINISTRADOR</div>
                <div style="color: #ff007b; font-size: 0.7rem; margin-top: 5px;"><i class="fa-solid fa-arrow-up"></i> +1 nuevo</div>
            </div>
        </div>
    </div>
    
    <!-- Tarjeta 4: Verde -->
    <div class="col-md-3">
        <div class="neon-card d-flex align-items-center gap-3">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(0, 230, 118, 0.15); color: #00e676; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; box-shadow: 0 0 15px rgba(0, 230, 118, 0.2);">
                <i class="fa-regular fa-envelope"></i>
            </div>
            <div>
                <div style="color: var(--text-muted); font-size: 0.75rem; margin-bottom: 2px;">Mensajes sin leer</div>
                <div style="color: #fff; font-size: 1.4rem; font-weight: 600; line-height: 1;">3</div>
                <div style="color: #00e676; font-size: 0.7rem; margin-top: 5px;"><i class="fa-solid fa-arrow-up"></i> +18%</div>
            </div>
        </div>
    </div>
</div>

<!-- SEGUNDA FILA: GRÁFICO (Resumen) Y ESTADO -->
<div class="row g-4">
    <!-- Panel Resumen simulando el gráfico -->
    <div class="col-lg-8">
        <div class="neon-card h-100">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 style="color: #fff; font-size: 1rem; font-weight: 600; margin: 0;">Resumen del Proyecto</h5>
                    <span style="font-size: 0.75rem; color: var(--text-muted);">Supervisa el progreso y rendimiento de tus proyectos.</span>
                </div>
                <div class="d-flex gap-3 align-items-center">
                    <span style="font-size: 0.7rem; color: var(--text-muted);"><span style="display:inline-block; width:6px; height:6px; border-radius:50%; background:#00d4ff; margin-right:5px;"></span>Completado</span>
                    <span style="font-size: 0.7rem; color: var(--text-muted);"><span style="display:inline-block; width:6px; height:6px; border-radius:50%; background:#a113ff; margin-right:5px;"></span>En Progreso</span>
                </div>
            </div>
            
            <!-- Interior del Resumen -->
            <div class="d-flex flex-column justify-content-center h-75 p-3">
                <p style="color: var(--text-muted); font-size: 0.9rem; line-height: 1.7; margin-bottom: 25px;">
                    Este es el centro de control de tu portafolio académico. Desde aquí puedes administrar las 16 semanas de formación, agregar los trabajos realizados, actualizar tu información personal y controlar los mensajes.
                </p>
                <div class="d-flex justify-content-between">
                    <a href="index.jsp" style="display: inline-block; padding: 8px 20px; border-radius: 8px; border: 1px solid var(--border-color); color: #fff; text-decoration: none; font-size: 0.85rem; background: rgba(255,255,255,0.03);">
                        <i class="fa-solid fa-eye" style="margin-right: 5px; color: var(--brand-cyan);"></i> Ver Sitio Público
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Panel Tareas (Acciones rápidas) -->
    <div class="col-lg-4">
        <div class="neon-card h-100">
            <h5 style="color: #fff; font-size: 1rem; font-weight: 600; margin-bottom: 25px;">Acciones rápidas</h5>
            
            <div class="d-flex flex-column gap-3">
                <!-- Acción 1 -->
                <div class="d-flex align-items-center justify-content-between p-2 rounded" style="cursor: pointer; transition: 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.03)'" onmouseout="this.style.background='transparent'" onclick="document.getElementById('tab-perfil').click();">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--brand-purple);"></div>
                        <span style="color: var(--text-muted); font-size: 0.85rem;">Mi Perfil</span>
                    </div>
                    <span style="color: #fff; font-size: 0.85rem;">Editar Info</span>
                </div>
                
                <!-- Acción 2 -->
                <div class="d-flex align-items-center justify-content-between p-2 rounded" style="cursor: pointer; transition: 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.03)'" onmouseout="this.style.background='transparent'" onclick="document.getElementById('tab-semanas').click();">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--brand-cyan);"></div>
                        <span style="color: var(--text-muted); font-size: 0.85rem;">Semanas</span>
                    </div>
                    <span style="color: #fff; font-size: 0.85rem;">Gestionar</span>
                </div>
                
                <!-- Acción 3 -->
                <div class="d-flex align-items-center justify-content-between p-2 rounded" style="cursor: pointer; transition: 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.03)'" onmouseout="this.style.background='transparent'" onclick="document.getElementById('tab-trabajos').click();">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--brand-pink);"></div>
                        <span style="color: var(--text-muted); font-size: 0.85rem;">Trabajos</span>
                    </div>
                    <span style="color: #fff; font-size: 0.85rem;">Archivos</span>
                </div>
                
                <!-- Acción 4 -->
                <div class="d-flex align-items-center justify-content-between p-2 rounded" style="cursor: pointer; transition: 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.03)'" onmouseout="this.style.background='transparent'" onclick="document.getElementById('tab-mensajes').click();">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--brand-green);"></div>
                        <span style="color: var(--text-muted); font-size: 0.85rem;">Mensajes</span>
                    </div>
                    <span style="color: #fff; font-size: 0.85rem;">Revisar</span>
                </div>
            </div>
            
        </div>
    </div>
</div>