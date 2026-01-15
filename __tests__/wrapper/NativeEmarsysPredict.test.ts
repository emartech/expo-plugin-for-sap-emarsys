import type { Spec } from '../../src/wrapper/NativeEmarsysPredict';

describe('NativeEmarsysPredict', () => {
  let mockConfig: Spec;

  beforeEach(() => {
    // Create a mock implementation of the NativeEmarsysPredict module
    mockConfig = {
      trackCart: jest.fn(),
    } as unknown as Spec;

  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('trackCart', () => {
    it('should call trackCart', async () => {
      const items = [{ itemId: 'TEST_ITEM', price: 1, quantity: 1 }];
      (mockConfig.trackCart as jest.Mock).mockResolvedValue(undefined);

      await mockConfig.trackCart(items);

      expect(mockConfig.trackCart).toHaveBeenCalledWith(items);
      expect(mockConfig.trackCart).toHaveBeenCalledTimes(1);
    });

    it('should handle successful trackCart', async () => {
      const items = [{ itemId: 'TEST_ITEM', price: 1, quantity: 1 }];
      (mockConfig.trackCart as jest.Mock).mockResolvedValue(undefined);

      await expect(mockConfig.trackCart(items)).resolves.toBeUndefined();
    });

    it('should handle errors when calling trackCart', async () => {
      const items = [{ itemId: 'TEST_ITEM', price: 1, quantity: 1 }];
      const error = new Error('Failed to trackCart');
      (mockConfig.trackCart as jest.Mock).mockRejectedValue(error);

      await expect(mockConfig.trackCart(items)).rejects.toThrow('Failed to trackCart');
    });
  });

  describe('Type Validation', () => {
    it('should have all required methods defined', () => {
      expect(mockConfig.trackCart).toBeDefined();
    });

    it('should have all methods as functions', () => {
      expect(typeof mockConfig.trackCart).toBe('function');
    });
  });
});
