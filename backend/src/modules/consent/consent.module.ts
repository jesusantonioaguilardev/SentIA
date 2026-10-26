import { Module } from '@nestjs/common';
import { ConsentController } from './consent.controller';
import { ConsentGuard } from './consent.guard';
import { ConsentService } from './consent.service';

@Module({
  controllers: [ConsentController],
  providers: [ConsentService, ConsentGuard],
  exports: [ConsentService, ConsentGuard],
})
export class ConsentModule {}
