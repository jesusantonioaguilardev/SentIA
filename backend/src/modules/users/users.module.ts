import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { AccountDeletionService } from './account-deletion.service';
import { AccountDeletionController, MeController } from './users.controller';
import { UsersService } from './users.service';

/** Perfil, exportación ARCO y borrado de cuenta (docs/05). */
@Module({
  imports: [AuthModule],
  controllers: [MeController, AccountDeletionController],
  providers: [UsersService, AccountDeletionService],
  exports: [AccountDeletionService],
})
export class UsersModule {}
