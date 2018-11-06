//
//  ViewController.m
//  lesson2
//
//  Created by 高志刚 on 15/5/29.
//  Copyright (c) 2015年 高志刚. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SoundArray.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerShower;

@property (weak, nonatomic) IBOutlet UIButton *StartGameButton;
@property (strong,nonatomic) NSNumber *current_minut;
@property (strong,nonatomic) NSNumber *current_second;

@property (nonatomic) BOOL  isrunning;
@property (nonatomic,strong) SoundArray* Sa;


@end

@implementation ViewController

@synthesize Sa=_sa;

- (SoundArray* )Sa
{
    if (!_sa)
    {
        _sa = [[SoundArray alloc] init];
    }
    return _sa;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize timerShower=_timerShower111;
@synthesize current_minut=_current_minut111;
@synthesize isrunning=_isrunning;

static SystemSoundID shake_sound_male_id = 0;

- (NSNumber *)current_minut
{
    if (_current_minut111 == nil ) _current_minut111=[[NSNumber alloc]init];
    return _current_minut111;
}

-(void)UpdateString:(NSTimer *)theTimer
{
    if (self.current_minut.intValue <10 )
    {
    //NSString *astring = [[NSString alloc] initWithString:[NSString stringWithFormat:@"00:%d",self.current_minut.intValue]];
        self.timerShower.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d:0%d",self.current_second.intValue, self.current_minut.intValue]];
        
        

    }
    else if ( self.current_minut.intValue >=10 && self.current_minut.intValue < 60)
    {
        self.timerShower.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d:%d",self.current_second.intValue ,   self.current_minut.intValue]];
     


    }
    else
    {
        self.current_second = [NSNumber numberWithInt:(self.current_second.intValue +  1)];
        self.current_minut = 0 ;
        self.timerShower.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d:%d",self.current_second.intValue,  self.current_minut.intValue]];
     //   AudioServicesPlaySystemSound(1106);
    }
    //self.timerShower.text=astring;
    self.current_minut = [NSNumber numberWithInt:(self.current_minut.intValue +  1)];


}

-(void)WarningEvery30:(NSTimer *)theTimer
{
       // AudioServicesPlaySystemSound(shake_sound_male_id);
    [self.Sa pushsound:shake_sound_male_id];
}
-(void)WarningEvery60:(NSTimer *)theTimer
{

     //   AudioServicesPlaySystemSound(shake_sound_male_id);
    [self.Sa pushsound:shake_sound_male_id];

 }


- (IBAction)StartGameButtonIMP:(UIButton *)sender {
    //NSString *timerstring=[sender currentTitle];
    //NSLog(@"timerstring is %@",timerstring);
    //UILabel *myDisplay = self.timerShower; //[self timerShower];
    //NSString *currenttitle = [myDisplay text];
    //NSLog(@"current lable title is %@",currenttitle);
    //NSString *newtitle=[currenttitle stringByAppendingString:timerstring];
    //[myDisplay setText:newtitle]; //myDisplay.text = newtitle;
                                    //self.timerShower.txt=newtitle
    self.timerShower.text=@"00:00";
    self.current_minut= 0;
    self.current_second= 0;
    if (self.isrunning == NO )
    {
        [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(UpdateString:) userInfo:nil repeats:YES];// show the string
        [NSTimer scheduledTimerWithTimeInterval:(30.0) target:self selector:@selector(WarningEvery30:) userInfo:nil repeats:YES];//30 second warning
        [NSTimer scheduledTimerWithTimeInterval:(60.0) target:self selector:@selector(WarningEvery60:) userInfo:nil repeats:YES];//60 second warning
        self.isrunning =YES;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"xiaobinshuaxin" ofType:@"m4a"];
        if (path) {
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
                        //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
        }
        [UIApplication sharedApplication].idleTimerDisabled = YES;//设置不允许休眠


    }


}





@end
