//
//  IBHTMLLabel.h
//  InnerBand
//
//  InnerBand - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>


@interface IBHTMLLabel : UIWebView {
	NSString *_text;
	UITextAlignment _textAlignment;
	UIColor *_textColor;
	UIColor *_linkColor;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) UITextAlignment textAlignment;

#if __has_feature(objc_arc)
    @property (nonatomic, strong) UIColor *textColor;
    @property (nonatomic, strong) UIColor *linkColor;
#else
    @property (nonatomic, retain) UIColor *textColor;
    @property (nonatomic, retain) UIColor *linkColor;
#endif

@end
