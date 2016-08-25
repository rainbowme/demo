//
//  ReactiveCocoa.h
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 3/5/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for ReactiveCocoa.
FOUNDATION_EXPORT double ReactiveCocoaVersionNumber;

//! Project version string for ReactiveCocoa.
FOUNDATION_EXPORT const unsigned char ReactiveCocoaVersionString[];

#import "EXTKeyPathCoding.h"
#import "EXTScope.h"
#import "NSArray+RACSequenceAdditions.h"
#import "NSData+RACSupport.h"
#import "NSDictionary+RACSequenceAdditions.h"
#import "NSEnumerator+RACSequenceAdditions.h"
#import "NSFileHandle+RACSupport.h"
#import "NSNotificationCenter+RACSupport.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACLifting.h"
#import "NSObject+RACPropertySubscribing.h"
#import "NSObject+RACSelectorSignal.h"
#import "NSOrderedSet+RACSequenceAdditions.h"
#import "NSSet+RACSequenceAdditions.h"
#import "NSString+RACSequenceAdditions.h"
#import "NSString+RACSupport.h"
#import "NSIndexSet+RACSequenceAdditions.h"
#import "NSUserDefaults+RACSupport.h"
#import "RACBehaviorSubject.h"
#import "RACChannel.h"
#import "RACCommand.h"
#import "RACCompoundDisposable.h"
#import "RACDelegateProxy.h"
#import "RACDisposable.h"
#import "RACEvent.h"
#import "RACGroupedSignal.h"
#import "RACKVOChannel.h"
#import "RACMulticastConnection.h"
#import "RACQueueScheduler.h"
#import "RACQueueScheduler+Subclass.h"
#import "RACReplaySubject.h"
#import "RACScheduler.h"
#import "RACScheduler+Subclass.h"
#import "RACScopedDisposable.h"
#import "RACSequence.h"
#import "RACSerialDisposable.h"
#import "RACSignal+Operations.h"
#import "RACSignal.h"
#import "RACStream.h"
#import "RACSubject.h"
#import "RACSubscriber.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACTargetQueueScheduler.h"
#import "RACTestScheduler.h"
#import "RACTuple.h"
#import "RACUnit.h"

//#if TARGET_OS_WATCH
//#elif TARGET_OS_IOS || TARGET_OS_TV
//	#import <ReactiveCocoa/UIBarButtonItem+RACCommandSupport.h>
//	#import <ReactiveCocoa/UIButton+RACCommandSupport.h>
//	#import <ReactiveCocoa/UICollectionReusableView+RACSignalSupport.h>
//	#import <ReactiveCocoa/UIControl+RACSignalSupport.h>
//	#import <ReactiveCocoa/UIGestureRecognizer+RACSignalSupport.h>
//	#import <ReactiveCocoa/UISegmentedControl+RACSignalSupport.h>
//	#import <ReactiveCocoa/UITableViewCell+RACSignalSupport.h>
//	#import <ReactiveCocoa/UITableViewHeaderFooterView+RACSignalSupport.h>
//	#import <ReactiveCocoa/UITextField+RACSignalSupport.h>
//	#import <ReactiveCocoa/UITextView+RACSignalSupport.h>
//
//	#if TARGET_OS_IOS
//		#import <ReactiveCocoa/NSURLConnection+RACSupport.h>
//		#import <ReactiveCocoa/UIStepper+RACSignalSupport.h>
//		#import <ReactiveCocoa/UIDatePicker+RACSignalSupport.h>
//		#import <ReactiveCocoa/UIAlertView+RACSignalSupport.h>
//		#import <ReactiveCocoa/UIActionSheet+RACSignalSupport.h>
//		#import <ReactiveCocoa/MKAnnotationView+RACSignalSupport.h>
//		#import <ReactiveCocoa/UIImagePickerController+RACSignalSupport.h>
//		#import <ReactiveCocoa/UIRefreshControl+RACCommandSupport.h>
//		#import <ReactiveCocoa/UISlider+RACSignalSupport.h>
//		#import <ReactiveCocoa/UISwitch+RACSignalSupport.h>
//	#endif
//#elif TARGET_OS_MAC
//	#import <ReactiveCocoa/NSControl+RACCommandSupport.h>
//	#import <ReactiveCocoa/NSControl+RACTextSignalSupport.h>
//	#import <ReactiveCocoa/NSObject+RACAppKitBindings.h>
//	#import <ReactiveCocoa/NSText+RACSignalSupport.h>
//	#import <ReactiveCocoa/NSURLConnection+RACSupport.h>
//#endif
