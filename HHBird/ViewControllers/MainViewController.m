//
//  MainViewController.m
//  HHBird
//
//  Created by Trần Hoàng Hà on 11/9/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import "MainViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define width_of_pipe 60.0f
#define height_of_pipe 450.0f
#define space 180.0f
#define deltaX 1.0f
#define width_of_bird birdRect.size.width
#define height_space 130.0f

@interface MainViewController ()
{
    NSTimer *myTimer;
    BOOL isHitY;
    BOOL isHitX;
    UIGestureRecognizer *tapGesture;
}
@property(nonatomic, weak) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIImageView *bird;
@property (weak, nonatomic) IBOutlet UIImageView *bottom1;
@property (weak, nonatomic) IBOutlet UIImageView *bottom2;
@property (weak, nonatomic) IBOutlet UIImageView *bottom3;
@property (weak, nonatomic) IBOutlet UIImageView *top1;
@property (weak, nonatomic) IBOutlet UIImageView *top2;
@property (weak, nonatomic) IBOutlet UIImageView *top3;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
-(IBAction)btnPlayPressed:(id)sender;
@end

@implementation MainViewController

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
    
    [_bird setHidden:YES];
    [_btnPlay setHidden:NO];
    
    //reset game
    [_bird setFrame:CGRectMake(32, 259, 50, 25)];
    
    CGRect bottom1Rect = _bottom1.frame;
    bottom1Rect.origin.x = SCREEN_WIDTH;
    bottom1Rect.origin.y = arc4random()%300 + height_space;
    [_bottom1 setFrame:bottom1Rect];
    
    CGRect bottom2Rect = _bottom2.frame;
    bottom2Rect.origin.x = SCREEN_WIDTH + width_of_pipe + space;
    bottom2Rect.origin.y = arc4random()%300 + height_space;
    [_bottom2 setFrame:bottom2Rect];
    
    CGRect bottom3Rect = _bottom3.frame;
    bottom3Rect.origin.x = SCREEN_WIDTH + width_of_pipe + space + width_of_pipe + space;
    bottom3Rect.origin.y = arc4random()%300 + height_space;
    [_bottom3 setFrame:bottom3Rect];

    
    CGRect top1Rect = _top1.frame;
    top1Rect.origin.x = SCREEN_WIDTH;
    top1Rect.origin.y = bottom1Rect.origin.y - height_space - height_of_pipe;
    [_top1 setFrame:top1Rect];
    
    CGRect top2Rect = _top2.frame;
    top2Rect.origin.x = SCREEN_WIDTH + width_of_pipe + space;
    top2Rect.origin.y = bottom2Rect.origin.y - height_space - height_of_pipe;
    [_top2 setFrame:top2Rect];
    
    CGRect top3Rect = _top3.frame;
    top3Rect.origin.x = SCREEN_WIDTH + width_of_pipe + space + width_of_pipe + space;
    top3Rect.origin.y = bottom3Rect.origin.y - height_space - height_of_pipe;
    [_top3 setFrame:top3Rect];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(whenBirdInteracsPipe)
                                                 name:@"Con chim ẳng"
                                               object:nil];
}

-(void)whenBirdInteracsPipe
{
    if (_bird.frame.origin.y <= 0) {
        DLog(@"Chet");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnPlayPressed:(id)sender
{
    [_btnPlay setHidden:YES];
    [_bird setHidden:NO];
    [self startTimer];
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenTapped)];
    [self.view addGestureRecognizer:tapGesture];

}

-(void)startTimer
{
    if (!myTimer) {
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.009
                                                   target:self
                                                 selector:@selector(movePipe)
                                                 userInfo:nil
                                                  repeats:YES];
    }
    [myTimer fire];
}

-(void)stopTimer
{
    if ([myTimer isValid]) {
        [myTimer invalidate];
    }
    myTimer = nil;
}

-(void)removeTapGesture
{
    if (tapGesture) {
        [self.view removeGestureRecognizer:tapGesture];
        tapGesture = nil;
    }
}

