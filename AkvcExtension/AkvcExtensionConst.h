#ifndef __AkvcExtensionConst__H__
#define __AkvcExtensionConst__H__

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE || TARGET_OS_TV

#import <UIKit/UIKit.h>
#define AKVC_VIEW UIView
#define AKVC_RESPONDER UIResponder

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>
#define AKVC_VIEW NSView
#define AKVC_RESPONDER NSResponder

#endif

//Log
#ifdef DEBUG
#define AkvcLog(...) NSLog(__VA_ARGS__)
#else
#define AkvcLog(...)
#endif

//Deprecated
#define AkvcDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 *  Types
 */
FOUNDATION_EXPORT NSString *const AkvcTypeInt;
FOUNDATION_EXPORT NSString *const AkvcTypeShort;
FOUNDATION_EXPORT NSString *const AkvcTypeFloat;
FOUNDATION_EXPORT NSString *const AkvcTypeDouble;
FOUNDATION_EXPORT NSString *const AkvcTypeLong;
FOUNDATION_EXPORT NSString *const AkvcTypeLongLong;
FOUNDATION_EXPORT NSString *const AkvcTypeChar;
FOUNDATION_EXPORT NSString *const AkvcTypeBOOL1;
FOUNDATION_EXPORT NSString *const AkvcTypeBOOL2;
FOUNDATION_EXPORT NSString *const AkvcTypePointer;

FOUNDATION_EXPORT NSString *const AkvcTypeIvar;
FOUNDATION_EXPORT NSString *const AkvcTypeMethod;
FOUNDATION_EXPORT NSString *const AkvcTypeBlock;
FOUNDATION_EXPORT NSString *const AkvcTypeClass;
FOUNDATION_EXPORT NSString *const AkvcTypeSEL;
FOUNDATION_EXPORT NSString *const AkvcTypeId;

FOUNDATION_EXPORT NSString *const AkvcPropertyReadonly;
FOUNDATION_EXPORT NSString *const AkvcPropertyVoid;

NS_INLINE id Akvc_boxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect actual = (CGRect)va_arg(v, CGRect);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(NSRange)) == 0) {
        NSRange actual = (NSRange)va_arg(v, NSRange);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#endif




