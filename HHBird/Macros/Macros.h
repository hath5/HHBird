//
//  Macros.h
//  HHBird
//
//  Created by Trần Hoàng Hà on 11/9/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#ifndef HHBird_Macros_h
#define HHBird_Macros_h

//DLog
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#endif
