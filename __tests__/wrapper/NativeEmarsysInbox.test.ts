import type { Spec, InboxMessage } from '../../src/wrapper/NativeEmarsysInbox';

describe('NativeEmarsysInbox', () => {
  let mockInbox: Spec;

  const mockInboxMessage: InboxMessage = {
    id: '123',
    campaignId: 'campaign-123',
    collapseId: 'collapse-123',
    title: 'Test Message',
    body: 'Test Body',
    imageUrl: 'https://example.com/image.png',
    receivedAt: 1234567890,
    updatedAt: 1234567890,
    expiresAt: '',
    tags: ['tag1', 'tag2'],
    properties: { key1: 'value1', key2: 'value2' },
    actions: [
      {
        id: 'action-1',
        title: 'Action 1',
        type: 'MEAppEvent',
        name: 'app-event',
        payload: { url: 'https://example.com' },
      },
    ],
  };

  beforeEach(() => {
    // Create a mock implementation of the NativeEmarsysInbox module
    mockInbox = {
      fetchMessages: jest.fn(),
      addTag: jest.fn(),
      removeTag: jest.fn(),
    } as unknown as Spec;
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('fetchMessages', () => {
    it('should call fetchMessages and return array of messages', async () => {
      const mockMessages = [mockInboxMessage];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();

      expect(mockInbox.fetchMessages).toHaveBeenCalledWith();
      expect(mockInbox.fetchMessages).toHaveBeenCalledTimes(1);
      expect(result).toEqual(mockMessages);
    });

    it('should handle empty messages array', async () => {
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue([]);

      const result = await mockInbox.fetchMessages();

      expect(result).toEqual([]);
      expect(Array.isArray(result)).toBe(true);
    });

    it('should handle multiple messages', async () => {
      const mockMessages = [
        mockInboxMessage,
        { ...mockInboxMessage, id: '456', title: 'Another Message' },
      ];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();

      expect(result).toHaveLength(2);
      expect(result[0].id).toBe('123');
      expect(result[1].id).toBe('456');
    });

    it('should handle errors when fetching messages', async () => {
      const error = new Error('Failed to fetch messages');
      (mockInbox.fetchMessages as jest.Mock).mockRejectedValue(error);

      await expect(mockInbox.fetchMessages()).rejects.toThrow('Failed to fetch messages');
    });
  });

  describe('addTag', () => {
    it('should call addTag with tag and messageId parameters', async () => {
      const tag = 'seen';
      const messageId = '123';
      (mockInbox.addTag as jest.Mock).mockResolvedValue(undefined);

      await mockInbox.addTag(tag, messageId);

      expect(mockInbox.addTag).toHaveBeenCalledWith(tag, messageId);
      expect(mockInbox.addTag).toHaveBeenCalledTimes(1);
    });

    it('should handle successful addTag', async () => {
      const tag = 'seen';
      const messageId = '456';
      (mockInbox.addTag as jest.Mock).mockResolvedValue(undefined);

      await expect(mockInbox.addTag(tag, messageId)).resolves.toBeUndefined();
    });

    it('should handle errors when adding tag', async () => {
      const tag = 'seen';
      const messageId = '789';
      const error = new Error('Failed to add tag');
      (mockInbox.addTag as jest.Mock).mockRejectedValue(error);

      await expect(mockInbox.addTag(tag, messageId)).rejects.toThrow('Failed to add tag');
    });
  });

  describe('removeTag', () => {
    it('should call removeTag with tag and messageId parameters', async () => {
      const tag = 'seen';
      const messageId = '123';
      (mockInbox.removeTag as jest.Mock).mockResolvedValue(undefined);

      await mockInbox.removeTag(tag, messageId);

      expect(mockInbox.removeTag).toHaveBeenCalledWith(tag, messageId);
      expect(mockInbox.removeTag).toHaveBeenCalledTimes(1);
    });

    it('should handle successful removeTag', async () => {
      const tag = 'seen';
      const messageId = '456';
      (mockInbox.removeTag as jest.Mock).mockResolvedValue(undefined);

      await expect(mockInbox.removeTag(tag, messageId)).resolves.toBeUndefined();
    });

    it('should handle errors when removing tag', async () => {
      const tag = 'seen';
      const messageId = '789';
      const error = new Error('Failed to remove tag');
      (mockInbox.removeTag as jest.Mock).mockRejectedValue(error);

      await expect(mockInbox.removeTag(tag, messageId)).rejects.toThrow('Failed to remove tag');
    });
  });

  describe('Type Validation', () => {
    it('should have all required methods defined', () => {
      expect(mockInbox.fetchMessages).toBeDefined();
      expect(mockInbox.addTag).toBeDefined();
      expect(mockInbox.removeTag).toBeDefined();
    });

    it('should have all methods as functions', () => {
      expect(typeof mockInbox.fetchMessages).toBe('function');
      expect(typeof mockInbox.addTag).toBe('function');
      expect(typeof mockInbox.removeTag).toBe('function');
    });
  });

  describe('Message Structure Validation', () => {
    it('should validate InboxMessage structure', async () => {
      const mockMessages = [mockInboxMessage];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();
      const message = result[0];

      expect(message).toHaveProperty('id');
      expect(message).toHaveProperty('campaignId');
      expect(message).toHaveProperty('title');
      expect(message).toHaveProperty('body');
      expect(message).toHaveProperty('tags');
      expect(message).toHaveProperty('properties');
      expect(message).toHaveProperty('actions');
    });

    it('should validate message tags are an array', async () => {
      const mockMessages = [mockInboxMessage];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();
      const message = result[0];

      expect(Array.isArray(message.tags)).toBe(true);
      expect(message.tags).toContain('tag1');
    });

    it('should validate message properties is an object', async () => {
      const mockMessages = [mockInboxMessage];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();
      const message = result[0];

      expect(typeof message.properties).toBe('object');
      expect(message.properties.key1).toBe('value1');
    });

    it('should validate message actions are an array', async () => {
      const mockMessages = [mockInboxMessage];
      (mockInbox.fetchMessages as jest.Mock).mockResolvedValue(mockMessages);

      const result = await mockInbox.fetchMessages();
      const message = result[0];

      expect(Array.isArray(message.actions)).toBe(true);
      expect(message.actions[0]).toHaveProperty('id');
      expect(message.actions[0]).toHaveProperty('title');
      expect(message.actions[0]).toHaveProperty('type');
    });
  });
});
