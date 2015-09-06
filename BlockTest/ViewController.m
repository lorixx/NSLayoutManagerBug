//
//  ViewController.m
//  BlockTest
//
//  Created by Zhisheng Huang on 9/1/15.
//  Copyright (c) 2015 BlockTest. All rights reserved.
//

#import "ViewController.h"

@interface TestCell : UITableViewCell

@property (nonatomic, copy) NSString *fontName;

@end

@implementation TestCell
{
  UIImageView *_textRenderedFromNSLayoutManager;
  UILabel *_textRenderedFromUILabel;

  NSString *_textString;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _textString = @"ggggg";
  }

  return self;
}

- (void)setFontName:(NSString *)fontName
{

  if ([_fontName isEqualToString:fontName]) return;

  [_textRenderedFromNSLayoutManager removeFromSuperview];
  [_textRenderedFromUILabel removeFromSuperview];

  _textRenderedFromNSLayoutManager = [[UIImageView alloc] initWithFrame:CGRectZero];

  NSAttributedString *string =
  [[NSAttributedString alloc]
   initWithString:_textString
   attributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:30.0] }];

  NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
  layoutManager.usesFontLeading = NO;


  NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:string];
  [textStorage addLayoutManager:layoutManager];

  NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(200, FLT_MAX)];
  textContainer.lineFragmentPadding = 0;
  textContainer.lineBreakMode = NSLineBreakByWordWrapping;

  [layoutManager addTextContainer:textContainer];
  [layoutManager ensureLayoutForTextContainer:textContainer];
  CGRect boundingRect = [layoutManager usedRectForTextContainer:textContainer];

  boundingRect.size.width = roundf(boundingRect.size.width);
  boundingRect.size.height = roundf(boundingRect.size.height);

  UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0.0);
  NSRange glyphRange = [layoutManager glyphRangeForTextContainer:textContainer];
  [layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:boundingRect.origin];
  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
  _textRenderedFromNSLayoutManager.image = viewImage;
  UIGraphicsEndImageContext();

  [self.contentView addSubview:_textRenderedFromNSLayoutManager];
  _textRenderedFromNSLayoutManager.frame = CGRectMake(10, 0, boundingRect.size.width, boundingRect.size.height);

  // Add a UILabel to compare.
  _textRenderedFromUILabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _textRenderedFromUILabel.attributedText = string;
  CGSize size = [_textRenderedFromUILabel sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
  [self.contentView addSubview:_textRenderedFromUILabel];
  _textRenderedFromUILabel.frame = CGRectMake(10 + CGRectGetMaxX(_textRenderedFromNSLayoutManager.frame), CGRectGetMinY(_textRenderedFromNSLayoutManager.frame), size.width, size.height);

  [self setNeedsLayout];
}

@end

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end


@implementation ViewController
{
  UITableView *_tableView;
  NSArray *_fonts;
}

static NSString *kTestCellIdentifier = @"testCellIdentifier";

- (void)loadView
{
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [_tableView registerClass:[TestCell class] forCellReuseIdentifier:kTestCellIdentifier];

  self.view = _tableView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _fonts = @[@"Helvetica",
             @"HelveticaNeue",
             @"HelveticaNeue-Bold",
             @"HelveticaNeue-BoldItalic",
             @"HelveticaNeue-CondensedBlack",
             @"HelveticaNeue-CondensedBold",
             @"HelveticaNeue-Italic",
             @"HelveticaNeue-Light",
             @"HelveticaNeue-LightItalic",
             @"HelveticaNeue-Medium",
             @"HelveticaNeue-MediumItalic",
             @"HelveticaNeue-UltraLight",
             @"HelveticaNeue-UltraLightItalic",
             @"HelveticaNeue-Thin",
             @"HelveticaNeue-ThinItalic"
             ];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  TestCell *cell = [_tableView dequeueReusableCellWithIdentifier:kTestCellIdentifier];
  cell.fontName = _fonts[indexPath.section];

  return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return _fonts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return _fonts[section];
}


@end
