// src/services/api.ts
import { Position } from '../types/game';

const CORE_API= 'https://8083-idx-tom-surface-1735204021370.cluster-a3grjzek65cxex762e4mwrzl46.cloudworkstations.dev';

export const gameApi = {
  async getPosition(): Promise<Position> {
    const response = await fetch(`${CORE_API}/position`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include',
    });
    
    if (!response.ok) throw new Error('Failed to fetch position');
    return response.json();
  },

  async updatePosition(position: Position): Promise<void> {
    const response = await fetch(`${CORE_API}/position`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include',
      body: JSON.stringify(position),
    });
    
    if (!response.ok) throw new Error('Failed to update position');
  }
};