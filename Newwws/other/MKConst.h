//
//  MKConst.h
//  Newwws
//
//  Created by hustqmk on 16/1/3.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#ifndef MKConst_h
#define MKConst_h

// TABLE IN DATABASE
#define NEWS_TABLE_NAME         @"newsPub"
#define DEFAULT_NEWS_NUMBER     10
#define NEWS_CONTENT            @"text"
#define USERNAME                @"userName"
#define NEWSID                   @"newsID"
#define IMAGES                  @"images"
#define THUMBIMAGES             @"thumbImages"
#define CREATEDAT               @"createdAt"
#define UPDATEDAT               @"updatedAt"

#define MKImageUrlPara @"?t=1&a=20e6e80eeb5a6a4c52465eadef5d2a4e"

// 获取RGB颜色
#define MKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#endif /* MKConst_h */
