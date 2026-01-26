import type { Spec } from '../../src/wrapper/native/NativeEmarsysInApp';

describe('NativeEmarsysInApp', () => {
  let mockConfig: Spec;

  beforeEach(() => {
    // Create a mock implementation of the NativeEmarsysInApp module
    mockConfig = {
      pause: jest.fn(),
      resume: jest.fn(),
      isPaused: jest.fn(),
    } as unknown as Spec;

  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('pause', () => {
    it('should call pause', async () => {
      (mockConfig.pause as jest.Mock).mockResolvedValue(undefined);

      await mockConfig.pause();

      expect(mockConfig.pause).toHaveBeenCalledWith();
      expect(mockConfig.pause).toHaveBeenCalledTimes(1);
    });

    it('should handle successful pause', async () => {
      (mockConfig.pause as jest.Mock).mockResolvedValue(undefined);

      await expect(mockConfig.pause()).resolves.toBeUndefined();
    });

    it('should handle errors when calling pause', async () => {
      const error = new Error('Failed to pause');
      (mockConfig.pause as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.pause()).rejects.toThrow('Failed to pause');
    });
  });

  describe('resume', () => {
    it('should call resume', async () => {
      (mockConfig.resume as jest.Mock).mockResolvedValue(undefined);

      await mockConfig.resume();

      expect(mockConfig.resume).toHaveBeenCalledWith();
      expect(mockConfig.resume).toHaveBeenCalledTimes(1);
    });

    it('should handle successful resume', async () => {
      (mockConfig.resume as jest.Mock).mockResolvedValue(undefined);

      await expect(mockConfig.resume()).resolves.toBeUndefined();
    });

    it('should handle errors when calling resume', async () => {
      const error = new Error('Failed to resume');
      (mockConfig.resume as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.resume()).rejects.toThrow('Failed to resume');
    });
  });

  describe('isPaused', () => {
    it('should return the current pause status', async () => {
      const expectedStatus = true;
      (mockConfig.isPaused as jest.Mock).mockResolvedValue(expectedStatus);

      const result = await mockConfig.isPaused();

      expect(result).toBe(expectedStatus);
      expect(mockConfig.isPaused).toHaveBeenCalledTimes(1);
    });

    it('should handle errors when getting current pause status', async () => {
      const error = new Error('Failed to get current pause status');
      (mockConfig.isPaused as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.isPaused()).rejects.toThrow('Failed to get current pause status');
    });
  });

  describe('Type Validation', () => {
    it('should have all required methods defined', () => {
      expect(mockConfig.pause).toBeDefined();
      expect(mockConfig.resume).toBeDefined();
      expect(mockConfig.isPaused).toBeDefined();
    });

    it('should have all methods as functions', () => {
      expect(typeof mockConfig.pause).toBe('function');
      expect(typeof mockConfig.resume).toBe('function');
      expect(typeof mockConfig.isPaused).toBe('function');
    });
  });
});
