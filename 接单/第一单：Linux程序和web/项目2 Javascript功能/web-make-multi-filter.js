"use strict";

function webMakeMultiFilter(originalArray) {
    let currentArray = originalArray.slice(); // 创建原数组的副本
    
    function arrayFilterer(filterCriteria, callback) {
        // 如果没有提供filterCriteria,返回currentArray
        if (!filterCriteria) {
            return currentArray;
        }
        
        // 如果filterCriteria不是函数,直接返回currentArray
        if (typeof filterCriteria !== 'function') {
            return currentArray;
        }
        
        // 应用过滤条件
        currentArray = currentArray.filter(filterCriteria);
        
        // 如果提供了回调函数则执行
        if (typeof callback === 'function') {
            callback.call(originalArray, currentArray);
        }
        
        // 返回arrayFilterer函数本身以支持链式调用
        return arrayFilterer;
    }
    
    return arrayFilterer;
} 