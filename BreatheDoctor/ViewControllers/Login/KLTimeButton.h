

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
typedef void (^ActionBlock)();

@interface KLTimeButton : UILabel

- (instancetype)initWithFrame:(CGRect)frame
               AndBeforeTitle:(NSString*)beforeStr
            AndWorkingMarkStr:(NSString*)markStr
                   AndTimeSum:(int)time
            AndTimeButtonStar:(void(^)(void))starBlock
            AndTimeButtonStop:(void(^)(void))stopBlock;

- (void)star;

@end
