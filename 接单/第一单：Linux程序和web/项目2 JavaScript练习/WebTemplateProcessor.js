'use strict';

/**
 * 模板处理器构造函数
 * @param {string} template - 包含{{property}}形式占位符的模板字符串
 */
function WebTemplateProcessor(template) {
    this.template = template;
}

/**
 * 填充模板方法
 * @param {Object} dictionary - 包含要替换的键值对的对象
 * @returns {string} - 返回填充后的字符串
 */
WebTemplateProcessor.prototype.fillIn = function(dictionary) {
    return this.template.replace(/{{([^}]*)}}/g, (match, key) => {
        // 使用hasOwnProperty确保属性真实存在于dictionary中
        // 如果属性不存在，返回空字符串
        return dictionary.hasOwnProperty(key.trim()) ? dictionary[key.trim()] : '';
    });
};

// 确保在Node.js和浏览器环境都可用
if (typeof module !== 'undefined' && module.exports) {
    module.exports = WebTemplateProcessor;
} 