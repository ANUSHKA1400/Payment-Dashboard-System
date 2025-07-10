import {
  Controller,
  Get,
  Post,
  Param,
  Body,
  Query,
  UseGuards,
} from '@nestjs/common';
import { PaymentsService } from './payments.service';
import { Payment } from './payment.model';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@UseGuards(JwtAuthGuard)
@Controller('payments')
export class PaymentsController {
  constructor(private readonly paymentsService: PaymentsService) {}

  @Get()
  getAll(@Query('status') status?: string): Payment[] {
    return this.paymentsService.getAll(status);
  }

  @Get('stats')
  getStats() {
    return this.paymentsService.getStats();
  }

  @Get(':id')
  getById(@Param('id') id: string): Payment {
    return this.paymentsService.getById(id);
  }

  @Post()
  create(@Body() body: Omit<Payment, 'id' | 'date'>): Payment {
    return this.paymentsService.create(body);
  }
}
