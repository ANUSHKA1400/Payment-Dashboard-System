// src/main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ✅ Allow requests from Flutter Web (localhost:XXXXX)
  app.enableCors({
    origin: true, // you can replace '*' with 'http://localhost:YOUR_FLUTTER_PORT' for stricter config
    credentials: true,
  });

  await app.listen(3000);
}
bootstrap();
