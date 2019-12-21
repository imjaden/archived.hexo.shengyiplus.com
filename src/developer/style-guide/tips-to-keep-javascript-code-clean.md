---
title: 整洁 Javascript 代码
type: 整洁 Javascript 代码
---

## 善用内置函数

### find/findIndex

*冗余场景：*

```
let array = [1, 2, 3, 4],
    item,
    index;

// scene1
for(let i = 0, len = array.length; i < len; i ++) {
  if(array[i] >= 1) {
    item = array[i];
  }
}
// scene2
for(let i = 0, len = array.length; i < len; i ++) {
  if(array[i] >= 3) {
    index = i;
  }
}
// priority use a `for` when scene1 and scene2 meet
```

*整洁方案：*

```
item = array.find(function(ele) { return ele >= 1; })
=> 1
index = array.findIndex(function(ele) { return ele >= 3; })
=> 2
```

### filter/some

*冗余场景：*

```
let array = [1, 2, 3, 4],
    filterArray = [],
    isBetween2And4 = false;

for(let i = 0, len = array.length; i < len; i ++) {
  if(array[i] >= 3) {
    filterArray.push(array[i])
  }
  if(array[i] > 2 && array[i] < 4) {
    isBetween2And4 = true
  }
}
```

*整洁方案：*

```
filterArray = array.filter(function(ele) { return ele >= 3; })
=> [3, 4]
isBetween2And4 = array.some(function(ele) { return ele > 2 && ele < 4; })
=> true
```

### map

*冗余场景：*

```
let array = [1, 2, 3, 4],
    newArray = [];

for(let i = 0, len = array.length; i < len; i ++) {
  newArray.push(array[i] * 2)
}
```

*整洁方案：*

```
newArray = array.map(function(ele) { return ele * 2; })
=> [2, 4, 6, 8]
```

### reduce/reduceRight

*冗余场景：*

```
let array = [1, 2, 3, 4],
    json = {};

for(let i = 0, len = array.length; i < len; i ++) {
  json[i] = array[i]
}
```

*整洁方案：*

```
json = array.reduce(function(json, ele, inx, arr) { json[inx] = ele; return json; }, {})
=> {0: 1, 1: 2, 2: 3, 3: 4}
array.reduceRight(function(json, ele, inx, arr) { console.log(ele); return json; }, {})
=> 4 3 2 1
```

## 可检索的名称

写可读性强、易于检索的的代码非常重要。

*冗余场景：*

```
for (let i = 0; i < 525600; i++) {
  runCronJob();
}
```

*整洁方案：*

```
// `let` 申明为大写的全局变量
let MINUTES_IN_A_YEAR = 525600;
for (let i = 0; i < MINUTES_IN_A_YEAR; i++) {
  runCronJob();
}
```

## 解析性的变量

*冗余场景：*

```
const cityStateRegex = /^(.+)[,\\s]+(.+?)\s*(\d{5})?$/;
saveCityState(cityStateRegex.match(cityStateRegex)[1], cityStateRegex.match(cityStateRegex)[2]);
```

*整洁方案：*

```
const cityStateRegex = /^(.+)[,\\s]+(.+?)\s*(\d{5})?$/,
      match = cityStateRegex.match(cityStateRegex),
      city = match[1],
      state = match[2];

saveCityState(city, state);
```

## 显式优于隐式

*晦涩场景：*

```
let locations = ['Austin', 'New York', 'San Francisco'];
locations.forEach((l) => {
  doStuff();
  doSomeOtherStuff();
  ...
  ...
  ...
  // 等等，`l` 又是什么？
  dispatch(l);
});
```

*整洁方案：*

```
let locations = ['Austin', 'New York', 'San Francisco'];
locations.forEach((location) => {
  doStuff();
  doSomeOtherStuff();
  ...
  ...
  ...
  dispatch(location);
});
```

## 短路语法更清晰

*冗余场景：*

```
function createMicrobrewery(name) {
  let breweryName;
  if (name) {
    breweryName = name;
  } else {
    breweryName = 'Hipster Brew Co.';
  }
}
```

*整洁方案：*

```
function createMicrobrewery(name) {
  let breweryName = name || 'Hipster Brew Co.'
}
```

## 函数参数不多于2

*冗余场景：*

```
function createMenu(title, body, buttonText, cancellable) {
  ...
}
```

*整洁方案：*

```
let menuConfig = {
  title: 'Foo',
  body: 'Bar',
  buttonText: 'Baz',
  cancellable: true
}
 
function createMenu(menuConfig) {
  ...
}
```

## 一个函数专注一件事

*冗余场景：*

```
function emailClients(clients) {
  clients.forEach(client => {
    let clientRecord = database.lookup(client);
    if (clientRecord.isActive()) {
      email(client);
    }
  });
}
```

*整洁方案：*

```
function emailClients(clients) {
  clients.forEach(client => {
    emailClientIfNeeded(client);
  });
}
 
function emailClientIfNeeded(client) {
  if (isClientActive(client)) {
    email(client);
  }
}
 
function isClientActive(client) {
  let clientRecord = database.lookup(client);
  return clientRecord.isActive();
}
```

## 函数名称见名知义

*晦涩场景：*

```
function dateAdd(date, month) {
  // ...
}

let date = new Date();
dateAdd(date, 1);
```

*整洁方案：*

```
function dateAddMonth(date, month) {
  // ...
}

let date = new Date();
dateAddMonth(date, 1);
```

## 函数只抽象一个层次

整洁理念: 拆分函数使其易于复用和易于测试

*冗余场景：*

