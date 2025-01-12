(function() {
    'use strict';
    
    // 将之前的全局变量移到闭包内
    var p1Message = 'SUCCESS';
    var p2Message = 'SUCCESS';
    var p3Message = 'SUCCESS';
    var varDeclared = ['varDeclared', 'p1Message', 'p2Message', 'p3Message'];

    // 测试代码保持不变,但移到闭包内
    // ********************* Test webfilter

    if (typeof webMakeMultiFilter !== 'function') {
        console.error('webMakeMultiFilter is not a function', typeof webMakeMultiFilter);
        p1Message = 'FAILURE';
    } else {

        var arraysAreTheSame = function arraysAreTheSame(a1, a2) {
            if (!Array.isArray(a1) || !Array.isArray(a2) || (a1.length !== a2.length)) {
                return false;
            }
            for (var i = 0; i < a1.length; i++) {
                if (a1[i] !== a2[i]) {
                    return false;
                }
            }
            return true;
        };

        var originalArray = [1, 2, 3];
        var filterFunc = webMakeMultiFilter(originalArray);

        var secondArray = [1, 2, 3, 4];
        var filterFuncTwo = webMakeMultiFilter(secondArray);

        if (typeof filterFunc !== 'function') {
            console.error('webMakeMultiFilter does not return a function', filterFunc);
            p1Message = 'FAILURE';
        } else {
            var result = filterFunc();
            if (!arraysAreTheSame([1, 2, 3], result)) {
                console.error('filter function with no args does not return the original array', result);
                p1Message = 'FAILURE';
            }

            var callbackPerformed = false;
            result = filterFunc(function(item) {
                return item !== 2;
            }, function(callbackResult) {
                callbackPerformed = true;
                if (!arraysAreTheSame([1, 3], callbackResult)) {
                    console.error('filter function callback does not filter 2 correctly', callbackResult);
                    p1Message = 'FAILURE';
                }
                if (!arraysAreTheSame([1, 2, 3], this)) {
                    console.error('filter function callback does not pass original array as this', this);
                    p1Message = 'FAILURE';
                }
            });

            if (!callbackPerformed) {
                console.error('filter function callback not performed');
                p1Message = 'FAILURE';
            }

            if (result !== filterFunc) {
                console.error('filter function does not return itself', result);
                p1Message = 'FAILURE';
            }

            result = filterFunc(function(item) {
                return item !== 3;
            });
            if (result !== filterFunc) {
                console.error('filter function does not return itself 2', result);
                p1Message = 'FAILURE';
            }

            result = filterFunc();
            if (!arraysAreTheSame([1], result)) {
                console.error('filter function callback does not filter 3 correctly', result);
                p1Message = 'FAILURE';
            }
            result = filterFuncTwo(function(item) {
                return item !== 1;
            }, function(callbackResult) {
                if (!arraysAreTheSame([2, 3, 4], callbackResult)) {
                    console.error('second filter does not filter 1 (check for global variable usage)', callbackResult);
                    p1Message = 'FAILURE';
                }
                if (!arraysAreTheSame([1, 2, 3, 4], this)) {
                    console.error('filter function callback does not pass original array as this', this);
                    p1Message = 'FAILURE';
                }
            });

        }


    }
    console.log('Test webMakeMultiFilter:', p1Message);

    // ********************* Test webTemplateProcessor

    if (typeof WebTemplateProcessor !== 'function') {
        console.error('WebTemplateProcessor is not a function', WebTemplateProcessor);
        p2Message = 'FAILURE';
    } else {

        var template = 'My favorite month is {{month}} but not the day {{day}} or the year {{year}}';
        var dateTemplate = new WebTemplateProcessor(template);

        var dictionary = { month: 'July', day: '1', year: '2019' };
        var str = dateTemplate.fillIn(dictionary);

        if (str !== 'My favorite month is July but not the day 1 or the year 2019') {
            console.error('WebTemplateProcessor didn\'t work');
            p2Message = 'FAILURE';
        }
        varDeclared.push('template');
        varDeclared.push('dateTemplate');
        varDeclared.push('dictionary');
        varDeclared.push('str');
    }
    console.log('Test WebTemplateProcessor:', p2Message);

    // ********************* Test to see if the symbols we defined are in the global address space

    varDeclared.forEach(function(sym) {

        if (window[sym] !== undefined) {
            console.error('Found my symbol', sym, 'in DOM');
            p3Message = 'FAILURE';
        }
    });
    console.log('Test Problem 3:', p3Message);

    // 最后将结果存储到一个全局对象中
    window.webProject2Results = {
        p1Message: p1Message,
        p2Message: p2Message,
        p3Message: p3Message
    };

    // 更新DOM的代码移到闭包内
    window.onload = function() {
        document.getElementById("webp1").innerHTML = p1Message;
        document.getElementById("webp2").innerHTML = p2Message;
        document.getElementById("webp3").innerHTML = p3Message;
    };
})();