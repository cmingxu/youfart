//
//  ViewController.m
//  YouFart
//
//  Created by kevin  on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
@synthesize fartButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setFartButton:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    [self becomeFirstResponder];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    [fartButton release];
    [imageView release];
    [super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self btnClick:nil];
}


/* Both these actions are hooked up to buttons in IB */
- (IBAction)btnClick:(UIButton *)sender {
        /*
         * Here we grab our path to our resource
         */
        NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
        resourcePath = [resourcePath stringByAppendingString:@"/fart-wav-2.wav"];
        NSLog(@"Path to play: %@", resourcePath);
        NSError* err;
        
        //Initialize our player pointing to the path to our resource
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                  [NSURL fileURLWithPath:resourcePath] error:&err];
        
        if( err ){
            //bail!
            NSLog(@"Failed with reason: %@", [err localizedDescription]);
        }
        else{
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
            [player play];
        }
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"fart%d.jpg", arc4random() % 5]];
    [self.view setNeedsDisplay];
    
}



- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake)
	{
    
       
        [self btnClick:nil];
	}
}

-(BOOL)canBecomeFirstResponder{
	return YES;
}

@end
