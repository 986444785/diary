//
//  publicVC.m
//  Diary
//
//  Created by 配得好 on 2017/11/27.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "publicVC.h"

@interface publicVC ()

@property(nonatomic) UILabel * publicLabel;

@end

@implementation publicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"转化" WithTitleColor:[UIColor redColor] withFont:15 target:self action:@selector(changeAttribute)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发布" WithTitleColor:[UIColor redColor] withFont:15 target:self action:@selector(publicAcction)];
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    NSString* string = @"现金收/刷卡收,样样精通";
    
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:string];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor greenColor]
                       range:NSMakeRange(0, 2)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14]
                       range:NSMakeRange(4, 2)];
    
 
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"dingdan_xiangqing"];
    attachment.bounds = CGRectMake(0, 0, 100, 100);
    NSAttributedString *attributed = [NSAttributedString attributedStringWithAttachment:attachment];
    [attrString appendAttributedString:attributed];

    
 

//    [attrString insertAttributedString:[[NSAttributedString alloc] initWithString:@"这是第二行图片"] atIndex:0];
    
//    [attrString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    
    NSTextAttachment *attachment2 = [[NSTextAttachment alloc] init];
    attachment2.image = [UIImage imageNamed:@"btn_orange"];
    attachment2.bounds = CGRectMake(0, 0, 100, 100);
    NSAttributedString *attributed2 = [NSAttributedString attributedStringWithAttachment:attachment2];
    [attrString appendAttributedString:attributed2];
    
    
    
    label.attributedText = attrString;
    
    
    _publicLabel = label;
}


-(void)changeAttribute
{
     
    
}


-(void)publicAcction{
    NSLog(@"发布");

  
    
    //删除
//    NSRange  range = NSMakeRange(0, 2);
// [_publicLabel.attributedText delete]
    
//    NSMutableAttributedString  * mutableString = (NSMutableAttributedString *)_publicLabel.attributedText;
//
//    [mutableString deleteCharactersInRange:range];
//
//
//    _publicLabel.attributedText = mutableString;

    
    
//    NSDictionary * dic = [_publicLabel.attributedText attributesAtIndex:0 effectiveRange:&range];
    
    
//    NSDictionary * dic =  [_publicLabel.attributedText attribute:@"NSFont" atIndex:1 effectiveRange:&range];

//    NSDictionary * dic =  [_publicLabel.attributedText attributesAtIndex:2 longestEffectiveRange:nil inRange:range];
//
//    NSLog(@"dic:%@",dic);
    
    
//    [_publicLabel.attributedText enumerateAttributesInRange:NSMakeRange(0, _publicLabel.attributedText.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//
//        NSLog(@"NSAttributeKey:%@",attrs[@"NSFontAttributeName"]);
//        id value = [_publicLabel.attributedText attribute:@"NSFontAttributeName" atIndex:0 effectiveRange:&range];
//        NSLog(@"value:%@",value);
//    }];
    
 
    
  
    
    __block NSMutableDictionary<NSString *,id> * _Nonnull attrsDict;
 __block UIFont *font;
    
    [_publicLabel.attributedText enumerateAttributesInRange:NSMakeRange(0, _publicLabel.attributedText.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        

        attrsDict = [NSMutableDictionary dictionaryWithDictionary:attrs];
     
        NSTextAttachment *attachment = attrs[@"NSAttachment"];

        if (attachment) {
            
            NSLog(@"图片的地址:%@",objc_getAssociatedObject(attachment, @"keyOfUserInfo"));
            
            // 添加表情
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            // 表情图片
            textAttachment.image = [UIImage imageNamed:@"add_orange"];
            
            // 设置图片大小
            textAttachment.bounds = CGRectMake(0, 0, 32, 32);
            
            
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n"];
            
            [attributedString insertAttributedString:attachmentString atIndex:0];
            
            
            
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:_publicLabel.attributedText];
            [attributedText replaceCharactersInRange:range withAttributedString:attributedString];

       
            _publicLabel.attributedText = attributedText;
        }
        
    
    }];
    
    

    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
