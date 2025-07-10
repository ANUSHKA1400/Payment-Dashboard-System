import { Injectable, NotFoundException, OnModuleInit } from '@nestjs/common';
import { Payment } from './payment.model';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class PaymentsService implements OnModuleInit {
  private payments: Payment[] = [];

  // ✅ Automatically called when app/module starts
  onModuleInit() {
    this.seed();
  }

  getAll(status?: string): Payment[] {
    if (status) {
      return this.payments.filter((p) => p.status === status);
    }
    return this.payments;
  }

  getById(id: string): Payment {
    const payment = this.payments.find((p) => p.id === id);
    if (!payment) {
      throw new NotFoundException('Payment not found');
    }
    return payment;
  }

  create(data: Omit<Payment, 'id' | 'date'>): Payment {
    const newPayment: Payment = {
      id: uuidv4(),
      date: new Date(),
      ...data,
    };
    this.payments.push(newPayment);
    return newPayment;
  }

  getStats() {
    const today = new Date().toISOString().split('T')[0];

    const totalToday = this.payments.filter((p) =>
      (p.date instanceof Date ? p.date.toISOString() : '').startsWith(today),
    ).length;

    const totalRevenue = this.payments
      .filter((p) => p.status === 'success')
      .reduce((sum, p) => sum + p.amount, 0);

    const failedCount = this.payments.filter(
      (p) => p.status === 'failed',
    ).length;

    return {
      totalToday,
      totalRevenue,
      failedCount,
    };
  }

  // ✅ Sample seeding function
  seed() {
    const sample: Omit<Payment, 'id' | 'date'>[] = [
      {
        amount: 1200,
        method: 'UPI',
        receiver: 'John Doe',
        status: 'success',
      },
      {
        amount: 500,
        method: 'Card',
        receiver: 'Alice',
        status: 'failed',
      },
      {
        amount: 2500,
        method: 'Netbanking',
        receiver: 'Bob',
        status: 'success',
      },
      {
        amount: 800,
        method: 'Cash',
        receiver: 'Charlie',
        status: 'pending',
      },
      {
        amount: 1600,
        method: 'UPI',
        receiver: 'Diana',
        status: 'success',
      },
    ];

    sample.forEach((data) => this.create(data));
  }
}
