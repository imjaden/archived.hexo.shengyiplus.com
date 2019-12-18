---
title: Javascript 编程规范
type: Javascript 编程规范
---

## 命名规范

- 标准变量采用驼峰式命名
- ID 在变量名中全大写
- 常量全大写，用下划线连接构造函数，大写第一个字母
- JQuery 对象必须以 $ 开头命名

```
let thisIsMyName;
let goodID;
let reportURL;
let AndroidVersion;
let iOSVersion;
let MAX_COUNT = 10;

function Person(name) {
    this.name = name;
}
// 不推荐
let body = $('body');
// 推荐
let $body = $('body');
```

## 函数命名

> 小驼峰命名法，可使用常见动词约定：

- `{ctl}{Event}`, 控件的操作事件，示例: `radioChange`, `btnSaveClick`
- canXXX 判断是否可执行某个动作，函数返回布尔值。true：可执行；false：不可执行
- hasXXX 判断是否含有某个值， 函数返回布尔值。true：含有此值；false：不含有此值
- isXXX 判断是否为某个值，函数返回布尔值。true：为某个值；false：不为某个值
- getXXX 获取某个值，函数返回非布尔值
- setXXX 设置某个值
    - 无返回值
    - 返回是否设置成功
    - 返回链式对象 load 加载某些数据
    - 返回是否加载完成的结果

```
// 是否有权限
function hasPermission() {
 return true;
}
// 获取权限列表
function getPermissinList() {
 return this.permissinList;
}
```

## 引用 References

1. 对所有的引用使用 const；不要使用 var。

  > eslint: prefer-const, no-const-assign

  这可以确保你无法对引用重新分配，重新分配可能会导致 bug 和难以理解的代码。

  ```
  // 批评
  var a = 1;
  var b = 2;
  // 推荐
  const a = 1;
  const b = 2;
  ```

2. 如果一定需要可变动的引用，使用 let 代替 var 。

  > eslint: no-var jscs: disallowVar

  ```
  // 不推荐
  var count = 1;
  if (true) {
      count += 1;
  }
  // 推荐
  let count = 1;
  if (true) {
      count += 1;
  }
  ```

## 对象 Objects

1. 使用字面量语法创建对象。

  > eslint: no-new-object

  ```
  // 不推荐
  const item = new Object();
  // 推荐
  const item = {};
  ```

2. 创建带有动态属性名称的对象时使用计算的属性名称。

  它们允许你在一个地方定义一个对象的所有属性。

  ```
  function getKey(k) {
      return `a-key-named-k`;
  }
  // 不推荐
  const obj = {
      id: 5,
      name: 'San Francisco',
  };
  obj[getKey('enabled')] = true;

  // 推荐
  const obj = {
      id: 5,
      name: 'San Francisco',
      [getKey('enabled')]: true,
  };
  ```

3. 使用对象方法速记语法。

  > eslint: object-shorthand jscs: requireEnhancedObjectLiterals

  ```
  // 不推荐
  const atom = {
    value: 1,
    addValue: function (value) {
        return atom.value + value;
    }
  };

  // 推荐
  const atom = {
    value: 1,
    addValue(value) {
        return atom.value + value;
    }
  };
  ```

4. 使用对象属性速记语法。

  > eslint: object-shorthand jscs: requireEnhancedObjectLiterals

  ```
  const lukeSkywalker = 'Luke Skywalker';
  // 不推荐
  const obj = {
      lukeSkywalker: lukeSkywalker,
  };

  // 推荐
  const obj = {
      lukeSkywalker,
  };
  ```

5. 将速记属性分组写在对象声明的开始处

  更容易看出哪些属性在使用速记语法

  ```
  const anakinSkywalker = 'Anakin Skywalker';
  const lukeSkywalker = 'Luke Skywalker';
  // 不推荐
  const obj = {
      episodeOne: 1,
      twoJediWalkIntoACantina: 2,
      lukeSkywalker,
      episodeThree: 3,
      mayTheFourth: 4,
      anakinSkywalker,
  };
  // 推荐
  const obj = {
      lukeSkywalker,
      anakinSkywalker,
      episodeOne: 1,
      twoJediWalkIntoACantina: 2,
      episodeThree: 3,
      mayTheFourth: 4,
  };
  ```

6. 仅无效标识符的属性使用引号

  > eslint: quote-props jscs: disallowQuotedKeysInObjects

  比较容易阅读。它改进了语法高亮显示，并且更容易被许多JS引擎优化。

  ```
  // 不推荐
  const bad = {
      'foo': 3,
      'bar': 4,
      'data-blah': 5
  };

  // 推荐
  const good = {
      foo: 3,
      bar: 4,
      'data-blah': 5
  };
  ```

