import { TurboModuleRegistry, type TurboModule } from 'react-native';
import type { UnsafeObject } from 'react-native/Libraries/Types/CodegenTypes';

export interface Spec extends TurboModule {
  fetchMessages(): Promise<Message[]>;
  addTag(tag: Tag, messageId: string): Promise<void>;
  removeTag(tag: Tag, messageId: string): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsysInbox'
);

export type Message = {
  id: string;
  campaignId: string;
  collapseId?: string | null;
  title: string;
  body: string;
  imageUrl?: string | null;
  imageAltText?: string | null;
  receivedAt: number;
  updatedAt?: number | null;
  expiresAt?: string | null;
  tags?: Tag[] | null;
  properties?: UnsafeObject | null;
  actions?: ActionModel[] | null;
};

// Section 'Message Tag' https://help.sap.com/docs/SAP_EMARSYS/f8e2fafeea804018a954a8857d9dfff3/fde932f574c110148f40ac115cc13b56.html?locale=en-US
export type Tag = 'high' | 'cancelled' | 'seen' | 'opened' | 'pinned' | 'deleted';

export type ActionModel = {
  id: string;
  title: string;
  type: string;
  name?: string | null;
  payload?: UnsafeObject | null;
  url?: string | null;
};
