// src/users/users.service.ts
import { Injectable } from '@nestjs/common';
import { User } from './user.model';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class UsersService {
  private users: User[] = [
    { id: uuidv4(), username: 'admin', password: 'admin123', role: 'admin' },
  ];

  findAll(): User[] {
    return this.users;
  }

  create(user: Omit<User, 'id'>): User {
    const newUser = { id: uuidv4(), ...user };
    this.users.push(newUser);
    return newUser;
  }
}