7. 用对象展开操作符浅复制对象，优先于Object.assign。

  使用对象剩余操作符来获得一个省略某些属性的新对象。

  ```
  // 批评
  const original = { a: 1, b: 2 };
  const copy = Object.assign(original, { c: 3 }); //  `original` 是可变的
  delete copy.a; // so does this

  // 不推荐
  const original = { a: 1, b: 2 };
  const copy = Object.assign({}, original, { c: 3 }); // copy => { a: 1, b: 2, c: 3 }

  // 推荐
  const original = { a: 1, b: 2 };
  const copy = { ...original, c: 3 }; // copy => { a: 1, b: 2, c: 3 }
  const { a, ...noA } = copy; // noA => { b: 2, c: 3 }
  ```

## 数组 Arrays

1. 使用字面量创建数组。

  > eslint: no-array-constructor

  ```
  // 不推荐
  const items = new Array();
  // 推荐
  const items = [];
  ```

2. 使用数组展开操作符`...`复制数组。

  ```
  // 不推荐
  const len = items.length;
  const itemsCopy = [];
  let i;
  for (i = 0; i < len; i += 1) {
      itemsCopy[i] = items[i];
  }

  // 推荐
  const itemsCopy = [...items];
  ```

3. 使用展开操作符`...`代替 Array.from，将类数组(array-like) 对象转换成数组。

  ```
  const foo = document.querySelectorAll('.foo');
  // 推荐
  const nodes = Array.from(foo);
  // 高效
  const nodes = [...foo];
  ```

4. 使用 Array.from 代替展开操作符`...`来映射迭代，它避免了创建媒介数组。

  ```
  // 不推荐
  const baz = [...foo].map(bar);
  // 推荐
  const baz = Array.from(foo, bar);
  ```

## 解构 Destructuring

1. 当访问和使用对象的多个属性时，请使用对象解构。

  > eslint: prefer-destructuring jscs: requireObjectDestructuring

  ```
  // 不推荐
  function getFullName(user) {
      const firstName = user.firstName;
      const lastName = user.lastName;
      return `firstName lastName`;
  }
  // 推荐
  function getFullName(user) {
      const { firstName, lastName } = user;
      return `firstName lastName`;
  }
  // 高效
  function getFullName({ firstName, lastName }) {
      return `firstName lastName`;
  }
  ```

2. 使用数组解构。

  > eslint: prefer-destructuring jscs: requireArrayDestructuring

  ```
  const arr = [1, 2, 3, 4];
  // 不推荐
  const first = arr[0];
  const second = arr[1];
  // 推荐
  const [first, second] = arr;
  const [first, second, ...other] = arr;
  ```

3. 使用对象解构来实现多个返回值，而不是数组解构。

  随着时间的推移添加新的属性或更改排序，而不会改变调用时的位置。

  ```
  // 不推荐
  function processInput(input) {
      return [left, right, top, bottom];
  }
  const [left, __, top] = processInput(input); // 需考虑返回数据的顺序
  
  // 推荐
  function processInput(input) {
      return { left, right, top, bottom };
  }
  const { left, top } = processInput(input); // 只选择需要的数据
  ```

## 字符串 Strings

1. 字符串使用单引号 ''。

  > eslint: quotes jscs: validateQuoteMarks

  ```
  // 不推荐
  const name = "Capt. Janeway";
  // 不推荐 - 模板字面量应该包含插值或换行符
  const name = `Capt. Janeway`;
  // 推荐
  const name = 'Capt. Janeway';
  ```

2. 构建字符串时，使用模板字符串。

  > eslint: prefer-template template-curly-spacing jscs: requireTemplateStrings

  ```
  // 不推荐
  function sayHi(name) {
      return 'How are you, ' + name + '?';
  }
  // 不推荐
  function sayHi(name) {
      return ['How are you, ', name, '?'].join();
  }
  // 不推荐
  function sayHi(name) {
      return `How are you, ${ name }?`;
  }
  // 推荐
  function sayHi(name) {
       return `How are you, ${name}?`;
  }
  ```

3. 永远不要在字符串上使用 eval() ，它会打开太多的漏洞。

  > eslint: no-eval

## 函数 Functions

1. 使用命名函数表达式而不是函数声明。

  > eslint: func-style jscs: disallowFunctionDeclarations

  函数声明很容易被提升（Hoisting）,这对可读性和可维护性来说都是不利的;

  ```
  // 不推荐
  function foo() {
    // ...
  }
  // 不推荐
  const foo = function () {
    // ...
  };
  // 推荐
  // 用明显区别于变量引用调用的词汇命名
  const short = function longUniqueMoreDescriptiveLexicalFoo() {
    // ...
  };
  ```

2. 用圆括号包裹立即调用函数表达式 (IIFE)。

  > eslint: wrap-iife jscs: requireParenthesesAroundIIFE

  一个立即调用函数表达式是一个单独的单元 – 将函数表达式包裹在括号中，后面再跟一个调用括号，这看上去很紧凑。

  ```
  // 立即调用函数表达式 (IIFE)
  (function () {
    console.log('Welcome to the Internet. Please follow me.');
  }());
  ```

