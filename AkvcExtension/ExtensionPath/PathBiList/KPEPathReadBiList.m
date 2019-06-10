//
//  KPEPathReadBiList.m
//  KeyPathExtensionSample
//
//  Created by NOVO on 2018/10/22.
//  Copyright © 2018 NOVO. All rights reserved.
//  https://github.com/qddnovo/KeyPathExtension
//

#import "KPEPathReadBiList.h"
#import "KPEPathReadNode.h"

@interface KPEPathReadBiList()

@end

@implementation KPEPathReadBiList


+ (KPEPathReadBiList *)defaultList
{
    static KPEPathReadBiList *_defaultList;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultList = [[KPEPathReadBiList alloc] init];
    });
    //Create semaphore
    static dispatch_semaphore_t signalSemaphore;
    static dispatch_once_t onceTokenSemaphore;
    dispatch_once(&onceTokenSemaphore, ^{
        signalSemaphore = dispatch_semaphore_create(1);
    });
    //Wait semaphore
    dispatch_semaphore_wait(signalSemaphore, DISPATCH_TIME_FOREVER);
    //
    [_defaultList initWithDefaultList];
    //Signal semaphore
    dispatch_semaphore_signal(signalSemaphore);
    
    return _defaultList;
}

#define ANode KPEPathReadNode

