//
//  CanvasViewController.m
//  Canvas
//
//  Created by Jason Chua on 6/28/14.
//  Copyright (c) 2014 Jason Chua. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (strong, nonatomic) UIImageView *currentImageView;


- (IBAction)onTrayPan:(UIPanGestureRecognizer *)sender;
- (IBAction)onPan:(UIPanGestureRecognizer *)sender;

@end

@implementation CanvasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTrayPan:(UIPanGestureRecognizer *)sender {
    //move tray
}

- (IBAction)onPan:(UIPanGestureRecognizer *)panGesture {
    UIImageView *originalImageView = (UIImageView *)panGesture.view;  // This is the view that was first dragged
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        // Create the new image

        
        self.currentImageView = [[UIImageView alloc] initWithFrame:originalImageView.frame];
        self.currentImageView.userInteractionEnabled = YES;
        self.currentImageView.image = originalImageView.image;
        [self.view addSubview:self.currentImageView];
        
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        // Change the position of the new image view
        self.currentImageView.center = [panGesture locationInView:self.view];
    } else if (panGesture.state == UIGestureRecognizerStateEnded){
        UIPanGestureRecognizer *canvasPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCanvasPan:)];
        [self.currentImageView addGestureRecognizer:canvasPan];
        
        UIRotationGestureRecognizer *canvasRotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onCanvasRotation:)];
        [self.currentImageView addGestureRecognizer:canvasRotation];
        
        UIPinchGestureRecognizer *canvasPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onCanvasPinch:)];
        [self.currentImageView addGestureRecognizer:canvasPinch];
    }
}

- (void)onCanvasPan:(UIPanGestureRecognizer *)sender {
    sender.view.center = [sender locationInView:self.view];
}

- (void)onCanvasRotation:(UIRotationGestureRecognizer *)sender {
   // sender.view.center = [sender locationInView:self.view];
}

- (void)onCanvasPinch:(UIPinchGestureRecognizer *)sender {
    sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
}
@end