-(void)movePipe
{
    //bird move
    CGRect birdRect = _bird.frame;
    birdRect.origin.y += 1.1;
    [_bird setFrame:birdRect];
    
    //BOTTOM
    CGRect bottom1Rect = _bottom1.frame;
    bottom1Rect.origin.x -= deltaX;
    [_bottom1 setFrame:bottom1Rect];
    
    CGRect bottom2Rect = _bottom2.frame;
    bottom2Rect.origin.x -= deltaX;
    [_bottom2 setFrame:bottom2Rect];
    
    CGRect bottom3Rect = _bottom3.frame;
    bottom3Rect.origin.x -= deltaX;
    [_bottom3 setFrame:bottom3Rect];
    
    //TOP
    CGRect top1Rect = _top1.frame;
    top1Rect.origin.x -= deltaX;
    [_top1 setFrame:top1Rect];
    
    CGRect top2Rect = _top2.frame;
    top2Rect.origin.x -= deltaX;
    [_top2 setFrame:top2Rect];
    
    CGRect top3Rect = _top3.frame;
    top3Rect.origin.x -= deltaX;
    [_top3 setFrame:top3Rect];
    
    if (bottom1Rect.origin.x == -width_of_pipe) {
        bottom1Rect.origin.x = bottom3Rect.origin.x + width_of_pipe + space;
        bottom1Rect.origin.y = arc4random()%300 + height_space;
        [_bottom1 setFrame:bottom1Rect];
    }
    
    if (bottom2Rect.origin.x == -width_of_pipe) {
        bottom2Rect.origin.x = bottom1Rect.origin.x + width_of_pipe + space;
        bottom2Rect.origin.y = arc4random()%300 + height_space;
        [_bottom2 setFrame:bottom2Rect];
    }
    
    if (bottom3Rect.origin.x == -width_of_pipe) {
        bottom3Rect.origin.x = bottom2Rect.origin.x + width_of_pipe + space;
        bottom3Rect.origin.y = arc4random()%300 + height_space;
        [_bottom3 setFrame:bottom3Rect];
    }
    
    if (top1Rect.origin.x == -width_of_pipe) {
        top1Rect.origin.x = top3Rect.origin.x + width_of_pipe + space;
        top1Rect.origin.y = bottom1Rect.origin.y - height_space - height_of_pipe;
        [_top1 setFrame:top1Rect];
    }
    
    if (top2Rect.origin.x == -width_of_pipe) {
        top2Rect.origin.x = top1Rect.origin.x + width_of_pipe + space;
        top2Rect.origin.y = bottom2Rect.origin.y - height_space - height_of_pipe;
        [_top2 setFrame:top2Rect];
    }
    
    if (top3Rect.origin.x == -width_of_pipe) {
        top3Rect.origin.x = top2Rect.origin.x + width_of_pipe + space;
        top3Rect.origin.y = bottom3Rect.origin.y - height_space - height_of_pipe;
        [_top3 setFrame:top3Rect];
    }
    
    //When bird hit bottom
    if (birdRect.origin.y + birdRect.size.height >= _bottomView.frame.origin.y) {
        DLog(@"game over");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    //When bird hit top
    if (birdRect.origin.y <= -20) {
        DLog(@"game over");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_top1.frame, _bird.frame)) {
        DLog(@"bird_top1");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_top2.frame,  _bird.frame)) {
        DLog(@"bird_top2");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_top3.frame,  _bird.frame)) {
        DLog(@"bird_top3");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_bottom1.frame,  _bird.frame)) {
        DLog(@"bird_bottom1");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_bottom2.frame,  _bird.frame)) {
        DLog(@"bird_bottom2");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
    
    if (CGRectIntersectsRect(_bottom3.frame,  _bird.frame)) {
        DLog(@"bird_bottom3");
        [self stopTimer];
        [self removeTapGesture];
        [self viewDidLoad];
    }
}

-(void)screenTapped
{
    DLog(@"User tap on screen");

    __block CGRect birdRect = _bird.frame;
    [UIView animateWithDuration:0.2 animations:^{
        birdRect.origin.y -= 70;
        [_bird setFrame:birdRect];
    }];
}


@end
