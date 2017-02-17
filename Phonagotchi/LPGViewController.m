//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "LPGPetModel.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *createAppleImageView;

@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) IBOutlet UIPinchGestureRecognizer *fingerGesturePinch;
@property (nonatomic, strong) LPGPetModel *lpgPetModel;
//@property (nonatomic) BOOL isGrumpy;
@property CGPoint touchBegan;
@property CGPoint touchEnd;


@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    // Pet Image View
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Bucket Image View
    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket.png"];
    
    [self.view addSubview:self.bucketImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:150.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:150.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    

        
    
    self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.appleImageView.image = [UIImage imageNamed:@"apple.png"];
    
    


    [self.view addSubview:self.appleImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:50.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0 constant:50.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-25.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleImageView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:25.0]];
    
 
    
    // Pet Gesture
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(handleGesture:)];
    [self.petImageView addGestureRecognizer:_panGestureRecognizer];
    
    
    
    // Pinch Gesture
    _fingerGesturePinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handlePinch:)];
    
    [self.bucketImageView addGestureRecognizer:_fingerGesturePinch];
//    // Pan Gesture
//    UIPanGestureRecognizer *petPet = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(petThePet:)];
//    
//    [self.petImageView addGestureRecognizer: petPet];
//    
//    // Pinch Gesture
//    UIPinchGestureRecognizer *pickApple = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pickUpApple:)];
//    
//    [self.appleImageView addGestureRecognizer:pickApple];
//    
//    [self.petImageView addGestureRecognizer:fingerGesturePinch];
//    
    
    self.appleImageView.userInteractionEnabled = NO;
    self.bucketImageView.userInteractionEnabled = YES;
    self.petImageView.userInteractionEnabled = YES;
    
    self.appleImageView.alpha = 1;
    
    
    //extra movable apple
    CGRect newAppleFrame = CGRectMake(50, self.view.frame.size.height - 70, 50, 50);
    
    self.createAppleImageView = [[UIImageView alloc] initWithFrame:newAppleFrame];
    
    self.createAppleImageView.image = [UIImage imageNamed:@"apple.png"];
    
    self.createAppleImageView.userInteractionEnabled = NO;

    [self.view addSubview:self.createAppleImageView ];
}




- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:self.petImageView];
    //NSLog(@"WHAT IS CURRENT VELOCITY? %@", NSStringFromCGPoint(velocity));

    CGFloat dx = pow(fabs(velocity.x), 2.0);
    CGFloat dy = pow(fabs(velocity.y), 2.0);
    
    CGFloat combinedValue = sqrt(dx + dy);
    
    if(combinedValue > 750) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy.png"];
    }
    else {
        //NSLog(@"HERE?????");
    }
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer {
  //  NSLog(@"DID IT COME HERE11111?!");
    
    CGPoint pinchCenterPoint = [pinchRecognizer locationInView: nil];
    
    //if the apple view is pinched, then it keeps following it around the screen. Next step is to drop it over thecat
    
    if ([self.fingerGesturePinch state] == UIGestureRecognizerStateBegan) {
        
        
        // Do nothing
        
    }
    
    if ([self.fingerGesturePinch state] == UIGestureRecognizerStateChanged) {
        
        
        //NSLog(@"DID IT COME HERE2222?!");
        //CGPoint trackUserMovement = [pinchRecognizer locationInView:self.view];
        
        //create a new apple View to center
        
        //
        
        self.createAppleImageView.center = pinchCenterPoint;

        //NSLog(@"PRINT TRACK USER MOVEMENT%@", NSStringFromCGPoint(trackUserMovement));
        
    }
    
    if([self.fingerGesturePinch state] == UIGestureRecognizerStateEnded) {
        
        
        //IF it's on cat, drop at cat's stomach
        if(CGRectIntersectsRect(self.petImageView.frame, self.createAppleImageView.frame)) {
            //UIView ANimation
            [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.createAppleImageView.alpha = 0.0;
                
                
            } completion:^(BOOL finished){
                
                
                //this means, when the animation is doen, it gets reset to visible ( alpha = 1 ) and original position
                self.createAppleImageView.alpha = 1;
                
                self.createAppleImageView.frame = CGRectMake(50, self.view.frame.size.height - 70, 50, 50);
            }];

        }
        
        //IF it did not drop on bucket, then drop the apple to the bottom of the screen
        else{
            //UIView ANimation

            self.createAppleImageView.frame = CGRectMake(pinchCenterPoint.x, pinchCenterPoint.y, 50, 50);
            [UIView animateWithDuration:1.0 animations:^(void) {
                self.createAppleImageView.frame = CGRectMake(pinchCenterPoint.x, self.view.frame.size.height - 70, 50, 50);
            } completion:^(BOOL completion) {
                self.createAppleImageView.frame = CGRectMake(50, self.view.frame.size.height - 70, 50, 50);
            }];
            
        }

    }


    
    
}

@end