3. 不要使用 arguments。可以选择 rest 语法 `...` 替代。

  使用 `...` 能明确要传入的参数。另外 rest（剩余）参数是一个真正的数组，而 arguments 是一个类数组（Array-like）。

  ```
  // 不推荐
  function concatenateAll() {
    const args = Array.prototype.slice.call(arguments);
    return args.join('');
  }
  // 推荐
  function concatenateAll(...args) {
    return args.join('');
  }
  ```

4. 使用默认参数语法，而不要使用一个变化的函数参数

  ```
  // 不推荐
  function handleThings(opts) {
    // 更加糟糕: 如果参数 opts 是 falsy(假值) 的话，它将被设置为一个对象，
    // 这可能是你想要的，但它可以引起一些小的错误。
    opts = opts || {};
    // ...
  }
  // 不推荐
  function handleThings(opts) {
    if (opts === void 0) {
        opts = {};
    }
    // ...
  }
  // 推荐
  function handleThings(opts = {}) {
    // ...
  }
  ```

5. 始终将默认参数放在最后。

  ```
  // 不推荐
  function handleThings(opts = {}, name) {
    // ...
  }
  // 推荐
  function handleThings(name, opts = {}) {
    // ...
  }
  ```

6. 隔开函数签名，括号两边用空格隔开。

  ```
  // 不推荐
  const f = function(){};
  const g = function (){};
  const h = function() {};
  // 推荐
  const x = function () {};
  const y = function a() {};
  ```

7. 不要改变参数(?)。

  > eslint: no-param-reassign

  *操作*作为参数传入的对象，可能会在调用原始对象时造成不必要的变量副作用。（对象是引用类型）

  ```
  // 不推荐
  function f1(obj) {
      obj.key = 1;
  }
  // 推荐
  function f2(obj) {
      const key = Object.prototype.hasOwnProperty.call(obj, 'key') ? obj.key : 1;
  }
  ```

## 箭头函数 Arrow Functions

1. 当必须使用匿名函数（如在传递一个内联回调时），请使用箭头函数表示法。

  > eslint: prefer-arrow-callback, arrow-spacing jscs: requireArrowFunctions

  它创建了一个在 this 上下文中执行的函数的版本，这通常是你想要的，而且这样的写法更为简洁。

  ```
  // 不推荐
  [1, 2, 3].map(function (x) {
      const y = x + 1;
      return x * y;
  });
  // 不推荐
  [1, 2, 3].map( _ => {

      return 0;
  });
  // 推荐
  [1, 2, 3].map((x) => {
      const y = x + 1;
      return x * y;
  });
  // 推荐
  [1, 2, 3].map(() => {
      return 0;
  });
  ```

2. 无副作用的单行语句

  如果函数体由一个返回无副作用(side effect)的expression(表达式)的单行语句组成，那么可以省略大括号并使用隐式返回。否则，保留大括号并使用 return 语句

  ```
  // 不推荐
  [1, 2, 3].map(number => {
      const nextNumber = number + 1;
      return `A string containing the ${nextNumber}.`;
  });
  // 推荐
  [1, 2, 3].map(number => `A string containing the ${number}.`);
  ```

3. 如果表达式跨多行，将其包裹在括号中，可以提高可读性。

  ```
  // 不推荐
  ['get', 'post', 'put'].map(httpMethod => Object.prototype.hasOwnProperty.call(
      httpMagicObjectWithAVeryLongName,
      httpMethod
    )
  );
  // 推荐
  ['get', 'post', 'put'].map(httpMethod => (
      Object.prototype.hasOwnProperty.call(
        httpMagicObjectWithAVeryLongName,
        httpMethod
      )
    )
  );
  ```

4. 如果函数只有一个参数并且不使用大括号，则可以省略参数括号。否则，为了清晰和一致性，总是给参数加上括号。

  ```
  // 不推荐
  [1, 2, 3].map((x) => x * x);
  // 推荐
  [1, 2, 3].map(x => x * x);
  // 推荐
  [1, 2, 3].map(number => (
    `A long string with the number. It’s so long that we don’t want it to take up space on the .map line!`
  ));
  // 不推荐
  [1, 2, 3].map(x => {
    const y = x + 1;
    return x * y;
  });
  // 推荐
  [1, 2, 3].map((x) => {
    const y = x + 1;
    return x * y;
  });
  ```

