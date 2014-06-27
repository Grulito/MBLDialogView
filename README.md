iOS custom view for displaying bubble :) 

Sample code : 
-------------
```MBDialogView *dialogView = [[MBDialogView alloc] initWithFrame:CGRectMake(10, 420, 200, 70) andArrowDirection:MBLDirectionSouth andOffset:20];
UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15]; // light
UILabel *label             = [[UILabel alloc] initWithFrame:CGRectInset([dialogView getDialogFrame], 10, 0)];
label.text                     = @"Hello world ! How do you feel today ?";
label.lineBreakMode = NSLineBreakByWordWrapping;
label.numberOfLines = 0;
label.font                     = font;
[label setTextColor:[UIColor blackColor]];
[dialogView addSubview:label];
[self.view addSubview:dialogView];
```
