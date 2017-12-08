//
//  MyViewModel.m
//  Diary
//
//  Created by 配得好 on 2017/11/21.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "MyViewModel.h"
#import "SRActionSheet.h"
#import "MyVC.h"
#import "UserModel.h"

@interface MyViewModel () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation MyViewModel

 

//  http://127.0.0.1/My2017/ZYMySqlite/api.php?method=userInfo&u_id=2
#pragma Mark--- 请求个人资料
-(void)requestUserInfoWithHeaderView:(ZYTabHeaderView*)headerView{
    
        
    [[NetworkTool sharedTool] zyRequestWithURL:@"/My2017/ZYMySqlite/api.php?method=userInfo" method:@"POST" parameters:@{@"u_id":[ZYUserManager shareManager].userID} success:^(id response) {
        NSLog(@"xinxi   %@",response);
        
        UserModel * model = [UserModel yy_modelWithJSON:response[@"user"]];
        [headerView configHeaderViewModel:model];
        
    } failure:^(NSString *errorStr) {
        
    }];
    
}

#pragma mark ----退出登录




  
-(void)my_actionDelegate:(id)delegate{
    
    _delegatevc = delegate;

    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"更换头像"
                                                                cancelTitle:@"取消"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"拍照",@"从手机相册选择"]
                                                                otherImages:nil
                                                          selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                              NSLog(@"---   %zd", index);
                                                              
//
                                                              if (index == 1) {
                                                                          [self pickImageDelegate:delegate];
                                                              }
                                   
                                  
                                                          }];
    [actionSheet show];
    
    
}
#pragma mark ---- 修改头像
-(void)pickImageDelegate:(id)delegate{
    
    
//    _needUpLoad = NO;
    
    UIViewController * vc = delegate;
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:@"请打开相册权限"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });

    }
    
}
//读取后的代理回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  
  
    if (image) {
        //上传图片
        [[NetworkTool sharedTool]changeAvater:image complate:^(NSDictionary *dic) {
            
            NSLog(@"dic    %@",dic);
            
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            
            if ([dic[@"success"] intValue] == 1) {
                //刷新页面
                MyVC * myvc = _delegatevc;
                
                [myvc updateMyHeaderImageView:image];
                
            }
             
            
        } failure:^(NSString *errorStr) {
            
            [SVProgressHUD showErrorWithStatus:errorStr];
             
        }];
    }else{
        NSLog(@"没有图片");
    }
    
    
 
}


@end
