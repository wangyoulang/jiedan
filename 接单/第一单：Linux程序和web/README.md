# Web 开发与网络编程项目集

本仓库包含三个独立的项目，分别展示了 Web 前端开发。

## 项目1：HTML & CSS 样式切换

### 功能描述
- 创建一个可以通过不同 CSS 样式表展示不同外观的 HTML 页面
- 实现两种不同的视觉样式（Version A 和 Version B）

### 使用方法
1. 进入 `项目1 HTML&CSS` 目录
2. 打开 `index.html` 文件
3. 修改 HTML 文件中的样式表链接来切换样式：
```html
<!-- 使用样式 A -->
<link rel="stylesheet" href="styleA.css">

<!-- 或使用样式 B -->
<link rel="stylesheet" href="styleB.css">
```

### 答辩要点
1. 解释 CSS 选择器的使用
2. 说明如何实现不同的布局效果
3. 展示响应式设计的实现方法

## 项目2：JavaScript 功能实现

### 功能描述
实现三个主要功能：

1. 多重过滤器函数 (Problem 1)
   - 创建一个可重用的数组过滤器
   - 支持链式调用
   - 维护原数组不变性
   - 支持回调函数

2. 模板处理器 (Problem 2)
   - 实现模板字符串替换功能
   - 使用构造函数模式
   - 处理未定义属性的情况

3. 全局命名空间污染处理 (Problem 3)
   - 使用IIFE模式封装代码
   - 避免全局变量泄露
   - 保持测试功能完整

### 使用方法

1. 安装依赖：
```bash
cd project2
npm install
```

2. 运行测试：
```bash
npm test
# 或在浏览器中打开 web-test-project2.html
```

3. 检查代码质量：
```bash
npm run jshint
```

### 代码示例

1. 多重过滤器使用示例：
```javascript
// 创建过滤器
var arrayFilterer = webMakeMultiFilter([1, 2, 3]);

// 使用过滤器
arrayFilterer(function(elem) {
    return elem !== 2;  // 过滤掉2
}, function(currentArray) {
    console.log(currentArray);  // 输出 [1, 3]
    console.log(this);         // 输出原数组 [1, 2, 3]
});

// 链式调用
arrayFilterer(function(elem) {
    return elem !== 3;  // 继续过滤掉3
});

// 获取当前结果
var result = arrayFilterer();  // 返回 [1]
```

2. 模板处理器使用示例：
```javascript
// 创建模板
var template = 'My favorite month is {{month}} but not the day {{day}}';
var processor = new WebTemplateProcessor(template);

// 填充数据
var dictionary = {month: 'July', day: '1'};
var result = processor.fillIn(dictionary);
// 结果: "My favorite month is July but not the day 1"

// 处理未定义属性
var partialData = {day: '1'};
var result2 = processor.fillIn(partialData);
// 结果: "My favorite month is  but not the day 1"
```

### 技术要点

1. 闭包的使用
   - 保持对原始数组的引用
   - 维护内部状态
   - 实现数据私有性

2. 原型继承
   - 使用构造函数创建模板处理器
   - 通过原型添加方法
   - 实现面向对象的设计

3. 模块化
   - 使用IIFE避免全局污染
   - 只暴露必要的接口
   - 维护代码的可维护性

4. 正则表达式
   - 用于模板字符串的解析
   - 处理模板变量的替换
   - 保证模板处理的准确性

## 项目3：单页面应用程序 - 待办事项管理

### 功能描述
- 待办事项的添加、编辑、删除功能
- 任务分类管理
- 任务计时功能
- 数据本地存储
- 搜索和排序功能

### 使用方法
1. 进入 `项目3 单页面应用程序` 目录
2. 在浏览器中打开 `index.html`

### 主要功能
1. 任务管理：
   - 添加新任务
   - 编辑已有任务
   - 删除任务
   - 标记任务完成状态

2. 任务计时：
   - 为任务设置时长
   - 开始/暂停/重置计时
   - 计时完成提醒

3. 组织功能：
   - 按类别分类（工作、生活、学习等）
   - 搜索任务
   - 多种排序方式（日期、名称等）

### 使用示例
```javascript
// 添加新任务
1. 在输入框中输入任务内容
2. 选择任务类别
3. 点击"添加"按钮

// 使用计时功能
1. 点击任务的计时按钮
2. 使用开始/暂停/重置控制计时

// 搜索和过滤
1. 使用搜索框查找特定任务
2. 使用过滤器按类别或状态筛选
```

### 答辩要点
1. 解释单页面应用的实现原理
2. 说明本地存储的使用方法
3. 展示计时功能的实现
4. 解释事件处理机制
5. 说明数据状态管理方式
