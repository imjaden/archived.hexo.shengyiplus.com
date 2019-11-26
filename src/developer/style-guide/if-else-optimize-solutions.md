---
title: If-Else 优化方案
type: If-Else 优化方案
---

当代码已经复杂到难以维护的程度之后，只能狠下心重构优化。那，有什么方案可以优雅的优化掉这些多余的if/else?

## 1. 提前return

这是判断条件取反的做法，代码在逻辑表达上会更清晰，看下面代码：

```
if (condition) {
 // do something
} else {
  return xxx;
}
```

其实，每次看到上面这种代码，心里就抓痒，完全可以先判断`!condition`，干掉`else`。

```
if (!condition) {
  return xxx;
 
} 
// do something
```

## 2. 策略模式

有这么一种场景，根据不同的参数走不同的逻辑，其实这种场景很常见。最一般的实现：

```
if (strategy.equals("fast")) {
  // 快速执行
} else if (strategy.equals("normal")) {
  // 正常执行
} else if (strategy.equals("smooth")) {
  // 平滑执行
} else if (strategy.equals("slow")) {
  // 慢慢执行
}
```

看上面代码，有4种策略，有两种优化方案。

### 2.1 多态

```
interface Strategy {
  void run() throws Exception;
}

class FastStrategy implements Strategy {
    @Override
    void run() throws Exception {
        // 快速执行逻辑
    }
}

class NormalStrategy implements Strategy {
    @Override
    void run() throws Exception {
        // 正常执行逻辑
    }
}

class SmoothStrategy implements Strategy {
    @Override
    void run() throws Exception {
        // 平滑执行逻辑
    }
}

class SlowStrategy implements Strategy {
    @Override
    void run() throws Exception {
        // 慢速执行逻辑
    }
}
```

具体策略对象存放在一个Map中，优化后的实现

```
Strategy strategy = map.get(param);
strategy.run();
```

上面这种优化方案有一个弊端，为了能够快速拿到对应的策略实现，需要map对象来保存策略，当添加一个新策略的时候，还需要手动添加到map中，容易被忽略。

### 2.2 枚举

发现很多同学不知道在枚举中可以定义方法，这里定义一个表示状态的枚举，另外可以实现一个run方法。

```
public enum Status {
    NEW(0) {
      @Override
      void run() {
        //do something  
      }
    },
    RUNNABLE(1) {
      @Override
       void run() {
         //do something  
      }
    };

    public int statusCode;

    abstract void run();

    Status(int statusCode){
        this.statusCode = statusCode;
    }
}
```

重新定义策略枚举

```
public enum Strategy {
    FAST {
      @Override
      void run() {
        //do something  
      }
    },
    NORMAL {
      @Override
       void run() {
         //do something  
      }
    },

    SMOOTH {
      @Override
       void run() {
         //do something  
      }
    },

    SLOW {
      @Override
       void run() {
         //do something  
      }
    };
    abstract void run();
}

Strategy strategy = Strategy.valueOf(param);
strategy.run();
```

## 3. 学会使用 Optional

Optional主要用于非空判断，由于是jdk8新特性，所以使用的不是特别多，但是用起来真的爽。使用之前：

```
if (user == null) {
    //do action 1
} else {
    //do action2
}
```

如果登录用户为空，执行action1，否则执行action 2，使用Optional优化之后，让非空校验更加优雅，间接的减少if操作

```
Optional<User> userOptional = Optional.ofNullable(user);
userOptional.map(action1).orElse(action2);
```

## 4. 数组小技巧

来自google解释，这是一种编程模式，叫做表驱动法，本质是从表里查询信息来代替逻辑语句，比如有这么一个场景，通过月份来获取当月的天数，仅作为案例演示，数据并不严谨。一般的实现：

```
int getDays(int month){
    if (month == 1)  return 31;
    if (month == 2)  return 29;
    if (month == 3)  return 31;
    if (month == 4)  return 30;
    if (month == 5)  return 31;
    if (month == 6)  return 30;
    if (month == 7)  return 31;
    if (month == 8)  return 31;
    if (month == 9)  return 30;
    if (month == 10)  return 31;
    if (month == 11)  return 30;
    if (month == 12)  return 31;
}
优化后的代码

```
int monthDays[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int getDays(int month){
    return monthDays[--month];
}
```

结束if else作为每种编程语言都不可或缺的条件语句，在编程时会大量的用到。一般建议嵌套不要超过三层，如果一段代码存在过多的if else嵌套，代码的可读性就会急速下降，后期维护难度也大大提高。

摘自: [优化代码中大量的if/else，你有什么方案?](https://www.zhihu.com/question/344856665s)