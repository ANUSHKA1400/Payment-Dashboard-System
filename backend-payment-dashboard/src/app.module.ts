import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { PaymentsModule } from './payments/payments.module';
import { UsersModule } from './users/users.module';

@Module({
  imports: [AuthModule, PaymentsModule, UsersModule],
})
export class AppModule {}
