//
//  CompareHeader.h
//  Compare
//
//  Created by huangshuimei on 2016/12/22.
//  Copyright © 2016年 huangshuimei. All rights reserved.
//

#ifndef CompareHeader_h
#define CompareHeader_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define SMLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define SMLog(...)
#endif

// 颜色
#define ColorRGB(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

// 颜色 16进制
#define UIHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NavigationBar_HEIGHT 44
#define StatusBar_HEIGHT 20
// 屏幕宽高
#define mainScreenWidth [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight [UIScreen mainScreen].bounds.size.height

#define BadgeNumberChange @"BadgeNumberChange"


// weakSelf
#define CW_WEAKSELF  __weak typeof(self) weakSelf = self


#endif /* CompareHeader_h */
