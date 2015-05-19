
#import <UIKit/UIKit.h>
@protocol DieLabelDelegate
- (void) wasDiceSelected: (UILabel *) sender;
@end

@interface DieLabel : UILabel
@property id<DieLabelDelegate> delegate;

- (void) roll;

@end