5. 避免使用比较运算符(< =, >=)时，混淆箭头函数语法(=>)。

  ```
  // 不推荐
  const itemHeight = item => item.height > 256 ? item.largeSize : item.smallSize;
  // 不推荐
  const itemHeight = (item) => item.height > 256 ? item.largeSize : item.smallSize;
  // 推荐
  const itemHeight = item => (item.height > 256 ? item.largeSize : item.smallSize);
  // 推荐
  const itemHeight = (item) => {
    const { height, largeSize, smallSize } = item;
    return height > 256 ? largeSize : smallSize;
  };
  ```

## 类 Classes & 构造函数 Constructors

1. 总是使用 class。避免直接操作 prototype 。

  ```
  // 不推荐
  function Queue(contents = []) {
      this.queue = [...contents];
  }
  Queue.prototype.pop = function () {
      const value = this.queue[0];
      this.queue.splice(0, 1);
      return value;
  };
  // 推荐
  class Queue {
      constructor(contents = []) {
          this.queue = [...contents];
      }
      pop() {
          const value = this.queue[0];
          this.queue.splice(0, 1);
          return value;
      }
  }
  ```

2. 使用 extends 继承。

  extends 是一个内置的原型继承方法并且不会破坏 instanceof。

  ```
  // 不推荐
  const inherits = require('inherits');
      function PeekableQueue(contents) {
      Queue.apply(this, contents);
  }

  inherits(PeekableQueue, Queue);
  PeekableQueue.prototype.peek = function () {
      return this.queue[0];
  };

  // 推荐
  class PeekableQueue extends Queue {
      peek() {
          return this.queue[0];
      }
  }
  ```

3. 如果没有指定，类有一个默认的构造函数。一个空的构造函数或者只是委托给父类则不是必须的(?)。

  > eslint: no-useless-constructor

  ```
  // 不推荐
  class Jedi {
      constructor() {}
          getName() {
          return this.name;
      }
  }
  // 不推荐
  class Rey extends Jedi {
      constructor(...args) {
          super(...args);
      }
  }
  // 推荐
  class Rey extends Jedi {
      constructor(...args) {
          super(...args);
          this.name = 'Rey';
      }
  }
  ```

4. 避免重复类成员(?)。

  > eslint: no-dupe-class-members

  ```
  // 不推荐
  class Foo {
    bar() { return 1; }
    bar() { return 2; }
  }
  // 推荐
  class Foo {
    bar() { return 1; }
  }
  // 推荐
  class Foo {
    bar() { return 2; }
  }
  ```

## 模块 Modules

1. 使用模块 (import/export) 而不是其他非标准模块系统。

  ```
  // 不推荐
  const JavascriptStyleGuide = require('./JavascriptStyleGuide');
  module.exports = JavascriptStyleGuide.es6;
  // 一般
  import JavascriptStyleGuide from './JavascriptStyleGuide';
  export default JavascriptStyleGuide.es6;
  // 推荐
  import { es6 } from './JavascriptStyleGuide';
  export default es6;
  ```

2. 不要使用通配符 import(导入)。

  这样能确保你只有一个默认 export(导出)。

  ```
  // 不推荐
  import * as JavascriptStyleGuide from './JavascriptStyleGuide';
  // 推荐
  import JavascriptStyleGuide from './JavascriptStyleGuide';
  ```

3. 不要从 import(导入) 中直接 export(导出)。

  虽然一行代码简洁明了，但有一个明确的 import(导入) 方法和一个明确的 export(导出) 方法，使事情能保持一致。

  ```
  // 不推荐
  export { es6 as default } from './JavascriptStyleGuide';

  // 推荐
  import { es6 } from './JavascriptStyleGuide';
  export default es6;
  ```

4. 一个地方只在一个路径中 import(导入) 。

  ```
  // 不推荐
  import foo from 'foo';
  import { named1, named2 } from 'foo';

  // 推荐
  import foo, { named1, named2 } from 'foo';
  ```

5. 不要 export(导出) 可变绑定。

  > eslint: import/no-mutable-exports

  一般应该避免可变性，特别是在导出可变绑定时。虽然一些特殊情况下，可能需要这种技术，但是一般而言，只应该导出常量引用。

  ```
  // 不推荐
  let foo = 3;
  export { foo };
  // 推荐
  const foo = 3;
  export { foo };
  ```

6. 在只有单个导出的模块中，默认 export(导出) 优于命名 export(导出)。

  > eslint: import/prefer-default-export

  为了鼓励更多的文件只有一个 export(导出)，这有利于模块的可读性和可维护性。

  ```
  // 不推荐
  export function foo() {}
  // 推荐
  export default function foo() {}
  ```

7. 将所有 import 导入放在非导入语句的上面。

  > eslint: import/first

  由于 import 被提升，保持他们在顶部，防止意外的行为。

  ```
  // 不推荐
  import foo from 'foo';
  foo.init();
  import bar from 'bar';

  // 推荐
  import foo from 'foo';
  import bar from 'bar';
  foo.init();
  ```

