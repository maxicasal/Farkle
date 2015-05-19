//
//  ViewController.m
//  Farkle
//
//  Created by Maxi Casal on 10/8/14.
//  Copyright (c) 2014 Maxi Casal. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>
@property IBOutletCollection(DieLabel) NSArray *dieLabels;
@property NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property NSMutableDictionary *diceWithScore;
@property int actualTurn;
@property int lastRoll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dice = [[NSMutableArray alloc] init];
    self.diceWithScore = [[NSMutableDictionary alloc] init];
    for (DieLabel *actualLabel in self.dieLabels) {
        actualLabel.delegate = self;
    }
    self.actualTurn = 0;
    self.lastRoll = -1;
}
- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *actualLabel in self.dieLabels) {
        if (![self.dice containsObject:actualLabel]) {
            [actualLabel roll];
        }
    }
    self.diceWithScore =[[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)wasDiceSelected: (UILabel *) sender{
    sender.backgroundColor = [UIColor redColor];
    [self.dice addObject:sender];
    
    if ([[self.diceWithScore allKeys ] containsObject: sender.text]) {
        NSString *appearanceTime = [self.diceWithScore valueForKey:sender.text];
        int times = [appearanceTime intValue];
        times++;
        [self.diceWithScore setObject:[NSString stringWithFormat:@"%d", times] forKey:sender.text];
    }else{
        [self.diceWithScore setObject: [NSString stringWithFormat: @"%d",1] forKey:sender.text];
    }
    [self updateUserScore];
}

- (void) updateUserScore{
    int score = 0;
    if ([[self.diceWithScore allKeys] containsObject:@"1"]) {
        NSString *appearanceTime = [self.diceWithScore valueForKey:@"1"];
        int times = [appearanceTime intValue];
        if (times ==3) {
            score = 1000;
        }else if (times>3){
            score = ((times-3)*100) + 1000;
        }
        else{
            score = times*100;
        }
    }
    for (int i = 2; i<7; i++) {
        NSString *keyFromIndex = [NSString stringWithFormat:@"%d", i];
        if ([[self.diceWithScore allKeys] containsObject:keyFromIndex]) {
            NSString *appearanceTime = [self.diceWithScore valueForKey:keyFromIndex];
            int times = [appearanceTime intValue];
            if (times ==3) {
                score = 1000;
            }else
            {
                if (times>3 && i ==5){
                    score = ((times-3)*50) + 500;
                }
                else{
                    score = times*100;
                }
            }
        }
    }
    self.userScore.text = [NSString stringWithFormat:@"%d", score];
}

@end
