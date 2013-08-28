//
//  UIView+UIView_MyExtention.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "UIView+UIView_MyExtention.h"

@implementation UIView (UIView_MyExtention)
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)originX{
    return self.frame.origin.x;
}
-(void)setOriginX:(CGFloat)originX{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)originY{
    return self.frame.origin.y;
}
-(void)setOriginY:(CGFloat)originY{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}
-(void)setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)sizeW{
    return self.frame.size.width;
}
-(void)setSizeW:(CGFloat)sizeW{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeW, self.frame.size.height);
}
-(CGFloat)sizeH{
    return self.frame.size.height;
}
-(void)setSizeH:(CGFloat)sizeH{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sizeH);
}
@end
