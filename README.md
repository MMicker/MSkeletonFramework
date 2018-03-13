#MSkeletonFramework
##前言
[MSkeletonFramework](https://github.com/MMicker/MSkeletonFramework),显示页面视图的框架结构
##简介
*  用在页面未显示真实数据之前，提前显示页面视图的框架结构；

##功能
*  支持所有UIView及其子类进行骨架结构；
*  针对UILabel,UITextView,展示多行骨架；
*  对集合类UITableView,UICollectionView进行了支持
*  骨架支持单一颜色及激变颜色的设置；


##效果图展示
为更好的展示效果，请耐心等待     
<img src="https://raw.githubusercontent.com/MMicker/MSkeletonFramework/master/images/detail.gif" width="50%">
<img src="https://raw.githubusercontent.com/MMicker/MSkeletonFramework/master/images/tbh.jpeg" width="50%">

##参数说明
```
/**
 全局设置颜色，骨架展示类型，骨架高度及其间距
 */
@interface MSkeletonConfig : NSObject

@property (nonatomic, strong) NSArray *tintColors;      // default is 236,236,236
@property (nonatomic, assign) SkeletonType type;        // default is solid
@property (nonatomic, assign) CGFloat multilineHeight;  // default is 20
@property (nonatomic, assign) CGFloat multilineSpacing; // default is 10

+ (instancetype) sharedInstance;

@end
```

举例
```
参考UIKitViewController类中的代码
{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 360, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor redColor];
        [contentView addSubview:imageView];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 360, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor redColor];
        imageView.layer.cornerRadius = CGRectGetWidth(imageView.bounds)/2.0f;
        imageView.layer.masksToBounds = YES;
        [contentView addSubview:imageView];

        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(190, 360, CGRectGetWidth(self.view.bounds)-200, 80)];
        label1.isSkeletonable = YES;
        label1.skeletonNumLines = 4;
        [contentView addSubview:label1];
    }
    [self.view showSkeleton];

```

##版本

###V0.0.1
初始版本

