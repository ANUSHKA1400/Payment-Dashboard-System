export type Role = 'admin' | 'viewer';

export interface User {
  id: string;
  username: string;
  password: string;
  role: Role;
}
