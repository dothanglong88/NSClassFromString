#import "ViewController.h"
#import "ViewController.m"

#pragma mark - Animals
@interface Cat : NSObject
@end

@implementation Cat
- (void) say {
    NSLog(@"Meo meo");
}
@end

@interface Dog : NSObject
@end
@implementation Dog
- (void) say {
    NSLog(@"Gau Gau");
}
@end

@interface Mouse : NSObject
@end
@implementation Mouse
- (void) say {
    NSLog(@"Chit chit");
}
@end

#pragma mark - Animals image
@interface cat : NSObject
@end

@implementation cat
- (void) CallImage {
}
@end

@interface dog : NSObject
@end
@implementation dog
- (void) CallImage {
}
@end

@interface mouse : NSObject
@end
@implementation mouse
- (void) CallImage {
}
@end

@interface horse : NSObject
@end
@implementation horse
- (void) CallImage {
}
@end

@interface tiger : NSObject
@end
@implementation tiger
- (void) CallImage {
}
@end

#pragma mark - Protocols
@protocol Fly <NSObject>
-(void) fly;
@end

@protocol Swim <NSObject>
-(void) swim;
@end

@interface Turtle : NSObject <Swim>
@end
@implementation Turtle
-(void) swim {
    NSLog(@"I can swim");
}
@end

#pragma mark - Main Logic
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameAnimal;
//@property (weak, nonatomic) IBOutlet UIImageView *animalPhoto;

@end


#pragma mark - Main Logic
@implementation ViewController
- (IBAction)submitAnimal:(id)sender {
    NSString* name = [[_nameAnimal text]lowercaseString];
//    name = [name lowercaseString];
    
    //class
    Class class = NSClassFromString(name);
    if (class == nil) {
        NSLog(@"class is null");
        _animalPhoto.image =[UIImage imageNamed:@"error"];
        return;
    }
    id object = [class new];
    SEL imageMethod = @selector(CallImage);
    if ([object respondsToSelector:imageMethod]) {
        _animalPhoto.image =[UIImage imageNamed:name];
    }
    
//    //selector
//    SEL method = NSSelectorFromString(name);
//    
//    if ([self respondsToSelector:method]) {
//        #pragma clang diagnostic push
//        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        [self performSelector:method];
//        #pragma clang diagnostic pop
//    } else {
//        _animalPhoto.image =[UIImage imageNamed:@"error"];
//    }
}


- (IBAction)createObjectFromDynamicClass:(id)sender {
    NSArray* animals = @[@"Cat", @"Dog", @"Mouse", @"Elephant", @"Tiger"];
    int index = arc4random_uniform((u_int32_t)animals.count);
    
    Class class = NSClassFromString(animals[index]);
    if (class == nil) {
        NSLog(@"Non exist class - %@", animals[index]);
        return;
    }
    id object = [class new];
    SEL sayMethod = @selector(say);
    if ([object respondsToSelector:sayMethod]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [object performSelector:sayMethod];
        #pragma clang diagnostic pop
    }
    
}

- (IBAction)callMethodFromString:(id)sender {
    NSArray* methods = @[@"sayHello", @"sayName", @"rob bank"];
    int index = arc4random_uniform((u_int32_t)methods.count);
    
    SEL method = NSSelectorFromString(methods[index]);
    
    if ([self respondsToSelector:method]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:method];
        #pragma clang diagnostic pop
    } else {
        NSLog(@"%@ is not method",methods[index]);
    }

}

- (IBAction)createProtocolFromString:(id)sender {
    NSArray* protocols = @[@"Fly", @"Swim"];
    Turtle* turtle = [Turtle new];
    for (NSString* protocolName in protocols) {
        Protocol* protocol = NSProtocolFromString(protocolName);
        if ([turtle conformsToProtocol:protocol]) {
            NSLog(@"Turtle adopts %@ protocol", protocolName);
        }
    }
}

#pragma mark - Some dummy methods
- (void) cat {
    _animalPhoto.image =[UIImage imageNamed:@"cat"];
}

- (void) dog {
    _animalPhoto.image =[UIImage imageNamed:@"dog"];
}

- (void) mouse{
    _animalPhoto.image =[UIImage imageNamed:@"mouse"];
}

- (void) horse{
    _animalPhoto.image =[UIImage imageNamed:@"horse"];
}

- (void) tiger{
    _animalPhoto.image =[UIImage imageNamed:@"tiger"];
}

-(void) sayHello {
    NSLog(@"Hello");
    
}

-(void) sayName{
    NSLog(@"I am Cuong");
}
@end
