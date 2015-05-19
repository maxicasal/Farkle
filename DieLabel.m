

#import "DieLabel.h"

@implementation DieLabel

- (IBAction)onTapped :(UITapGestureRecognizer *)sender{
    [self.delegate wasDiceSelected:self];
}

- (void) roll{
    int randomNumber = arc4random_uniform(6)+1;
    NSString *key = @"";
    switch (randomNumber) {
        case 1:
            key = @"One";
            break;
        case 2:
            key = @"Two";
            break;
        case 3:
            key = @"Three";
            break;
        case 4:
            key = @"Four";
            break;
        case 5:
            key = @"Five";
            break;
        case 6:
            key = @"Six";
            break;
            
        default:
            break;
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width -15, self.frame.size.height -15)];
    [image setImage:[UIImage imageNamed:key]];
    [self addSubview:image];
    self.text = [NSString stringWithFormat:@"%d", randomNumber];
}


@end
