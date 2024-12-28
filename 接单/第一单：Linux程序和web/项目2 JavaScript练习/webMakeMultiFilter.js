'use strict';

/**
 * 创建一个多重过滤器函数
 * @param {Array} originalArray - 原始数组
 * @returns {Function} arrayFilterer - 过滤器函数
 */
function webMakeMultiFilter(originalArray) {
    // 创建原始数组的副本，避免修改原始数组
    let currentArray = [...originalArray];
    
    /**
     * 数组过滤器函数
     * @param {Function} filterCriteria - 过滤条件函数
     * @param {Function} callback - 回调函数
     * @returns {Function|Array} - 返回过滤器函数自身或当前数组
     */
    function arrayFilterer(filterCriteria, callback) {
        // 如果没有提供过滤条件，返回当前数组
        if (!filterCriteria) {
            return currentArray;
        }
        
        // 如果过滤条件不是函数，返回当前数组
        if (typeof filterCriteria !== 'function') {
            return currentArray;
        }
        
        // 应用过滤条件到当前数组
        currentArray = currentArray.filter(filterCriteria);
        
        // 如果提供了回调函数，执行它
        // 将原始数组作为this上下文，当前数组作为参数
        if (typeof callback === 'function') {
            callback.call(originalArray, currentArray);
        }
        
        // 返回过滤器函数自身以支持链式调用
        return arrayFilterer;
    }
    
    return arrayFilterer;
}

// 确保在Node.js和浏览器环境都可用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = webMakeMultiFilter;
} 