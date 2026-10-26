import { Global, Module } from '@nestjs/common';
import { FieldCryptoService } from './field-crypto.service';
import { HashingService } from './hashing.service';

@Global()
@Module({
  providers: [FieldCryptoService, HashingService],
  exports: [FieldCryptoService, HashingService],
})
export class CryptoModule {}
