/**
 * Páginas HTML mínimas para flujos que ocurren fuera de la app (enlaces por
 * correo y borrado web). Sin JavaScript ni recursos externos: funcionan con
 * la CSP por defecto de helmet. Paleta "Serena & Calma" (docs/design).
 */

export function escapeHtml(value: string): string {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

function layout(title: string, body: string): string {
  return `<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>${escapeHtml(title)} · SentIA</title>
<style>
  :root { color-scheme: light dark; }
  body { margin: 0; font-family: system-ui, sans-serif; background: #f3fbff; color: #141d21; line-height: 1.6; }
  main { max-width: 28rem; margin: 3rem auto; padding: 0 1.25rem; }
  .card { background: #fff; border-radius: 1.5rem; padding: 1.5rem; border: 1px solid rgba(44,53,57,.06); }
  h1 { font-size: 1.5rem; font-weight: 600; margin: 0 0 .5rem; }
  p { color: #41484d; }
  label { display: block; font-size: .85rem; font-weight: 500; margin: 1rem 0 .35rem; }
  input { box-sizing: border-box; width: 100%; padding: .85rem 1rem; border-radius: 1rem; border: 1.5px solid transparent; background: #ecf5fa; font-size: 1rem; }
  input:focus { outline: none; border-color: #3a6b88; }
  button { margin-top: 1.5rem; width: 100%; padding: .9rem; border: 0; border-radius: 9999px; background: #3a6b88; color: #fff; font-size: 1rem; font-weight: 500; cursor: pointer; }
  button.danger { background: #ba1a1a; }
  .note { font-size: .85rem; margin-top: 1.5rem; }
  @media (prefers-color-scheme: dark) {
    body { background: #0f171a; color: #e9f2f7; }
    .card { background: #172024; border-color: rgba(233,242,247,.12); }
    p { color: #c1c7ce; }
    input { background: #232e33; color: #e9f2f7; }
  }
</style>
</head>
<body><main><div class="card">${body}</div>
</main></body>
</html>`;
}

export function message(title: string, text: string): string {
  return layout(
    title,
    `<h1>${escapeHtml(title)}</h1><p>${escapeHtml(text)}</p>`,
  );
}

export function resetPasswordForm(token: string, error?: string): string {
  return layout(
    'Nueva contraseña',
    `<h1>Crea una nueva contraseña</h1>
<p>Usa al menos 12 caracteres. Al guardarla se cerrará tu sesión en todos los dispositivos.</p>
${error ? `<p role="alert"><strong>${escapeHtml(error)}</strong></p>` : ''}
<form method="post" action="/restablecer-contrasena">
  <input type="hidden" name="token" value="${escapeHtml(token)}">
  <label for="password">Nueva contraseña</label>
  <input id="password" name="password" type="password" minlength="12" maxlength="128" autocomplete="new-password" required>
  <label for="confirm">Repite la contraseña</label>
  <input id="confirm" name="confirm" type="password" minlength="12" maxlength="128" autocomplete="new-password" required>
  <button type="submit">Guardar contraseña</button>
</form>`,
  );
}

export function deletionRequestForm(): string {
  return layout(
    'Eliminar cuenta',
    `<h1>Eliminar tu cuenta de SentIA</h1>
<p>Escribe el correo de tu cuenta. Te enviaremos un enlace para confirmar. Al confirmarlo se borran tu perfil, tus conversaciones y tus registros; solo conservamos, sin datos de contacto, la evidencia de tus consentimientos y la bitácora de seguridad que exige la ley.</p>
<p>También puedes eliminarla desde la app: Perfil → Ajustes → Eliminar cuenta.</p>
<form method="post" action="/eliminar-cuenta">
  <label for="email">Correo electrónico</label>
  <input id="email" name="email" type="email" autocomplete="email" required>
  <button type="submit">Enviar enlace de confirmación</button>
</form>`,
  );
}

export function deletionConfirmForm(token: string): string {
  return layout(
    'Confirmar eliminación',
    `<h1>¿Eliminar tu cuenta?</h1>
<p>Esta acción no se puede deshacer.</p>
<form method="post" action="/eliminar-cuenta/confirmar">
  <input type="hidden" name="token" value="${escapeHtml(token)}">
  <button class="danger" type="submit">Sí, eliminar mi cuenta</button>
</form>`,
  );
}