8. 多行导入应该像多行数组和对象字面量一样进行缩进。

  ```
  // 不推荐
  import {longNameA, longNameB, longNameC, longNameD, longNameE} from 'path';
  // 推荐
  import {
      longNameA,
      longNameB,
      longNameC,
      longNameD,
      longNameE,
  } from 'path';
  ```

## 变量 Variables

1. 总是使用 const 或 let 来声明变量。 

  var 声明变量会导致产生全局变量，避免污染全局命名空间。

  > eslint: no-undef prefer-const

  ```
  // 不推荐
  superPower = new SuperPower();
  // 推荐
  const superPower = new SuperPower();
  ```

2. 将所有的 const 和 let 分组 。

  ```
  // 不推荐
  let i, len, dragonball,
  items = getItems(),
  goSportsTeam = true;

  // 不推荐
  let i;
  const items = getItems();
  let dragonball;
  const goSportsTeam = true;
  let len;

  // 推荐
  const goSportsTeam = true;
  const items = getItems();
  let dragonball;
  let i;
  let length;
  ```

3. 变量不要链式赋值。

  > eslint: no-multi-assign

  ```
  // 不推荐
  (function example() {
    // JavaScript 将其解析为
    // let a = ( b = ( c = 1 ) );
    // let关键字只适用于变量a;
    // 变量b和c变成了全局变量。
    let a = b = c = 1;
  }());
  console.log(a); // 抛出 ReferenceError（引用错误）
  console.log(b); // 1
  console.log(c); // 1

  // 推荐
  (function example() {
    let a = 1;
    let b = a;
    let c = a;
    // 同样适用于 `const`
  }());
  console.log(a); // 抛出 ReferenceError（引用错误）
  console.log(b); // 抛出 ReferenceError（引用错误）
  console.log(c); // 抛出 ReferenceError（引用错误）
  ```

4. 避免使用一元递增和递减运算符(++, -–)。

  根据 eslint 文档，一元递增和递减语句会受到自动插入分号的影响，并可能导致应用程序中的值递增或递减，从而导致无提示错误。

  使用像 num += 1 而不是 num++ 或 num ++ 这样的语句来改变你的值也更具有表现力。

  不允许一元递增和递减语句也会阻止您无意中预先递增/递减值，这也会导致程序中的意外行为。

  ```
  // 不推荐
  const array = [1, 2, 3];
  let num = 1;
  num++;
  --num;
  let sum = 0;
  let truthyCount = 0;
  for (let i = 0; i < array.length; i++) { 
    let value = array[i]; 
    sum += value;
     if (value) {
        truthyCount++; 
      } 
   }

  // 推荐
  const array = [1, 2, 3]; 
  let num = 1; num += 1; num -= 1; 
  const sum = array.reduce((a, b) => a + b, 0);
  const truthyCount = array.filter(Boolean).length;
  ```

## 比较运算符 Comparison Operators 和 等号 Equality

1. 使用 === 和 !== 优先于 == 和 !=。

  > eslint: eqeqeq

2. 对于布尔值使用简写，但对于字符串和数字使用显式比较。

  ```
  // 不推荐
  if (isValid === true) {
    // ...
  }
  // 推荐
  if (isValid) {
    // ...
  }

  // 不推荐
  if (name) {
    // ...
  }
  // 推荐
  if (name !== '') {
    // ...
  }

  // 不推荐
  if (collection.length) {
    // ...
  }
  // 推荐
  if (collection.length > 0) {
    // ...
  }
  ```

3. 在 case 和 default 子句中，使用大括号来创建包含词法声明的语句块(例如 let, const, function, 和 class).

  > eslint: no-case-declarations

  ```
  // 不推荐
  switch (foo) {
    case 1:
      let x = 1;
    break;
    case 2:
      const y = 2;
    break;
    case 3:
      function f() {
        // ...
      }
    break;
  default:
    class C {}
  }

  // 推荐
  switch (foo) {
    case 1: {
      let x = 1;
      break;
    }
    case 2: {
      const y = 2;
      break;
    }
    case 3: {
      function f() {
        // ...
      }
      break;
    }
    case 4:
      bar();
      break;
    default: {
      class C {}
    }
  }
  ```

4. 三元表达式不应该嵌套，通常写成单行表达式。

  > eslint: no-nested-ternary

  ```
  // 不推荐
  const foo = maybe1 > maybe2
  ? "bar"
  : value1 > value2 ? "baz" : null;

  // 推荐
  const maybeNull = value1 > value2 ? 'baz' : null;
  const foo = maybe1 > maybe2 ? 'bar' : maybeNull;
  ```

5. 避免不必要的三元表达式语句。

  > eslint: no-unneeded-ternary

  ```
  // 不推荐
  const foo = a ? a : b;
  const bar = c ? true : false;
  const baz = c ? false : true;

  // 推荐
  const foo = a || b;
  const bar = !!c;
  const baz = !c;
  ```

