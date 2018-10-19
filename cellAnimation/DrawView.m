//
//  DrawView.m
//  cellAnimation
//
//  Created by youxin on 2018/10/17.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawView

-(instancetype)init{
    if (self = [super init]) {
      
        self.path = [[UIBezierPath alloc] init];
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
         [[UIColor greenColor] setFill];
        [self.path setLineWidth:5];
    }
    return self;
}

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
    //create a mutable path
//    self.path = [[UIBezierPath alloc] init];
//    self.path.lineJoinStyle = kCGLineJoinRound;
//    self.path.lineCapStyle = kCGLineCapRound;
//    [self.path setLineWidth:5];
//    ￼_path.lineWidth = 5;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    
    //redraw the view
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    

  
    //draw path
    [[UIColor greenColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}

@end
