export type PaymentStatus = 'success' | 'failed' | 'pending';

export interface Payment {
  id: string;
  amount: number;
  method: string;
  status: PaymentStatus;
  receiver: string;
  date: Date;
}
