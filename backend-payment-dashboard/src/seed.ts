import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PaymentsService } from './payments/payments.service';
import { UsersService } from './users/users.service';
import { PaymentStatus } from './payments/payment.model'; // This is still valid

async function bootstrap() {
  const app = await NestFactory.createApplicationContext(AppModule);

  const paymentsService = app.get(PaymentsService);
  const usersService = app.get(UsersService);

  // ✅ Seed a viewer user
  await usersService.create({
    username: 'viewer1',
    password: 'viewer123',
    role: 'viewer',
  });

  // ✅ Seed multiple payments
  for (let i = 0; i < 15; i++) {
    const statuses: PaymentStatus[] = ['success', 'failed', 'pending'];
    const status: PaymentStatus = statuses[i % 3];

    const methods: Array<'card' | 'upi' | 'bank'> = ['card', 'upi', 'bank'];
    const method = methods[i % 3];

    await paymentsService.create({
      amount: 1000 + i * 250,
      receiver: `User ${i + 1}`,
      method,
      status,
    });
  }

  console.log('🌱 Seed data inserted successfully.');
  await app.close();
}

bootstrap();
