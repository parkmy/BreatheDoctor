//
//  RFLayout.h
//  RFCircleCollectionView
//
//  Created by Arvin on 15/11/25.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RFLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) void(^changeOfsetBlock)(CGPoint point);

-(id)initWithItmSize:(CGSize)size;

@end
