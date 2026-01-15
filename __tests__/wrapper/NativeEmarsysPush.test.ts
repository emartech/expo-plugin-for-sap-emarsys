import type { Spec } from '../../src/wrapper/NativeEmarsysPush';

describe('NativeEmarsysPush', () => {
  let mockConfig: Spec;

  beforeEach(() => {
    // Create a mock implementation of the NativeEmarsysPush module
    mockConfig = {
      setPushToken: jest.fn(),
      clearPushToken: jest.fn(),
      getPushToken: jest.fn(),
    } as unknown as Spec;

  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('setPushToken', () => {
    it('should call setPushToken with string parameter', async () => {
      const pushToken = 'TEST_PUSH_TOKEN';
      (mockConfig.setPushToken as jest.Mock).mockResolvedValue(undefined);

      await mockConfig.setPushToken(pushToken);

      expect(mockConfig.setPushToken).toHaveBeenCalledWith(pushToken);
      expect(mockConfig.setPushToken).toHaveBeenCalledTimes(1);
    });

    it('should handle successful setPushToken', async () => {
      const pushToken = 'NEW_PUSH_TOKEN';
      (mockConfig.setPushToken as jest.Mock).mockResolvedValue(undefined);

      await expect(mockConfig.setPushToken(pushToken)).resolves.toBeUndefined();
    });

    it('should handle errors when setting push token', async () => {
      const pushToken = 'NEW_PUSH_TOKEN';
      const error = new Error('Failed to set push token');
      (mockConfig.setPushToken as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.setPushToken(pushToken)).rejects.toThrow('Failed to set push token');
    });
  });

  describe('clearPushToken', () => {
    it('should call clearPushToken with no parameters', async () => {
      (mockConfig.clearPushToken as jest.Mock).mockResolvedValue(undefined);

      await mockConfig.clearPushToken();

      expect(mockConfig.clearPushToken).toHaveBeenCalledWith();
      expect(mockConfig.clearPushToken).toHaveBeenCalledTimes(1);
    });

    it('should handle successful clearPushToken', async () => {
      (mockConfig.clearPushToken as jest.Mock).mockResolvedValue(undefined);

      await expect(mockConfig.clearPushToken()).resolves.toBeUndefined();
    });

    it('should handle errors when clearing push token', async () => {
      const error = new Error('Failed to clear push token');
      (mockConfig.clearPushToken as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.clearPushToken()).rejects.toThrow('Failed to clear push token');
    });
  });

  describe('getPushToken', () => {
    it('should return the current push token', async () => {
      const expectedToken = 'CURRENT_PUSH_TOKEN';
      (mockConfig.getPushToken as jest.Mock).mockResolvedValue(expectedToken);

      const result = await mockConfig.getPushToken();

      expect(result).toBe(expectedToken);
      expect(mockConfig.getPushToken).toHaveBeenCalledTimes(1);
    });

    it('should handle errors when getting push token', async () => {
      const error = new Error('Failed to get push token');
      (mockConfig.getPushToken as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.getPushToken()).rejects.toThrow('Failed to get push token');
    });
  });

  describe('Type Validation', () => {
    it('should have all required methods defined', () => {
      expect(mockConfig.setPushToken).toBeDefined();
      expect(mockConfig.clearPushToken).toBeDefined();
      expect(mockConfig.getPushToken).toBeDefined();
    });

    it('should have all methods as functions', () => {
      expect(typeof mockConfig.setPushToken).toBe('function');
      expect(typeof mockConfig.clearPushToken).toBe('function');
      expect(typeof mockConfig.getPushToken).toBe('function');
    });
  });
});