6. 当运算符混合在一个语句中时，请将其放在括号内。

  > eslint: no-mixed-operators

  混合算术运算符时，不要将 * 和 % 与 + ， -，，/ 混合在一起。

  提高可读性，并清晰展现开发者的意图。

  ```
  // 不推荐
  const foo = a && b < 0 || c > 0 || d + 1 === 0;
  // 不推荐
  const bar = a ** b - 5 % d;
  // 不推荐
  if (a || b && c) {
    return d;
  }
  // 推荐
  const foo = (a && b < 0) || c > 0 || (d + 1 === 0);
  // 推荐
  const bar = (a ** b) - (5 % d);
  // 推荐
  if ((a || b) && c) {
    return d;
  }
  // 推荐
  const bar = a + b / c * d;
  ```

## 代码块 Blocks

1. 使用大括号包裹所有的多行代码块

  > eslint: nonblock-statement-body-position

  ```
  // 不推荐
  if (test)
    return false;
  // 推荐
  if (test) return false;
  // 推荐
  if (test) {
    return false;
  }

  // 不推荐
  function foo() { return false; }
  // 推荐
  function bar() {
    return false;
  }
  ```

2. 如果通过 if 和 else 使用多行代码块，把 else 放在 if 代码块闭合括号的同一行。

  > eslint: brace-style

  ```
  // 不推荐
  if (test) {
    thing1();
    thing2();
  }
  else {
    thing3();
  }

  // 推荐
  if (test) {
    thing1();
    thing2();
  } else {
    thing3();
  }
  ```

3. 如果一个 if 块总是执行一个 return 语句，后面的 else 块是不必要的。在 else if 块中的 return，可以分成多个 if 块来 return 。

  > eslint: no-else-return

  ```
  // 不推荐
  function foo() {
    if (x) {
      return x;
    } else {
      return y;
    }
  }
  // 不推荐
  function cats() {
    if (x) {
      return x;
    } else if (y) {
      return y;
    }
  }
  // 不推荐
  function dogs() {
    if (x) {
      return x;
    } else {
      if (y) {
        return y;
      }
    }
  }

  // 推荐
  function foo() {
    if (x) {
      return x;
    }
    return y;
  }
  // 推荐
  function cats() {
    if (x) {
      return x;
    }
    if (y) {
      return y;
    }
  }
  // 推荐
  function dogs(x) {
    if (x) {
      if (z) {
        return y;
      }
    } else {
      return z;
    }
  }
  ```

## 控制语句 Control Statements

1. 如果控制语句(if, while 的)太长或超过最大行长度，那么每个（分组）条件可以放单独一行。逻辑运算符应该放在每行起始处。

  ```
  // 不推荐
  if ((foo === 123 || bar === 'abc') && doesItLookGoodWhenItBecomesThatLong() && isThisReallyHappening()) {
   thing1();
  }
  // 不推荐
  if (foo === 123 &&
    bar === 'abc') {
    thing1();
  }
  // 不推荐
  if (foo === 123
    && bar === 'abc') {
    thing1();
  }
  // 不推荐
  if (
    foo === 123 &&
    bar === 'abc'
  ) {
    thing1();
  }

  // 推荐
  if (
    foo === 123
    && bar === 'abc'
  ) {
    thing1();
  }
  // 推荐
  if (
    (foo === 123 || bar === "abc")
    && doesItLookGoodWhenItBecomesThatLong()
    && isThisReallyHappening()
  ) {
    thing1();
  }
  // 推荐
  if (foo === 123 && bar === 'abc') {
    thing1();
  }
  ```

## 注释 Comments

1. 多行注释使用 `/.../`。

  ```
  /**
  * @param {Grid} grid 需要合并的Grid
  * @param {Array} cols 需要合并列的Index(序号)数组；从0开始计数，序号也包含。
  * @param {Boolean} isAllSome 是否2个tr的cols必须完成一样才能进行合并。true：完成一样；false(默认)：不完全一样
  * @return void
  * @author XXX 2019/09/09
  */
  function mergeCells(grid, cols, isAllSome) {
      // Do Something
  }
  ```

2. 单行注释使用 `//`。将单行注释放在需注释的语句上方。在注释之前放置一个空行，除非它位于代码块的第一行。

  ```
  // 不推荐
  const active = true;  // is current tab
  // 推荐
  // is current tab
  const active = true;

  // 不推荐
  function getType() {
    console.log('fetching type...');
    // set the default type to 'no type'
    const type = this.type || 'no type';
    return type;
  }
  // 推荐
  function getType() {
    console.log('fetching type...');

    // set the default type to 'no type'
    const type = this.type || 'no type';
    return type;
  }
  // 推荐
  function getType() {
    // set the default type to 'no type'
    const type = this.type || 'no type';
    return type;
  }
  ```

