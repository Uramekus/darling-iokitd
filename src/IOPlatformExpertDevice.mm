#include "IOPlatformExpertDevice.h"
#include <IOKit/IOKitLib.h>
#include <cstring>

IOPlatformExpertDevice::IOPlatformExpertDevice()
{
	const char model_str[] = "MacBookPro16,1";
	const char mfg_str[] = "Apple Inc.";
	const char ver_str[] = "1.0";
	const char board_str[] = "Mac-E7203C0F68AA0004";
	uint32_t clock_freq = 2400000000;
	uint32_t bus_freq = 100000000;
	uint32_t timebase_freq = 1000000000;

	m_props = [@{
		@"model": [NSData dataWithBytes:model_str length:sizeof(model_str)],
		@"manufacturer": [NSData dataWithBytes:mfg_str length:sizeof(mfg_str)],
		@"version": [NSData dataWithBytes:ver_str length:sizeof(ver_str)],
		@"board-id": [NSData dataWithBytes:board_str length:sizeof(board_str)],
		@"clock-frequency": [NSData dataWithBytes:&clock_freq length:sizeof(clock_freq)],
		@"bus-frequency": [NSData dataWithBytes:&bus_freq length:sizeof(bus_freq)],
		@"timebase-frequency": [NSData dataWithBytes:&timebase_freq length:sizeof(timebase_freq)],
		@"IOPlatformSerialNumber": @"C02SG0000000",
		@"IOPlatformUUID": @"00000000-0000-0000-0000-000000000000",
		@"IOClass": @"IOPlatformExpertDevice",
		@"IOProviderClass": @"IOPlatformExpertDevice"
	} retain];
}

IOPlatformExpertDevice::~IOPlatformExpertDevice()
{
	[m_props release];
}

NSDictionary* IOPlatformExpertDevice::matchingDictionary()
{
	return @{
		@"IOProviderClass": @"IOPlatformExpertDevice",
		@"IOClass": @"IOPlatformExpertDevice"
	};
}

NSDictionary* IOPlatformExpertDevice::getProperties()
{
	return m_props;
}

bool IOPlatformExpertDevice::conformsTo(const char* className)
{
	if (std::strcmp(className, "IOPlatformExpertDevice") == 0 ||
	    std::strcmp(className, "IOPlatformDevice") == 0 ||
	    std::strcmp(className, "IOPlatformExpert") == 0)
	{
		return true;
	}
	return IOService::conformsTo(className);
}

void IOPlatformExpertDevice::registerSelf(ServiceRegistry* targetRegistry)
{
	IOPlatformExpertDevice* dev = new IOPlatformExpertDevice();
	targetRegistry->registerService(dev);
	dev->registerInPlane(kIOServicePlane, "IOPlatformExpertDevice", IORegistryEntry::root());
}