- (void)initWithDefaultList
{
    ///Error
    ANode* error = [[ANode alloc] init].thatError;
    
    /////////////////
    ///SEL-BEGGING///
    ANode* sel = [ANode nodeMatchValue:@"S"];
    _rootNode = sel;
    
    ANode* sel0 = [ANode nodeMatchValue:@"E"].asTrueNodeFor(sel);
    ANode* sel1 = [ANode nodeMatchValue:@"L"].asTrueNodeFor(sel0);
    ANode* sel2 = [ANode nodeMatchValue:@"("].asTrueNodeFor(sel1);
    ANode* selContent = [ANode nodeMatchSelector].asTrueNodeFor(sel2)
    .thatBanCharacters(@")")
    .thatTrueNodeSelf;
    ANode* sel3 = [ANode nodeMatchValue:@")"].asFalseNodeFor(selContent).thatFalseNode(error);
    ANode* sel4 = [ANode nodeMatchValue:@"?"].asTrueNodeFor(sel3).thatFalseNode(error)
    .thatFinishable.thatResultType(KPEPathComponentSELInspector);
    [ANode nodeMatchValue:@"."].asTrueNodeFor(sel4).thatFalseNode(error)
    .thatFinished.thatResultType(KPEPathComponentSELInspector);//Node at end
    /// SEL-END ///
    ///////////////
    
    ///////////////////
    ///Class-BEGGING///
    ANode* class = [ANode nodeMatchValue:@"C"]
    .asFalseNodeFor(sel).asFalseNodeFor(sel0).asFalseNodeFor(sel1).asFalseNodeFor(sel2);
    ANode* class0 = [ANode nodeMatchValue:@"l"].asTrueNodeFor(class);
    ANode* class1 = [ANode nodeMatchValue:@"a"].asTrueNodeFor(class0);
    ANode* class2 = [ANode nodeMatchValue:@"s"].asTrueNodeFor(class1);
    ANode* class3 = [ANode nodeMatchValue:@"s"].asTrueNodeFor(class2);
    ANode* class4 = [ANode nodeMatchValue:@"("].asTrueNodeFor(class3);
    ANode* classContent = [ANode nodeMatchBaseName].asTrueNodeFor(class4).thatBanCharacters(@")").thatTrueNodeSelf;
    ANode* class5 = [ANode nodeMatchValue:@")"].asFalseNodeFor(classContent).thatFalseNode(error);
    ANode* class6 = [ANode nodeMatchValue:@"?"].asTrueNodeFor(class5).thatFalseNode(error)
    .thatFinishable.thatResultType(KPEPathComponentClassInspector);
    [ANode nodeMatchValue:@"."].asTrueNodeFor(class6).thatFalseNode(error)
    .thatFinished.thatResultType(KPEPathComponentClassInspector);//Node at end
    ///Class-END///
    ///////////////
    
    //////////////////////
    ///FullPath-BEGGING///
    ANode* fullPath = [ANode nodeMatchBaseName].thatBanCharacters(@"@<{")
    .asFalseNodeFor(class).asFalseNodeFor(class0).asFalseNodeFor(class1)
    .asFalseNodeFor(class2).asFalseNodeFor(class3).asFalseNodeFor(class4);
    {
        ANode* fullPathContent = [ANode nodeMatchBaseName].asTrueNodeFor(fullPath).thatTrueNodeSelf
        .thatBanCharacters(@".-!?}")
        .thatFinishable.thatResultType(KPEPathComponentNSKey);
        ///Key path : keyPath.
        ANode* keyPathEnd = [ANode nodeMatchValue:@"."].asFalseNodeFor(fullPathContent)
        .thatFinished.thatResultType(KPEPathComponentNSKey);
        ///Struct path : (NSKey->)(StructPath->)(StructPath->)...NSKey
        ANode* structPath0 = [ANode nodeMatchValue:@"-"].thatFalseNode(error).asFalseNodeFor(keyPathEnd);
        [ANode nodeMatchValue:@">"].thatFalseNode(error).asTrueNodeFor(structPath0)
        .thatFinishedStructPath.thatResultType(KPEPathComponentStructKeyPath);
    }
    ///FullPath-END///
    //////////////////
    
    /////////
    /// @ ///
    ANode* at = [ANode nodeMatchValue:@"@"].asFalseNodeFor(fullPath);
    {
        ///Function
        ANode* function = [ANode nodeMatchBaseName].asTrueNodeFor(at)
        .thatBanCharacters(@"[:")
        .thatFinishable.thatResultType(KPEPathComponentIsFunction);
        ANode* functionContent = [ANode nodeMatchBaseName].thatTrueNodeSelf.asTrueNodeFor(function)
        .thatBanCharacters(@".")
        .thatFinishable.thatResultType(KPEPathComponentIsFunction);
        [ANode nodeMatchValue:@"."].asFalseNodeFor(functionContent)
        .thatFinished.thatResultType(KPEPathComponentIsFunction);//Node at end
        
        ///Indexer
        ANode* indexer0 = [ANode nodeMatchValue:@"["].asFalseNodeFor(function);
        ANode* indexerContent = [ANode nodeMatchIndexer].thatTrueNodeSelf.asTrueNodeFor(indexer0)
        .thatBanCharacters(@"]");
        ANode* indexer1 = [ANode nodeMatchValue:@"]"].asFalseNodeFor(indexerContent).thatFalseNode(error)
        .thatFinishable.thatResultType(KPEPathComponentIndexer);
        [ANode nodeMatchValue:@"."].asTrueNodeFor(indexer1)
        .thatFinished.thatResultType(KPEPathComponentIndexer);//Node at end
        
        ///Predicate
        ANode* predicate0 = [ANode nodeMatchValue:@":"].thatFalseNode(error).asFalseNodeFor(indexer0);
        ANode* predicateContent = [ANode nodeMatchAnyChar]
        .thatBanCharacters(@"!?")
        .asTrueNodeFor(predicate0).thatTrueNodeSelf;
        
        ANode* predicateFilter = [ANode nodeMatchValue:@"!"].asFalseNodeFor(predicateContent)
        .thatFinishable.thatResultType(KPEPathComponentPredicateFilter);
        [ANode nodeMatchValue:@"."].asTrueNodeFor(predicateFilter)
        .thatFalseNode(predicateContent)
        .thatFinished.thatResultType(KPEPathComponentPredicateFilter);//Node at end
        
        ANode* predicateEvaluate = [ANode nodeMatchValue:@"?"].asFalseNodeFor(predicateFilter)
        .thatFinishable.thatResultType(KPEPathComponentPredicateEvaluate);;
        [ANode nodeMatchValue:@"."].asTrueNodeFor(predicateEvaluate)
        .thatFalseNode(predicateContent)
        .thatFinished.thatResultType(KPEPathComponentPredicateEvaluate);//Node at end
    }
    /// @ //
    ////////
    
    /////////
    /// < ///
    ANode* matchKey = [ANode nodeMatchValue:@"<"].asFalseNodeFor(at);
    {
        
        ANode* regkey = [ANode nodeMatchValue:@"$"].asTrueNodeFor(matchKey);
        ANode* regkeyContent = [ANode nodeMatchAnyChar].asTrueNodeFor(regkey)
        .thatBanCharacters(@"$").thatTrueNodeSelf;
        ANode* regkey2 = [ANode nodeMatchValue:@"$"].asFalseNodeFor(regkeyContent);
        ANode* regkey3 = [ANode nodeMatchValue:@">"].asTrueNodeFor(regkey2).thatFalseNode(regkeyContent)
        .thatFinishable.thatResultType(KPEPathComponentRegkey);
        [ANode nodeMatchValue:@"."].asTrueNodeFor(regkey3).thatFalseNode(regkeyContent)
        .thatFinished.thatResultType(KPEPathComponentRegkey);//Node at end
        
        
        ANode* subKeyContent = [ANode nodeMatchBaseName].thatBanCharacters(@">")
        .asFalseNodeFor(regkey).thatTrueNodeSelf;
        ANode* subKeyEndable = [ANode nodeMatchValue:@">"].asFalseNodeFor(subKeyContent).thatFalseNode(error)
        .thatFinishable.thatResultType(KPEPathComponentSubkey);
        [ANode nodeMatchValue:@"."].asTrueNodeFor(subKeyEndable).thatFalseNode(error)
        .thatFinished.thatResultType(KPEPathComponentSubkey);//Node at end
    }
    /// < ///
    /////////
    
    
    /////////
    /// { ///
    ANode* keys = [ANode nodeMatchValue:@"{"].asFalseNodeFor(matchKey).thatFalseNode(error);
    {
        ANode* keysContent = [ANode nodeMatchAnyChar].asTrueNodeFor(keys)
        .thatBanCharacters(@"}").thatTrueNodeSelf;
        
        ANode* keys2 = [ANode nodeMatchValue:@"}"].asFalseNodeFor(keysContent)
        .thatFinishable.thatResultType(KPEPathComponentKeysAccessor);
        
        [ANode nodeMatchValue:@"."].asTrueNodeFor(keys2).thatFalseNode(keysContent)
        .thatFinished.thatResultType(KPEPathComponentKeysAccessor);
    }
    /// { ///
    /////////
}
@end