3. 所有注释符和注释内容用一个空格隔开，让它更容易阅读。

  > eslint: spaced-comment

  ```
  // 不推荐
  //is current tab
  const active = true;
  // 推荐
  // is current tab
  const active = true;

  // 不推荐
  /**
  *make() returns a new element
  *based on the passed-in tag name
  */
  function make(tag) {
    // ...
    return element;
  }
  // 推荐
  /**
  * make() returns a new element
  * based on the passed-in tag name
  */
  function make(tag) {
    // ...
    return element;
  }
  ```

4. 给注释增加 FIXME 或 TODO 的前缀

  帮助其他开发者快速了解这个是否是一个需要重新复查的问题，或是你正在为需要解决的问题提出解决方案。这将有别于常规注释，因为它们是可操作的。

  使用 `FIXME – need to figure this out` 或者 `TODO – need to implement`。

  使用 `// FIXME: ` 来标识需要修正的问题。

  注：如果代码中有该标识，说明标识处代码需要修正，甚至代码是错误的，不能工作，需要修复，如何修正会在说明中简略说明。

  ```
  lass Calculator extends Abacus {
    constructor() {
      super();
      // FIXME: shouldn’t use a global here
      total = 0;
    }
  }
  ```

  使用 `// TODO:` 来标识需要实现的问题。

  注：如果代码中有该标识，说明在标识处有功能代码待编写，待实现的功能在说明中会简略说明。

  ```
  class Calculator extends Abacus {
    constructor() {
      super();
      // TODO: total should be configurable by an options param
      this.total = 0;
    }
  }
  ```

## 空格 Whitespace

1. 使用 2 个空格作为缩进

  ```
  // 推荐
  function baz() {
    let name;
  }
  ```

2. 在大括号前放置 1 个空格。

  > eslint: space-before-blocks jscs: requireSpaceBeforeBlockStatements

  ```
  // 不推荐
  function test(){
    console.log('test');
  }
  // 推荐
  function test() {
    console.log('test');
  }
  // 不推荐
  dog.set('attr',{
    age: '1 year',
    breed: 'Bernese Mountain Dog',
  });
  // 推荐
  dog.set('attr', {
    age: '1 year',
    breed: 'Bernese Mountain Dog',
  });
  ```

3. 在控制语句（if、while 等）的小括号前放一个空格。在函数调用及声明中，不在函数的参数列表前加空格。

  > eslint: keyword-spacing jscs: requireSpaceAfterKeywords

  ```
  // 不推荐
  if(isJedi) {
    fight ();
  }
  // 推荐
  if (isJedi) {
    fight();
  }

  // 不推荐
  function fight () {
    console.log ('Swooosh!');
  }
  // 推荐
  function fight() {
    console.log('Swooosh!');
  }
  ```

4. 使用空格把运算符隔开。

  > eslint: space-infix-ops jscs: requireSpaceBeforeBinaryOperators, requireSpaceAfterBinaryOperators

  ```
  // 不推荐
  const x=y+5;
  // 推荐
  const x = y + 5;
  ```

5. 在文件末尾插入一个空行。

  > eslint: eol-last

  ```
  // 不推荐
  import { es6 } from './JavascriptStyleGuide';
  // ...
  export default es6;

  // 推荐
  import { es6 } from './JavascriptStyleGuide';
  // ...
  export default es6;

  ```

6. 长方法链式调用时使用缩进（2个以上的方法链式调用）。使用一个点 . 开头，强调该行是一个方法调用，不是一个新的声明。

  > eslint: newline-per-chained-call no-whitespace-before-property

  ```
  // 不推荐
  $('#items').find('.selected').highlight().end().find('.open').updateCount();

  // 不推荐
  $('#items').
  find('.selected').
  highlight().
  end().
  find('.open').
  updateCount();

  // 推荐
  $('#items')
    .find('.selected')
    .highlight()
    .end()
    .find('.open')
    .updateCount();

  // 不推荐
  const leds = stage.selectAll('.led').data(data).enter().append('svg:svg').classed('led', true)
  .attr('width', (radius + margin) * 2).append('svg:g')
  .attr('transform', `translate(${radius + margin},${radius + margin})`)
  .call(tron.led);

  // 推荐
  const leds = stage.selectAll('.led')
    .data(data)
    .enter().append('svg:svg')
    .classed('led', true)
    .attr('width', (radius + margin) * 2)
    .append('svg:g')
    .attr('transform', `translate(${radius + margin},${radius + margin})`)
    .call(tron.led);
  // 推荐
  const leds = stage.selectAll('.led').data(data);
  ```

7. 不要在圆括号内加空格。

  ```
  // 不推荐
  function bar( foo ) {
    return foo;
  }
  // 推荐
  function bar(foo) {
    return foo;
  }
  // 不推荐
  if ( foo ) {
    console.log(foo);
  }
  // 推荐
  if (foo) {
    console.log(foo);
  }
  ```

