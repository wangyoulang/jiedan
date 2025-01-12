# 项目1：HTML & CSS

## 问题1：
创建一个单一的HTML文档，通过不同的CSS样式表呈现两种不同的外观。HTML文件应命名为index.html，文档标题应为"(Web Project #1)"。两个样式表应分别命名为styleA.css和styleB.css。

1. 如果HTML文件链接到styleA.css，则应呈现如下效果（"版本A"）：
[图片A]

2. 如果HTML文件链接到styleB.css，则应呈现如下效果（"版本B"）：
注意：截图中的D被高亮显示是为了展示文本应占据的空间。你的解决方案不应该给D添加蓝色背景。
[图片B]

### 样式A规格：
- 应有六个盒子元素，垂直排列
- 所有盒子水平居中，垂直方向上等间距分布。当浏览器窗口调整大小时，盒子之间的间距应随之改变（它们应在页面上垂直方向保持等距）。但是，盒子本身不应重叠或改变大小
- 每个盒子尺寸为100x100像素，顶部有1像素线条（颜色：#687291）。文本水平居中
- 盒子颜色交替变化（颜色：#dfe1e7, #eeeff2）
- 最后一个元素（颜色：#687291）有4像素黑色边框，文本垂直居中
- 所有元素使用Tahoma字体，40像素大小

### 样式B规格：
- 五个盒子元素，在左上角水平排列
- 窗口大小调整时盒子不换行（即使浏览器窗口太小无法显示所有盒子，A到E的盒子也应保持在同一行）
- 最后一个盒子固定在窗口右下角，即使窗口调整大小也保持位置
- 每个盒子尺寸为100x150像素（颜色：#eeeff2），左侧有10像素点线（颜色：#D0D0FF）。盒子之间间隔10像素
- 鼠标悬停在盒子上时，光标变为手型，盒子和字体颜色改变（颜色分别为：黄色和金色）
- 所有元素使用Tahoma字体，40像素大小
- 字母与盒子边缘之间有10像素的间距

### 提示
- 以下CSS样式属性可能对此项目有用：
  ```css
  display: inline-block;
  height: 100%;
  white-space: nowrap;
  ```
- 你需要使用CSS Flexbox布局
- 你的HTML文件必须是有效的XHTML 1.0文档，能通过http://validator.w3.org的验证。此外，你的HTML和CSS必须整洁、可读、适当缩进且结构良好。

### 提交内容
提交问题1所需的所有文件，包括index.html、styleA.css和styleB.css。

# 项目2：JavaScript练习

虽然这个项目在浏览器中运行代码，但你需要在系统上安装Node.js来运行代码质量检查器。如果你还没有安装Node.js和npm包管理器，请现在按照安装说明进行操作。

### 安装Node.js
安装最新的"长期支持版（LTS）"Node.js（当前版本14.16.1）。可以从URL https://nodejs.org/en/download 下载。

要验证是否已安装Node.js和其包管理器（npm），请尝试运行以下命令：
```bash
node -v
npm -v
```
这些命令应该运行并打印出你的node和npm程序的版本号。

安装Node.js后，创建一个project2目录并将此zip文件的内容解压到该目录中。zip文件包含web-test-project2.html和web-test-project2.js文件，这些文件作为你在此项目中编写的代码的测试框架。.jshintrc是JSHint的一种配置方式，这种方式允许每个项目有不同的配置文件，只需要将文件放在项目根目录中即可。

你可以通过在project2目录中运行以下命令来获取代码质量工具JSHint：
```bash
npm install
```
这将把JSHint下载到node_modules子目录中。

你可以通过运行以下命令来对project2目录中的所有JavaScript文件运行它：
```bash
npm run jshint
```

要运行作业，请在浏览器中打开web-test-project2.html文件。网页将加载JavaScript并运行一些测试。由于Node.js也包含JavaScript虚拟机，你也可以使用以下命令在不使用浏览器的情况下运行测试：
```bash
npm test
```

浏览器中的JavaScript开发环境更好，所以我们建议你使用它进行开发。

注意：这些测试并不涵盖所有边缘情况。它们的存在是为了帮助指导你，并让你知道何时具备了基本功能。处理测试文件中未明确测试的所有规范中声明的内容是你的责任。

在这个项目中，我们要求你编写或修改一些JavaScript函数。此作业中的问题具有实用性，你开发的功能将在以后的课程项目中派上用场。考虑到JavaScript库可以解决或帮助解决几乎任何JavaScript任务，你可能只需要几行代码就能调用某个库例程来解决这些问题。由于项目的目标是学习JavaScript，我们禁止你在解决方案中使用任何JavaScript库。JavaScript Arrays和Date对象的内置函数是可以接受的。

