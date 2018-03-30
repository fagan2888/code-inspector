#import "NickTitleStackBlurVC.h"
#import "UIImage+StackBlur.h"
#import <QuartzCore/QuartzCore.h>

@implementation NickTitleStackBlurVC

@synthesize maskHolder;
@synthesize maskView;
@synthesize normalView;
@synthesize blurView;
@synthesize overlayView;
@synthesize blurImage;

double currVal;
BOOL isBlurred;

enum {
    out = 0,
    in = 1
};

- (void)viewDidLoad {
    [super viewDidLoad];
	source=[UIImage imageNamed:@"angrycat.png"];
    currVal = 0;
    isBlurred = 1;

    //*******************************************************

//  COMMENT OUT ANY OF THE FOLLOWING VIEWS TO GET A LOOK AT WHAT EACH ONE DOES

    //*******************************************************

    //This view holds the mask itself - set the image to be whatever shape mask you want
    maskHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [maskHolder setBackgroundColor:[UIColor whiteColor]];
    maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [maskView setContentMode:UIViewContentModeScaleToFill];
    [maskView setImage:[UIImage imageNamed:@"mask.png"]];
    [maskView setCenter:CGPointMake(320, maskView.center.y)];
    [maskHolder addSubview:maskView];

    //This view holds the non-blurred portion of the original image
    normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [normalView setImage:source];
    [normalView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:normalView];

    //This view creates the blurred view from the underlying source
    blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [overlayView setImage:source];
    [overlayView setContentMode:UIViewContentModeScaleAspectFill];
    blurImage = [UIImage new];
    blurImage = [source stackBlur:15];
    [blurView setImage:blurImage];
    
    //This view contains the masked/blurred portion of the image
    overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [overlayView setImage:source];
    [overlayView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:overlayView];

    //This lets you tap the screen for automatic animation
    UITapGestureRecognizer *simpleTap = [UITapGestureRecognizer new];
    [simpleTap addTarget:self action:@selector(runAnimate)];
    [overlayView addGestureRecognizer:simpleTap];
    [overlayView setUserInteractionEnabled:TRUE];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//*******************************************************

//  Where the image is set for overlay view, it grabs the blurred version of the underlying image at its current location, then applies it masked on top of the normal image
//  this happens in both "sliderChanged" and "incrementAnimation"

//*******************************************************

- (IBAction) sliderChanged:(UISlider *)sender
{
    double sVal = sender.value;
    [maskView setCenter:CGPointMake(sender.value/20 * 100 + 100, maskView.center.y)];
    [normalView setCenter:CGPointMake(180+sVal, normalView.center.y)];
    [overlayView setCenter:CGPointMake(180+sVal, overlayView.center.y)];
    [overlayView setImage:[self maskImage:blurView.image withMask:[self captureView:maskHolder]]];
    currVal = sVal;
}

- (void)runAnimate {
        [self queueAnimation];
}


    // This method moves you towards a target x-offset and lets the animation increment itself automatically
- (void)queueAnimation {
    int targetNormalCenter;
    if (!isBlurred) {
        targetNormalCenter = 180;
    }
    else {
        targetNormalCenter = 200;
    }
    if (abs(normalView.center.x-targetNormalCenter)>2) {
        [self incrementAnimation:isBlurred];
    }
    else {
        isBlurred = !isBlurred;
    }
}

-(void)incrementAnimation:(BOOL)upBool {
    int newX;
    int backgroundCenter = normalView.center.x;
    if (!upBool) {
        newX = 2;
    }
    else {
        newX = -2;
    }
    CGPoint nP = CGPointMake((backgroundCenter-newX), normalView.center.y);
    CGPoint oP = CGPointMake((backgroundCenter-newX), overlayView.center.y);
    CGPoint mP = CGPointMake(((200-backgroundCenter)*9) + 180, maskView.center.y);
    
    [normalView setCenter:nP];
    [overlayView setCenter:oP];
    [maskView setCenter:mP];

    overlayView.image = nil;
    UIImage *mask = [self captureView:maskHolder];
    UIImage *newOverlay = [self maskImage:blurView.image withMask:mask];
    [overlayView setImage:newOverlay];
    mask = nil;
    newOverlay = nil;
    [self performSelector:@selector(queueAnimation) withObject:nil afterDelay:.01];
    return;
}


- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    ctx = nil;
    
    return newImage;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef srcImg  = image.CGImage;
	CGImageRef maskRef = maskImage.CGImage;
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask(srcImg, mask);
    UIImage *result = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(masked);
    CGImageRelease(mask);
    
	return result;
}

- (void)dealloc {
    [imagePreview dealloc];
    [super dealloc];
}

@end
