import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { UsersModule } from '../users/users.module';
import { WebController } from './web.controller';

/** Rutas a excluir del prefijo `/v1` (ver app.setup.ts). */
export const WEB_ROUTES = [
  'restablecer-contrasena',
  'eliminar-cuenta',
  'eliminar-cuenta/confirmar',
];

@Module({
  imports: [AuthModule, UsersModule],
  controllers: [WebController],
})
export class WebModule {}
