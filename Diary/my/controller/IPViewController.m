//
//  IPViewController.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "IPViewController.h"

@interface IPViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tx;

@end
    
@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ZYUserManager * manager = [ZYUserManager shareManager];
    _tx.text = manager.ip;
}

- (IBAction)changeIP:(id)sender {
    
    if (_tx.text.length < 5) {
        
        return ;
    }
    
    ZYUserManager * manager = [ZYUserManager shareManager];
    [manager saveIP:_tx.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
