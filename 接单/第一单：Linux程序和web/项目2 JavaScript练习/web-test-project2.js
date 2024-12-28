'use strict';

(function() {
    // Problem 1 测试代码
    console.log('Problem 1 测试结果:');
    var arrayFilterer1 = webMakeMultiFilter([1, 2, 3]);
    arrayFilterer1(function(elem) {
        return elem !== 2; // check if element is not equal to 2
    }, function(currentArray) {
        console.log(this); 
        //printing 'this' within the callback function should print originalArray which is [1, 2, 3]
        console.log(currentArray); // prints [1, 3]
    });
    
    arrayFilterer1(function(elem) {
        return elem !== 3; // check if element is not equal to 3
    });
    
    var currentArray = arrayFilterer1();
    console.log('currentArray', currentArray);

    // 额外的测试用例
    function filterTwos(elem) { return elem !== 2; }
    function filterThrees(elem) { return elem !== 3; }
    
    var arrayFilterer2 = webMakeMultiFilter([1, 2, 3]);
    console.log(typeof arrayFilterer2);
    var currentArray2 = arrayFilterer2(filterTwos)(filterThrees)();
    console.log('currentArray2', currentArray2);
    
    var arrayFilterer3 = webMakeMultiFilter([1, 2, 3]);
    var arrayFilterer4 = webMakeMultiFilter([4, 5, 6]);
    console.log(arrayFilterer3(filterTwos)());
    console.log(arrayFilterer4(filterThrees)());

    // Problem 2 测试代码
    console.log('\nProblem 2 测试结果:');
    var template = 'My favorite month is {{month}} but not the day {{day}} or the year {{year}}';
    var dateTemplate = new WebTemplateProcessor(template);
    
    var dictionary = {month: 'July', day: '1', year: '2019'};
    var str = dateTemplate.fillIn(dictionary);
    console.log('Test 1 - 所有属性都存在:');
    console.log('模板结果:', str);
    console.log('期望结果: My favorite month is July but not the day 1 or the year 2019');
    console.assert(str === 'My favorite month is July but not the day 1 or the year 2019');
    
    // Case: property doesn't exist in dictionary
    var dictionary2 = {day: '1', year: '2019'};
    str = dateTemplate.fillIn(dictionary2);
    console.log('\nTest 2 - 缺少month属性:');
    console.log('模板结果:', str);
    console.log('期望结果: My favorite month is  but not the day 1 or the year 2019');
    console.assert(str === 'My favorite month is  but not the day 1 or the year 2019');
})(); 