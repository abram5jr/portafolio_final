<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="section-header">
    <span class="section-subtitle" style="color: var(--neon-red);">BANDEJA INBOX</span>
    <h2 class="section-title">CONTROL DE <span class="text-danger" style="text-shadow: 0 0 8px rgba(255,0,60,0.4);">MENSAJES</span></h2>
    <p class="section-desc">Buzón de contacto integrado con el formulario público. Atiende las consultas recibidas.</p>
</div>

<div class="admin-card" style="border-color: var(--neon-red);">
    <div class="admin-card-header d-flex justify-content-between align-items-center" style="border-color: var(--neon-red); color: var(--neon-red);">
        <h5 class="m-0" style="font-size: 1.1rem;">✉️ BANDEJA DE ENTRADA</h5>
        <span class="badge-notification">3 NUEVOS</span>
    </div>
    <div class="card-body p-0 table-responsive">
        <table class="table table-dark table-hover m-0">
            <thead>
                <tr>
                    <th class="ps-4">REMITENTE</th>
                    <th>CORREO</th>
                    <th>ASUNTO</th>
                    <th>FECHA</th>
                    <th class="text-end pe-4">ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="ps-4 fw-bold">Usuario de prueba</td>
                    <td class="text-muted small">test@correo.com</td>
                    <td>Consulta sobre diseño</td>
                    <td class="text-muted small">08/09/2026</td>
                    <td class="text-end pe-4">
                        <button class="btn btn-sm btn-neon btn-cyan-neon py-1 px-2">👁️</button>
                        <button class="btn btn-sm btn-neon btn-danger-neon py-1 px-2">❌</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
