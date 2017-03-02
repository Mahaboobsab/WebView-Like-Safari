//
//  BazzonWebViewController.h
//  BazzonIn
//
//  Created by Bhagyashree and Meheboob
//  Copyright © 2017 bazzon.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BazzonWebViewController : UIViewController<UIWebViewDelegate>
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *bazzonWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtnOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtnOutlet;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;

@property (weak, nonatomic) IBOutlet UIView *backgroundActivityView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)stopLoadingAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLabel;@end