```
function parseBetterJSAlternative(code) {
  let REGEXES = [...],
      statements = code.split(' '),
      tokens;
  REGEXES.forEach((REGEX) => {
    statements.forEach((statement) => {
      // ...
    })
  });

  let ast;
  tokens.forEach((token) => {
    // lex...
  });

  ast.forEach((node) => {
    // parse...
  })
}
```

*整洁方案：*

```
function tokenize(code) {
  let REGEXES = [...],
      statements = code.split(' '),
      tokens;
  REGEXES.forEach((REGEX) => {
    statements.forEach((statement) => {
      // ...
    })
  });

  return tokens;
}
 
function lexer(tokens) {
  let ast;
  tokens.forEach((token) => {
    // lex...
  });

  return ast;
}
 
function parseBetterJSAlternative(code) {
  let tokens = tokenize(code);
  let ast = lexer(tokens);
  ast.forEach((node) => {
    // parse...
  })
}
```

## 删除重复代码

JavaScript 是弱类型语句，所以很容易写通用性强的函数

*冗余场景：*

```
function showDeveloperList(developers) {
  developers.forEach(developers => {
    let expectedSalary = developer.calculateExpectedSalary();
    let experience = developer.getExperience();
    let githubLink = developer.getGithubLink();
    let data = {
      expectedSalary: expectedSalary,
      experience: experience,
      githubLink: githubLink
    };

    render(data);
  });
}

function showManagerList(managers) {
  managers.forEach(manager => {
    let expectedSalary = manager.calculateExpectedSalary();
    let experience = manager.getExperience();
    let portfolio = manager.getMBAProjects();
    let data = {
      expectedSalary: expectedSalary,
      experience: experience,
      portfolio: portfolio
    };

    render(data);
  });
}
```

*整洁方案：*

```
function showList(employees) {
  employees.forEach(employee => {
    let expectedSalary = employee.calculateExpectedSalary(),
        experience = employee.getExperience(),
        portfolio;

    if (employee.type === 'manager') {
      portfolio = employee.getMBAProjects();
    } else {
      portfolio = employee.getGithubLink();
    }

    let data = {
      expectedSalary: expectedSalary,
      experience: experience,
      portfolio: portfolio
    };

    render(data);
  });
}
```

## 默认参数&短路语法

*冗余场景：*

```
function writeForumComment(subject, body) {
  subject = subject || 'No Subject';
  body = body || 'No text';
}
```

*整洁方案：*

```
function writeForumComment(subject = 'No subject', body = 'No text') {
  ...
}
```

## `Object.assign` 用法

*冗余场景：*

```
let menuConfig = {
  title: null,
  body: 'Bar',
  buttonText: null,
  cancellable: true
}
 
function createMenu(config) {
  config.title = config.title || 'Foo'
  config.body = config.body || 'Bar'
  config.buttonText = config.buttonText || 'Baz'
  config.cancellable = config.cancellable === undefined ? config.cancellable : true;
}
 
createMenu(menuConfig);
```

*整洁方案：*

```
let menuConfig = {
  title: 'Order',
  buttonText: 'Send',
  cancellable: true
}
 
function createMenu(config) {
 config = Object.assign({
     title: 'Foo',
     body: 'Bar',
     buttonText: 'Baz',
     cancellable: true
   }, config);
}
 
createMenu(menuConfig);
```

## 不要写入全局函数

*冗余场景：*

```
Array.prototype.diff = function(comparisonArray) {
  let values = [];
  let hash = {};

  for (let i of comparisonArray) {
    hash[i] = true;
  }

  for (let i of this) {
    if (!hash[i]) {
      values.push(i);
    }
  }

  return values;
}
```

*整洁方案：*

```
class SuperArray extends Array {
  constructor(...args) {
    super(...args);
  }

  diff(comparisonArray) {
    let values = [];
    let hash = {};

    for (let i of comparisonArray) {
      hash[i] = true;
    }

    for (let i of this) {
      if (!hash[i]) {
        values.push(i);
      }
    }

    return values;
  }
}
```

## 函数式编程

*冗余场景：*

```
const programmerOutput = [
  {
    name: 'Uncle Bobby',
    linesOfCode: 500
  }, {
    name: 'Suzie Q',
    linesOfCode: 1500
  }, {
    name: 'Jimmy Gosling',
    linesOfCode: 150
  }, {
    name: 'Gracie Hopper',
    linesOfCode: 1000
  }
];
 
let totalOutput = 0;
for (let i = 0; i < programmerOutput.length; i++) {
  totalOutput += programmerOutput[i].linesOfCode;
}
```

*整洁方案：*

```
const programmerOutput = [
  {
    name: 'Uncle Bobby',
    linesOfCode: 500
  }, {
    name: 'Suzie Q',
    linesOfCode: 1500
  }, {
    name: 'Jimmy Gosling',
    linesOfCode: 150
  }, {
    name: 'Gracie Hopper',
    linesOfCode: 1000
  }
];
 
 
let totalOutput = programmerOutput
  .map((programmer) => programmer.linesOfCode)
  .reduce((acc, linesOfCode) => acc + linesOfCode, 0);
```

## 封装条件

*冗余场景：*

```
if (fsm.state === 'fetching' && isEmpty(listNode)) {
  // ...
}
```

*整洁方案：*

```
function shouldShowSpinner(fsm, listNode) {
  return fsm.state === 'fetching' && isEmpty(listNode);
}
 
if (shouldShowSpinner(fsmInstance, listNodeInstance)) {
  // ...
}
```

## 参考

- [浅谈JavaScript 代码整洁之道](https://www.jb51.net/article/149355.htm)
