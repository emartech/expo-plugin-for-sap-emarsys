import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  fetchMessages(): Promise<InboxMessage[]>;
  addTag(tag: string, messageId: string): Promise<void>;
  removeTag(tag: string, messageId: string): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsysInbox'
);

export type InboxMessageAction = {
  id: string;
  title: string;
  type: string;
  name?: string;
  payload?: Record<string, unknown>;
  url?: string;
};

export type InboxMessage = {
  id: string;
  campaignId: string;
  collapseId?: string;
  title: string;
  body: string;
  imageUrl?: string;
  receivedAt: number;
  updatedAt?: number;
  expiresAt?: string;
  tags?: string[];
  properties?: Record<string, unknown>;
  actions?: InboxMessageAction[];
};
