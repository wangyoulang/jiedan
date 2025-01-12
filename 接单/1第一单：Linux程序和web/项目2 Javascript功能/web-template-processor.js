"use strict";

function WebTemplateProcessor(template) {
    this.template = template;
}

WebTemplateProcessor.prototype.fillIn = function(dictionary) {
    let result = this.template;
    
    // 使用正则表达式查找所有{{property}}模式
    return result.replace(/\{\{([^}]+)\}\}/g, function(match, property) {
        // 如果dictionary中存在该属性,则替换为对应值,否则替换为空字符串
        return dictionary[property] !== undefined ? dictionary[property] : '';
    });
}; 