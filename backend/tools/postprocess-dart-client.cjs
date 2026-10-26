// Ajustes al cliente Dart generado por openapi-generator (dart-dio).
// El template declara `sdk: '>=3.5.0 <4.0.0'`, pero json_serializable actual
// genera elementos null-aware (Dart ≥ 3.8). Se alinea con el SDK de la app.
const fs = require('node:fs');
const path = require('node:path');

const pubspec = path.resolve(__dirname, '../../app/packages/sentia_api/pubspec.yaml');
const original = fs.readFileSync(pubspec, 'utf8');
const updated = original.replace(/sdk: '>=3\.\d+\.\d+ <4\.0\.0'/, "sdk: '^3.9.0'");

if (updated === original && !original.includes("sdk: '^3.9.0'")) {
  throw new Error('No se encontró la restricción de SDK esperada en el pubspec generado');
}
fs.writeFileSync(pubspec, updated);
console.log('Cliente Dart: SDK mínimo ajustado a ^3.9.0');
