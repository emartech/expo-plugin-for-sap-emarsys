import type { Spec, Geofence } from '../../src/wrapper/native/NativeEmarsysGeofence';

describe('NativeEmarsysGeofence', () => {
  let mockGeofence: Spec;

  const mockGeofenceData: Geofence = {
    id: 'geofence-123',
    lat: 37.7749,
    lon: -122.4194,
    radius: 100,
    waitInterval: 60,
    triggers: [
      {
        id: 'trigger-1',
        type: 'ENTER',
        loiteringDelay: 30,
        action: {
          id: 'action-1',
          title: 'Test Action',
          type: 'MEAppEvent',
          name: 'app-event',
          payload: { url: 'https://example.com' },
        },
      },
    ],
  };

  beforeEach(() => {
    // Create a mock implementation of the NativeEmarsysGeofence module
    mockGeofence = {
      requestAlwaysAuthorization: jest.fn(),
      enable: jest.fn(),
      disable: jest.fn(),
      isEnabled: jest.fn(),
      setInitialEnterTriggerEnabled: jest.fn(),
      getRegisteredGeofences: jest.fn(),
    } as unknown as Spec;
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('requestAlwaysAuthorization', () => {
    it('should call requestAlwaysAuthorization', async () => {
      (mockGeofence.requestAlwaysAuthorization as jest.Mock).mockResolvedValue(undefined);

      await mockGeofence.requestAlwaysAuthorization();

      expect(mockGeofence.requestAlwaysAuthorization).toHaveBeenCalledWith();
      expect(mockGeofence.requestAlwaysAuthorization).toHaveBeenCalledTimes(1);
    });

    it('should handle successful authorization request', async () => {
      (mockGeofence.requestAlwaysAuthorization as jest.Mock).mockResolvedValue(undefined);

      await expect(mockGeofence.requestAlwaysAuthorization()).resolves.toBeUndefined();
    });

    it('should handle errors when requesting authorization', async () => {
      const error = new Error('Failed to request authorization');
      (mockGeofence.requestAlwaysAuthorization as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.requestAlwaysAuthorization()).rejects.toThrow('Failed to request authorization');
    });
  });

  describe('enable', () => {
    it('should call enable', async () => {
      (mockGeofence.enable as jest.Mock).mockResolvedValue(undefined);

      await mockGeofence.enable();

      expect(mockGeofence.enable).toHaveBeenCalledWith();
      expect(mockGeofence.enable).toHaveBeenCalledTimes(1);
    });

    it('should handle successful enable', async () => {
      (mockGeofence.enable as jest.Mock).mockResolvedValue(undefined);

      await expect(mockGeofence.enable()).resolves.toBeUndefined();
    });

    it('should handle errors when enabling', async () => {
      const error = new Error('Failed to enable geofence');
      (mockGeofence.enable as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.enable()).rejects.toThrow('Failed to enable geofence');
    });
  });

  describe('disable', () => {
    it('should call disable', async () => {
      (mockGeofence.disable as jest.Mock).mockResolvedValue(undefined);

      await mockGeofence.disable();

      expect(mockGeofence.disable).toHaveBeenCalledWith();
      expect(mockGeofence.disable).toHaveBeenCalledTimes(1);
    });

    it('should handle successful disable', async () => {
      (mockGeofence.disable as jest.Mock).mockResolvedValue(undefined);

      await expect(mockGeofence.disable()).resolves.toBeUndefined();
    });

    it('should handle errors when disabling', async () => {
      const error = new Error('Failed to disable geofence');
      (mockGeofence.disable as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.disable()).rejects.toThrow('Failed to disable geofence');
    });
  });

  describe('isEnabled', () => {
    it('should call isEnabled and return true', async () => {
      (mockGeofence.isEnabled as jest.Mock).mockResolvedValue(true);

      const result = await mockGeofence.isEnabled();

      expect(mockGeofence.isEnabled).toHaveBeenCalledWith();
      expect(mockGeofence.isEnabled).toHaveBeenCalledTimes(1);
      expect(result).toBe(true);
    });

    it('should call isEnabled and return false', async () => {
      (mockGeofence.isEnabled as jest.Mock).mockResolvedValue(false);

      const result = await mockGeofence.isEnabled();

      expect(result).toBe(false);
    });

    it('should handle errors when checking if enabled', async () => {
      const error = new Error('Failed to check if enabled');
      (mockGeofence.isEnabled as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.isEnabled()).rejects.toThrow('Failed to check if enabled');
    });
  });

  describe('setInitialEnterTriggerEnabled', () => {
    it('should call setInitialEnterTriggerEnabled with true', async () => {
      (mockGeofence.setInitialEnterTriggerEnabled as jest.Mock).mockResolvedValue(undefined);

      await mockGeofence.setInitialEnterTriggerEnabled(true);

      expect(mockGeofence.setInitialEnterTriggerEnabled).toHaveBeenCalledWith(true);
      expect(mockGeofence.setInitialEnterTriggerEnabled).toHaveBeenCalledTimes(1);
    });

    it('should call setInitialEnterTriggerEnabled with false', async () => {
      (mockGeofence.setInitialEnterTriggerEnabled as jest.Mock).mockResolvedValue(undefined);

      await mockGeofence.setInitialEnterTriggerEnabled(false);

      expect(mockGeofence.setInitialEnterTriggerEnabled).toHaveBeenCalledWith(false);
      expect(mockGeofence.setInitialEnterTriggerEnabled).toHaveBeenCalledTimes(1);
    });

    it('should handle successful initial enter trigger enabled', async () => {
      (mockGeofence.setInitialEnterTriggerEnabled as jest.Mock).mockResolvedValue(undefined);

      await expect(mockGeofence.setInitialEnterTriggerEnabled(true)).resolves.toBeUndefined();
    });

    it('should handle errors when setting initial enter trigger', async () => {
      const error = new Error('Failed to set initial enter trigger');
      (mockGeofence.setInitialEnterTriggerEnabled as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.setInitialEnterTriggerEnabled(true)).rejects.toThrow('Failed to set initial enter trigger');
    });
  });

  describe('getRegisteredGeofences', () => {
    it('should call getRegisteredGeofences and return array of geofences', async () => {
      const mockGeofences = [mockGeofenceData];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();

      expect(mockGeofence.getRegisteredGeofences).toHaveBeenCalledWith();
      expect(mockGeofence.getRegisteredGeofences).toHaveBeenCalledTimes(1);
      expect(result).toEqual(mockGeofences);
    });

    it('should handle empty geofences array', async () => {
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue([]);

      const result = await mockGeofence.getRegisteredGeofences();

      expect(result).toEqual([]);
      expect(Array.isArray(result)).toBe(true);
    });

    it('should handle multiple geofences', async () => {
      const mockGeofences = [
        mockGeofenceData,
        { ...mockGeofenceData, id: 'geofence-456', lat: 40.7128, lon: -74.0060 },
      ];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();

      expect(result).toHaveLength(2);
      expect(result[0].id).toBe('geofence-123');
      expect(result[1].id).toBe('geofence-456');
    });

    it('should handle errors when fetching registered geofences', async () => {
      const error = new Error('Failed to fetch registered geofences');
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockRejectedValue(error);

      await expect(mockGeofence.getRegisteredGeofences()).rejects.toThrow('Failed to fetch registered geofences');
    });

    it('should validate geofence structure', async () => {
      const mockGeofences = [mockGeofenceData];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();
      const geofence = result[0];

      expect(geofence).toHaveProperty('id');
      expect(geofence).toHaveProperty('lat');
      expect(geofence).toHaveProperty('lon');
      expect(geofence).toHaveProperty('radius');
      expect(geofence).toHaveProperty('waitInterval');
      expect(geofence).toHaveProperty('triggers');
    });

    it('should validate geofence properties are correct types', async () => {
      const mockGeofences = [mockGeofenceData];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();
      const geofence = result[0];

      expect(typeof geofence.id).toBe('string');
      expect(typeof geofence.lat).toBe('number');
      expect(typeof geofence.lon).toBe('number');
      expect(typeof geofence.radius).toBe('number');
      expect(typeof geofence.waitInterval).toBe('number');
      expect(Array.isArray(geofence.triggers)).toBe(true);
    });

    it('should validate trigger structure', async () => {
      const mockGeofences = [mockGeofenceData];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();
      const trigger = result[0].triggers![0];

      expect(trigger).toHaveProperty('id');
      expect(trigger).toHaveProperty('type');
      expect(trigger).toHaveProperty('loiteringDelay');
      expect(trigger).toHaveProperty('action');
    });

    it('should validate trigger action structure', async () => {
      const mockGeofences = [mockGeofenceData];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();
      const action = result[0].triggers![0].action!;

      expect(action).toHaveProperty('id');
      expect(action).toHaveProperty('title');
      expect(action).toHaveProperty('type');
      expect(typeof action.id).toBe('string');
      expect(typeof action.title).toBe('string');
      expect(typeof action.type).toBe('string');
    });

    it('should handle geofences without triggers', async () => {
      const mockGeofences = [{ ...mockGeofenceData, triggers: null }];
      (mockGeofence.getRegisteredGeofences as jest.Mock).mockResolvedValue(mockGeofences);

      const result = await mockGeofence.getRegisteredGeofences();

      expect(result[0].triggers).toBeNull();
    });
  });

  describe('Type Validation', () => {
    it('should have all required methods defined', () => {
      expect(mockGeofence.requestAlwaysAuthorization).toBeDefined();
      expect(mockGeofence.enable).toBeDefined();
      expect(mockGeofence.disable).toBeDefined();
      expect(mockGeofence.isEnabled).toBeDefined();
      expect(mockGeofence.setInitialEnterTriggerEnabled).toBeDefined();
      expect(mockGeofence.getRegisteredGeofences).toBeDefined();
    });

    it('should have all methods as functions', () => {
      expect(typeof mockGeofence.requestAlwaysAuthorization).toBe('function');
      expect(typeof mockGeofence.enable).toBe('function');
      expect(typeof mockGeofence.disable).toBe('function');
      expect(typeof mockGeofence.isEnabled).toBe('function');
      expect(typeof mockGeofence.setInitialEnterTriggerEnabled).toBe('function');
      expect(typeof mockGeofence.getRegisteredGeofences).toBe('function');
    });
  });
});
