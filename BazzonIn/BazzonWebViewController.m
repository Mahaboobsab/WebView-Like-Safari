//
//  BazzonWebViewController.m
//  BazzonIn
//
//  Created by Bhagyashree and Meheboob
//  Copyright © 2017 bazzon.in. All rights reserved.
//

#import "BazzonWebViewController.h"

@interface BazzonWebViewController ()<UIScrollViewDelegate>

@end

@implementation BazzonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.backgroundActivityView.layer.cornerRadius = 5;
    self.backgroundActivityView.layer.masksToBounds = YES;
    
    
    self.networkErrorLabel.hidden = YES;
    NSURL *websiteUrl = [NSURL URLWithString:@"http://bazzon.in"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.bazzonWebView loadRequest:urlRequest];
    self.backgroundActivityView.hidden = NO;
    [self.activityIndicator startAnimating];
    
    [self.bazzonWebView.scrollView setDelegate:self];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareAction:(id)sender {
    
    
    NSString *currentBazzonURL = self.bazzonWebView.request.URL.absoluteString;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // These next two lines are necessary for iPad and wide layouts.
    alertController.popoverPresentationController.sourceView = self.view;
    alertController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);
    
    // create a message
    //UIImage *image=self.snapShtImg.image;
    // NSString *str=@"Image form My app";
    NSArray *postItems=@[currentBazzonURL];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        controller.modalPresentationStyle = UIModalPresentationPopover;
        
        controller.popoverPresentationController.sourceView = self.view;
        controller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}



- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.bazzonWebView.hidden = NO;
    self.networkErrorLabel.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.backgroundActivityView.hidden = NO;
    [self.activityIndicator startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.bazzonWebView.hidden = NO;
    self.networkErrorLabel.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.backgroundActivityView.hidden = YES;
    [self.activityIndicator stopAnimating];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (error.code == NSURLErrorNotConnectedToInternet) {
        self.networkErrorLabel.hidden = NO;
        self.bazzonWebView.hidden = YES;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.backgroundActivityView.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Mobile Data is Turned Off"
                                                                       message:@"Turn On mobile data or use Wi-Fi to access data."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                              
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=USAGE/CELLULAR_USAGE"] options:@{} completionHandler:nil];
                                                                  
                                                              }];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
         [alert addAction:settingsAction];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    if ([self.bazzonWebView canGoBack])
    {
        [self.backBtnOutlet setEnabled:YES];
    }
    else
    {
        [self.backBtnOutlet setEnabled:NO];
    }
    if ([self.bazzonWebView canGoForward])
    {
        [self.forwardBtnOutlet setEnabled:YES];
    }
    else
    {
        [self.forwardBtnOutlet setEnabled:NO];
    }
    return YES;
}

- (IBAction)stopLoadingAction:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.backgroundActivityView.hidden = YES;
    [self.activityIndicator stopAnimating];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y == 0) {
        //show
       
        [self.navigationController setNavigationBarHidden:NO animated:YES];
       // [self.navigationController setToolbarHidden:NO animated:YES];
        
        
    } else {
                [self.navigationController setNavigationBarHidden:YES animated:YES];
        //[self.navigationController setToolbarHidden:YES animated:YES];
        
       
    }
}

@end
