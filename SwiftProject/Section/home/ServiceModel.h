//
//  ServiceModel.h
//  yizhenjia
//
//  Created by 汪宁 on 16/9/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (nonatomic, copy)NSString *catId;
@property (nonatomic, copy)NSString *distance;
@property (nonatomic, copy)NSString *hasRedPaper;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *service_id;
@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *oriPrice;
@property (nonatomic, copy)NSString *price;

@property (nonatomic, copy)NSString *score;

@property (nonatomic, copy)NSString *shopId;

@property (nonatomic, copy)NSString *shopName;

// v2.0 new property
@property (nonatomic, copy)NSString *serviceType;  //月嫂服务  或者 普通服务
@property (nonatomic, copy)NSString *type;

@end