## 问题1：生成多重过滤器函数

在你的project2目录中，创建一个名为web-make-multi-filter.js的新文件。你的多重过滤器函数的代码将放在这个文件中。

声明一个名为webMakeMultiFilter的全局函数，该函数接受一个数组（originalArray）作为参数，并返回一个可用于过滤该数组元素的函数。返回的函数（arrayFilterer）内部维护一个称为currentArray的概念。最初，currentArray被设置为与originalArray相同。arrayFilterer函数接受两个函数作为参数。它们是：

1. filterCriteria - 一个接受数组元素作为参数并返回布尔值的函数。此函数在currentArray的每个元素上调用，currentArray根据filterCriteria函数的结果更新。如果filterCriteria函数对某个元素返回false，该元素应从currentArray中移除。否则，它保留在currentArray中。如果filterCriteria不是函数，返回的函数（arrayFilterer）应立即返回currentArray的值，不执行任何过滤。

2. callback - 过滤完成时将调用的函数。callback接受currentArray的值作为参数。在callback函数内访问this应引用originalArray的值。如果callback不是函数，应忽略它。callback没有返回值。

除非未指定filterCriteria参数，否则arrayFilterer函数应返回自身，在这种情况下它应返回currentArray。必须能够同时运行多个arrayFilterer函数。

### 检查函数
以下代码展示了如何使用你在此问题中定义的函数：

```javascript
var arrayFiltererl = webMakeMultiFilter([1, 2, 3]);
arrayFiltererl(function(elem) {
    return elem !== 2; // check if element is not equal to 2 
}, function(currentArray) {
    console.log(this); 
//printing 'this' within the callback function should print originalArray which is [1, 2, 3] 
console.log(currentArray); // prints [l, 3] 
});
arrayFiltererl(function(elem) {
    return elem !== 3;   // check if element is not equal to 3
});
var currentArray = arrayFiltererl();
console.log('currentArray', currentArray)
```

## 问题2：模板处理器

在你的project2目录中，创建一个名为web-template-processor.js的新文件。你的模板处理器的代码将放在这个文件中。

创建一个模板处理器类（WebTemplateProcessor），它使用字符串参数template构造，并有一个fillIn方法。当使用字典对象作为参数调用时，fillIn返回一个字符串，其中模板中的值已用字典对象中的值填充。WebTemplateProcessor应使用标准JavaScript构造函数和原型结构编写。

fillIn方法返回模板字符串，其中形如{{property}}的任何文本都被替换为传递给函数的字典对象中相应的属性。

如果模板指定了字典对象中未定义的属性，该属性应替换为空字符串。如果属性在两个词之间，你会注意到用空字符串替换属性会导致两个连续的空格。例如："This {{undefinedProperty}} is cool" -> "This is cool"。这没关系。你不必担心删除多余的空格。

你的系统只需处理格式正确的属性。在以下情况下，其行为可以保持未定义，因为我们不会明确检查它们：
- 嵌套属性 - {{foo {{bar}}}} 或 {{{{bar}}}} 或 {{{bar}}}
- 不平衡的括号 - {{bar}}}
- 任何属性字符串中的游离括号 - da{y 或 da}y

以下代码展示了如何使用你在此问题中定义的函数：

```javascript
var template = 'My favorite month is {{month}} but not the day {{day}} or the year {{year}}'; var dateTemplate = new WebTemplateProcessor(template); 

var dictionary= {month: 'July', day: '1', year: '2019'}; 

var str = dateTemplate.fillln(dictionary); 

assert(str === 'My favorite month is July but not the day 1 or the year 2019'); 

//Case: property doesn't exist in dictionary 

var dictionary2 = {day: '1', year: '2019'};

var str = dateTemplate.fillIn(dictionary2);

assert(str === 'My favorite month is  but not the day 1 or the year 2019'); 
```

## 问题3：修复web-test-project2.js以避免污染全局命名空间

我们提供给你的测试JavaScript文件（web-test-project2.js）在全局JavaScript命名空间中声明了许多符号。例如，加载脚本后，符号p1Message出现在全局命名空间中。另一个JavaScript文件随后可以访问和更改p1Message。修改web-test-project2.js，使用标准JavaScript模块模式，使用匿名函数来隐藏全局命名空间中的符号，同时保持相同的检查功能。

### 提交内容
提交project2目录。该目录应包括我们提供给你的启动文件以及你为问题创建或修改的代码文件，包括web-make-multi-filter.js、web-template-processor.js、web-test-project2.js和web-test-project2.html。确保你的提交运行时没有错误。

# 项目3：单页面应用程序

### 提交内容
根据你自己的喜好，构建一个单页面应用程序（可以稍微简单些）。 