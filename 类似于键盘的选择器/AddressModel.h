//
//  AddressModel.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface AddressSencodModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic,strong)NSMutableArray<Optional> *sub;

@end

@protocol AddressSencodModel <NSObject>
@end


@interface AddressModel : JSONModel


@property (nonatomic, copy) NSString<Optional> *name;

@property (nonatomic, strong)NSMutableArray<Optional,AddressSencodModel> *sub;


@end
