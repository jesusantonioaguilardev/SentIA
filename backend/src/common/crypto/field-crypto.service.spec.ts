import { ConfigService } from '@nestjs/config';
import { Env } from '../../config/env.schema';
import { FieldCryptoService } from './field-crypto.service';

function serviceWithKey(byte: number): FieldCryptoService {
  const config = {
    get: () => Buffer.alloc(32, byte).toString('base64'),
  } as unknown as ConfigService<Env, true>;
  return new FieldCryptoService(config);
}

describe('FieldCryptoService', () => {
  const crypto = serviceWithKey(1);

  it('cifra y descifra ida y vuelta (incluye acentos)', () => {
    const value = 'Ana López · 55 1234 5678';
    const encrypted = crypto.encrypt(value);

    expect(encrypted).toMatch(/^v1:/);
    expect(encrypted).not.toContain('Ana');
    expect(crypto.decrypt(encrypted)).toBe(value);
  });

  it('usa un IV distinto en cada cifrado', () => {
    expect(crypto.encrypt('igual')).not.toBe(crypto.encrypt('igual'));
  });

  it('rechaza datos alterados', () => {
    const [v, iv, tag, data] = crypto.encrypt('secreto').split(':');
    const tampered = [v, iv, tag, data.slice(0, -2) + 'AA'].join(':');

    expect(() => crypto.decrypt(tampered)).toThrow();
  });

  it('no descifra con otra llave', () => {
    const encrypted = crypto.encrypt('secreto');

    expect(() => serviceWithKey(2).decrypt(encrypted)).toThrow();
  });

  it('rechaza formatos desconocidos', () => {
    expect(() => crypto.decrypt('texto plano')).toThrow(/Formato/);
  });

  it('trata vacíos como null', () => {
    expect(crypto.encryptOptional('')).toBeNull();
    expect(crypto.decryptOptional(null)).toBeNull();
  });
});
