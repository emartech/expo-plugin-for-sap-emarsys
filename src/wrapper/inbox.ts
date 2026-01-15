export { default, type Message, type ActionModel } from './native/NativeEmarsysInbox';

export const Tag = {
  high: 'high',
  cancelled: 'cancelled',
  seen: 'seen',
  opened: 'opened',
  pinned: 'pinned',
  deleted: 'deleted'
} as const;
