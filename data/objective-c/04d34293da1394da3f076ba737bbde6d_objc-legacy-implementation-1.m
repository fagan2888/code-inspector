@implementation INTF // expected-warning {{cannot find interface declaration for 'INTF'}}
@end

INTF* pi;

INTF* FUNC()
{
	return pi;
}