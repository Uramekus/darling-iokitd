#ifndef IOKITD_IOPLATFORMEXPERTCDEVICE_H
#define IOKITD_IOPLATFORMEXPERTCDEVICE_H

#include "IOService.h"
#include "ServiceRegistry.h"
#import <Foundation/NSDictionary.h>
#import <Foundation/NSData.h>
#import <Foundation/NSString.h>

class IOPlatformExpertDevice : public IOService
{
public:
	IOPlatformExpertDevice();
	virtual ~IOPlatformExpertDevice();

	static void registerSelf(ServiceRegistry* targetRegistry);

	const char* className() const override { return "IOPlatformExpertDevice"; }
	NSDictionary* matchingDictionary() override;
	NSDictionary* getProperties() override;
	bool conformsTo(const char* className) override;

private:
	NSDictionary* m_props;
};

#endif
