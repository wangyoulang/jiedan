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
1. 多重过滤器函数（Problem 1）
2. 模板处理器（Problem 2）
3. 全局命名空间污染处理（Problem 3）

### 使用方法
1. 进入 `项目2 JavaScript练习` 目录
2. 在浏览器中打开 `test.html` 查看测试结果
3. 在控制台中可以看到详细的测试输出

### 代码示例
```javascript
// 多重过滤器使用示例
var arrayFilterer1 = webMakeMultiFilter([1, 2, 3]);
arrayFilterer1(function(elem) {
    return elem !== 2;
}, function(currentArray) {
    console.log(currentArray); // 输出 [1, 3]
});

// 模板处理器使用示例
var template = 'My favorite month is {{month}} but not the day {{day}}';
var dateTemplate = new WebTemplateProcessor(template);
var dictionary = {month: 'July', day: '1'};
var str = dateTemplate.fillIn(dictionary);
```

### 答辩要点
1. 解释闭包的使用和作用
2. 说明如何实现链式调用
3. 展示模板处理器的正则表达式应用
4. 说明如何避免全局命名空间污染

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
