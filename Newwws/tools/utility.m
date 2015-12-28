//
//  utility.m
//  firstAP
//
//  Created by hustqmk on 15/8/18.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import "utility.h"

@implementation utility

-(NSInteger) checkUseName:(NSString *) userName
{
    BOOL hasIllegalChar = 0, isLetter = 0, isDigit = 0;
    BOOL isUseNameCheckOK = false;
    if([userName length] >= 6)
    {
        for (int i = 0; i < [userName length]; i++)
        {
            unichar c = [userName characterAtIndex:i];
            
            isLetter = [[NSCharacterSet letterCharacterSet] characterIsMember:c];
            isDigit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            
            if(!isLetter && !isDigit)
            {
                hasIllegalChar = true;
            }
        }
        
        if(!hasIllegalChar)
        {
            isUseNameCheckOK = true;
        }
        else
        {
            return ERROR_USERNAME_ILLEGAL_CHARACTER;
        }
        
    }
    else
    {
        return ERROR_USERNAME_ILLEGAL_LENGTH;
    }
    if (isUseNameCheckOK) {
        return true;
    }
    
    return false;
}

-(NSInteger) checkPasswd:(NSString *) password
{
    BOOL lowerCaseLetter = 0,upperCaseLetter = 0,digit = 0;
    BOOL isPasswdCheckOK = false;
    if([password length] >= 8)
    {
        for (int i = 0; i < [password length]; i++)
        {
            unichar c = [password characterAtIndex:i];
            if(!lowerCaseLetter)
            {
                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!upperCaseLetter)
            {
                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
        }
        
        if(digit && lowerCaseLetter && upperCaseLetter)
        {
            isPasswdCheckOK = true;
        }
        else
        {
            return ERROR_PASSWORD_ILLEGAL_CHARACTER;
        }
        
    }
    else
    {
        return ERROR_PASSWORD_ILLEGAL_LENGTH;
    }
    
    if (isPasswdCheckOK) {
        return true;
    }
    return false;
}
@end