8. 不要在中括号内添加空格。

  > eslint: array-bracket-spacing jscs: disallowSpacesInsideArrayBrackets

  ```
  // 不推荐
  const foo = [ 1, 2, 3 ];
  console.log(foo[ 0 ]);
  // 推荐
  const foo = [1, 2, 3];
  console.log(foo[0]);
  ```

9. 在大括号内添加空格

  ```
  // 不推荐
  const foo = {clark: 'kent'};
  // 推荐
  const foo = { clark: 'kent' };
  ```

## 类型转换 Type Casting & Coercion

1. 在声明语句的开始处就执行强制类型转换.

  字符串：

  > eslint: no-new-wrappers

  ```
  // => this.reviewScore = 9;
  // 不推荐
  const totalScore = new String(this.reviewScore); // typeof totalScore 是 "object" 而不是 "string"
  // 不推荐
  const totalScore = this.reviewScore + ''; // 调用 this.reviewScore.valueOf()
  // 不推荐
  const totalScore = this.reviewScore.toString(); // 不能保证返回一个字符串
  // 推荐
  const totalScore = String(this.reviewScore);
  ```

  数字：使用 Number 进行转换，而 parseInt 则始终以基数解析字串。

  > eslint: radix no-new-wrappers

  ```
  const inputValue = '4';
  // 不推荐
  const val = new Number(inputValue);
  // 不推荐
  const val = +inputValue;
  // 不推荐
  const val = inputValue >> 0;
  // 不推荐
  const val = parseInt(inputValue);
  // 推荐
  const val = Number(inputValue);
  // 推荐
  const val = parseInt(inputValue, 10);
  ```

  布尔值:

  > eslint: no-new-wrappers

  ```
  const age = 0;
  // 不推荐
  const hasAge = new Boolean(age);
  // 推荐
  const hasAge = Boolean(age);
  // 强烈推荐
  const hasAge = !!age;
  ```

## 命名规则 Naming Conventions

1. 避免使用单字母名称，命名应具有描述性。

  > eslint: id-length

  ```
  // 不推荐
  function q() {
    // ...
  }
  // 推荐
  function query() {
    // ...
  }
  ```
2. 当命名对象，函数和实例时使用驼峰式命名。

  > eslint: camelcase jscs: requireCamelCaseOrUpperCaseIdentifiers

  ```
  // 不推荐
  const OBJEcttsssss = {};
  const this_is_my_object = {};
  function c() {}
  // 推荐
  const thisIsMyObject = {};
  function thisIsMyFunction() {}
  ```

3. 当命名构造函数或类的时候使用 PascalCase 式命名，（注：即单词首字母大写）。

  > eslint: new-cap

  ```
  // 不推荐
  function user(options) {
    this.name = options.name;
  }
  const bad = new user({
    name: 'nope',
  });
  // 推荐
  class User {
    constructor(options) {
      this.name = options.name;
    }
  }
  const good = new User({
    name: 'yup',
  });
  ```

4. 当导出(export) 一个默认函数时使用驼峰式命名。你的文件名应该和你的函数的名字一致。

  ```
  function makeStyleGuide() {
    // ...
  }
  export default makeStyleGuide;
  ```

5. 当导出一个构造函数/类/单例/函数库/纯对象时使用 PascalCase 式命名。

  ```
  const JavascriptStyleGuide = {
    es6: {
    },
  };
  export default JavascriptStyleGuide;
  ```

## 存取器 Accessors

属性的存取器函数不是必须的。

1. 別使用 JavaScript 的 getters/setters，因为它们会导致意想不到的副作用，而且很难测试，维护和理解。相反，如果要使用存取器函数，使用 getVal() 及 setVal(‘hello’)。

  ```
  // 不推荐
  class Dragon {
    get age() {
      // ...
    }
    set age(value) {
      // ...
    }
  }
  // 推荐
  class Dragon {
    getAge() {
      // ...
    }
    setAge(value) {
      // ...
    }
  }
  ```

2. 如果属性/方法是一个 boolean, 使用 isVal() 或 hasVal() 方法。

  ```
  // 不推荐
  if (!dragon.age()) {
    return false;
  }
  // 推荐
  if (!dragon.hasAge()) {
    return false;
  }
  ```

## If-Else优化方案

[If-Else优化方案](/developer/style-guide/if-else-optimize-solutions.html)

## 整洁代码

[整洁代码的建议列表](/developer/style-guide/tips-to-keep-javascript-code-clean.html)

## 摘自文章

- [JavaScript 编程规范(一)](https://cloud.tencent.com/developer/article/1404290)
- [JavaScript 编程规范(二)](https://cloud.tencent.com/developer/article/1404381)
