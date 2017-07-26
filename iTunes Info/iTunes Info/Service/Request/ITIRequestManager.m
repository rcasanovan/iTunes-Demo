//
//  ITIRequestManager.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIRequestManager.h"

//__ End Points
#import "ITIRequestManagerEndPoints.h"

typedef void(^requestDictionaryCompletionBlock)(NSURL *urlResponse, NSDictionary *json);
typedef void(^requestDictionaryCompletionFailureBlock)(NSURL *urlResponse, NSError *error);

@interface ITIRequestManager ()

@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation ITIRequestManager

/**
 Shared class object. It works in order to create a single instance (singleton) for class
 
 @since 1.0.0
 */
+ (instancetype)shared {
    static ITIRequestManager *requestManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [ITIRequestManager new];
        requestManager.baseUrl = [NSURL URLWithString:kBaseUrl];
    });
    return requestManager;
}

#pragma mark - Helpers

/**
 Create api url (in this case the parameters must be included into the body)
 
 @param endpoint endpoint for the api call
 
 @since 1.0.0
 */
- (NSString *)createApiUrlFromEndpoint:(NSString *)endpoint {
    NSString *urlString = [self.baseUrl absoluteString];
    urlString = [NSString stringWithFormat:@"%@/%@", urlString, endpoint];
    return urlString;
}

/**
 Create api url with parameters into the same url
 
 @param endpoint    endpoint for the api call
 @param parameters  parameters for the api call
 
 @since 1.0.0
 */
- (NSString *)createApiUrlFromEndpoint:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    NSString *urlString = [self.baseUrl absoluteString];
    urlString = [NSString stringWithFormat:@"%@/%@?%@", urlString, endpoint, [self urlEncodedDictionary:parameters]];
    return urlString;
}

/**
 Encode dictionary
 
 @param dictionary dictionary to encode
 
 @since 1.0.0
 */
- (NSString *)urlEncodedDictionary:(NSDictionary*)dictionary{
    NSMutableString *bodyData = [[NSMutableString alloc]init];
    int i = 0;
    for (NSString *key in dictionary.allKeys) {
        i++;
        [bodyData appendFormat:@"%@=",key];
        NSString *value = [dictionary valueForKey:key];
        NSString *newString = [value stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [bodyData appendString:newString];
        if (i < dictionary.allKeys.count) {
            [bodyData appendString:@"&"];
        }
    }
    return [bodyData copy];
}

#pragma mark - General request operation

/**
 General request operation
 
 @param operation       request operation (GET, POST, ...)
 @param endpoint        endpoint to request operation
 @param parameters      parameters for request operation
 @param completionBlock completion block for success response
 @param failure         completion block for failure response
 
 @since 1.0.0
 */
- (void)requestOperation:(NSString *)operation
                endpoint:(NSString *)endpoint
              parameters:(NSDictionary *)parameters
            onCompletion:(requestDictionaryCompletionBlock)completionBlock
                 failure:(requestDictionaryCompletionFailureBlock)failure {
    //__ Create the final url for request operation
    NSString *urlString = [self createApiUrlFromEndpoint:endpoint parameters:parameters];
    NSURL *url = [NSURL URLWithString: urlString];
    
    //__ Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    request.HTTPMethod = operation;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //__ Execute the request operation
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //__ Dictionary server answer
        NSDictionary *dictionary = nil;
        
        //__ data exists? -> transform the data into dictionary
        if ([data length] >= 1) {
            dictionary = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
        }

        //__ no error? -> return the dictionary
        if (!error) {
            completionBlock(response.URL, dictionary);
        }
        //__ else -> return failure and error
        else {
            failure(response.URL, error);
        }
    }] resume];
}

#pragma mark - API calls

/**
 Request for search in iTunes
 
 @param term            seach term separated by "+" (michael+jackson, liam+gallagher)
 @param completionBlock a completion block for API call response
 
 @since 1.0.0
 */
- (void)requestManagerSearchWithTerm:(NSString *)term
                        oncompletion:(ITINetworkGeneralDictionaryCompletionBlock)completionBlock {
    NSDictionary *parameters = @{kSearchTerm : term};
    [self requestOperation:kGETOperation endpoint:kSearchEndPoint parameters:parameters onCompletion:^(NSURL *urlResponse, NSDictionary *json) {
        completionBlock(urlResponse, json, YES, nil);
    } failure:^(NSURL *urlResponse, NSError *error) {
        completionBlock(urlResponse, nil, NO, error);
    }];
}

@end
