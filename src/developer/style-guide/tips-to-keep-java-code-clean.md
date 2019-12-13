---
title: 整洁 Java 代码
type: 整洁 Java 代码
---

## 工具函数

### 整理理念

- 函数式编程，减少业务代码，逻辑一目了然。
- 通用工具函数，逻辑考虑周全，出问题概率低。

### 场景一：比较对象

```
// 不完善
thisName != null && thisName.equals(name);

// 冗余
(thisName == name) || (thisName != null && thisName.equals(name));

// 整洁
Objects.equals(name, thisName);
```

### 场景一：判断对象为空

```
// 冗余
!(list == null || list.isEmpty());

// 整洁
import org.apache.commons.collections4.CollectionUtils;
CollectionUtils.isNotEmpty(list);
```

## 拆分长函数

### 整洁理念

- 函数越短小精悍，功能就越单一，往往生命周期较长；
- 函数越长越不容易理解和维护，维护人员不敢轻易修改；
- 过长函数中，往往含有难以发现的重复代码。

理解思路:

- 当函数超过 80 行后，就属于长函数，需要进行拆分。
- 代码块前方有一行注释，就是提醒你可以将这段代码替换成一个函数。
- 函数有一个描述恰当的名字，就不需要去看内部代码究竟是如何实现的。

### 场景一：代码块封装为函数

冗余场景:

```
// 每日生活函数
public void liveDaily() {
    // 吃饭
    // 吃饭相关代码几十行

    // 编码
    // 编码相关代码几十行

    // 睡觉
    // 睡觉相关代码几十行
}
```

整洁方案:

```
// 每日生活函数
public void liveDaily() {
    // 吃饭
    eat();

    // 编码
    code();

    // 睡觉
    sleep();
}

// 吃饭函数
private void eat() {
    // 吃饭相关代码
}

// 编码函数
private void code() {
    // 编码相关代码
}

// 睡觉函数
private void sleep() {
    // 睡觉相关代码
}
```

### 场景二：循环体封装为函数

冗余场景:

```
// 生活函数
public void live() {
    while (isAlive) {
        // 吃饭
        eat();

        // 编码
        code();

        // 睡觉
        sleep();
    }
}
```

整洁方案:

```
// 生活函数
public void live() {
    while (isAlive) {
        // 每日生活
        liveDaily();
    }
}

// 每日生活函数
private void liveDaily() {
    // 吃饭
    eat();

    // 编码
    code();

    // 睡觉
    sleep();
}
```

### 场景三：条件体封装为函数

冗余场景

```
// 外出函数
public void goOut() {
    // 判断是否周末
    // 判断是否周末: 是周末则游玩
    if (isWeekday()) {
        // 游玩代码几十行
    }
    // 判断是否周末: 非周末则工作
    else {
        // 工作代码几十行
    }
}
```

整洁方案

```
// 外出函数
public void goOut() {
    // 判断是否周末
    // 判断是否周末: 是周末则游玩
    if (isWeekday()) {
        play();
        return;
    }
    // 判断是否周末: 非周末则工作
    else {
        // work();
    }
}

// 游玩函数
private void play() {
    // 游玩代码几十行
}

// 工作函数
private void work() {
    // 工作代码几十行
}
```

## 函数内代码块级别尽量一致

### 整洁理念

- 函数调用表明用途，函数实现表达逻辑，层次分明便于理解；
- 不用层次的代码块放在一起，容易让人觉得代码头重脚轻。

### 场景一：函数与代码块混合

冗余场景

```
// 每日生活函数
public void liveDaily() {
    // 吃饭
    eat();

    // 编码
    code();

    // 睡觉
    // 睡觉相关代码几十行
}
```

整洁方案

```
public void liveDaily() {
    // 吃饭
    eat();

    // 编码
    code();

    // 睡觉
    sleep();
}

// 睡觉
private void sleep() {
    // 睡觉相关代码
}
```

## 封装相同功能代码为函数

### 整理理念: 
- 封装相似代码为函数，差异性通过函数参数控制。
- 封装公共函数，减少代码行数，提高代码质量；
- 封装公共函数，使业务代码更精炼，可读性可维护性更强。

### 场景一：封装相同代码为函数

冗余场景

```
// 禁用用户函数
public void disableUser() {
    // 禁用黑名单用户
    List<Long> userIdList = queryBlackUser();
    for (Long userId : userIdList) {
        User userUpdate = new User();
        userUpdate.setId(userId);
        userUpdate.setEnable(Boolean.FALSE);
        userDAO.update(userUpdate);
    }

    // 禁用过期用户
    userIdList = queryExpiredUser();
    for (Long userId : userIdList) {
        User userUpdate = new User();
        userUpdate.setId(userId);
        userUpdate.setEnable(Boolean.FALSE);
        userDAO.update(userUpdate);
    }
}
```

整洁方案

```
// 禁用用户函数
public void disableUser() {
    // 禁用黑名单用户
    List<Long> userIdList = queryBlackUser();
    for (Long userId : userIdList) {
        disableUser(userId);
    }

    // 禁用过期用户
    userIdList = queryExpiredUser();
    for (Long userId : userIdList) {
        disableUser(userId);
    }
}

// 禁用用户函数
private void disableUser(Long userId) {
    User userUpdate = new User();
    userUpdate.setId(userId);
    userUpdate.setEnable(Boolean.FALSE);
    userDAO.update(userUpdate);
}
```

### 场景二：封装相似代码为函数

冗余场景

```
// 通过工单函数
public void adoptOrder(Long orderId) {
    Order orderUpdate = new Order();
    orderUpdate.setId(orderId);
    orderUpdate.setStatus(OrderStatus.ADOPTED);
    orderUpdate.setAuditTime(new Date());
    orderDAO.update(orderUpdate);
}

// 驳回工单函数
public void rejectOrder(Long orderId) {
    Order orderUpdate = new Order();
    orderUpdate.setId(orderId);
    orderUpdate.setStatus(OrderStatus.REJECTED);
    orderUpdate.setAuditTime(new Date());
    orderDAO.update(orderUpdate);
}
```

整洁方案

```
// 通过工单函数
public void adoptOrder(Long orderId) {
    auditOrder(orderId, OrderStatus.ADOPTED);
}

// 驳回工单函数
public void rejectOrder(Long orderId) {
    auditOrder(orderId, OrderStatus.REJECTED);
}

// 审核工单函数
private void auditOrder(Long orderId, OrderStatus orderStatus) {
    Order orderUpdate = new Order();
    orderUpdate.setId(orderId);
    orderUpdate.setStatus(orderStatus);
    orderUpdate.setAuditTime(new Date());
    orderDAO.update(orderUpdate);
}
```

## 封装获取`参数值函数`

### 整洁理念

- 把获取参数值从业务函数中独立，使业务逻辑更清晰；
- 封装的获取参数值为独立函数，在代码中重复使用。

### 场景示例

冗余场景

```
// 是否通过函数
public boolean isPassed(Long userId) {
    // 获取通过阈值
    double thisPassThreshold = PASS_THRESHOLD;
    if (Objects.nonNull(passThreshold)) {
        thisPassThreshold = passThreshold;
    }

    // 获取通过率
    double passRate = getPassRate(userId);

    // 判读是否通过
    return passRate >= thisPassThreshold;
}
```

整洁方案

```
// 是否通过函数
public boolean isPassed(Long userId) {
    // 获取通过阈值
    double thisPassThreshold = getPassThreshold();

    // 获取通过率
    double passRate = getPassRate(userId);

    // 判读是否通过
    return passRate >= thisPassThreshold;
}

// 获取通过阈值函数
private double getPassThreshold() {
    if (Objects.nonNull(passThreshold)) {
        return passThreshold;
    }
    return PASS_THRESHOLD;
}
```

## 接口参数化封装相同逻辑

### 整洁理念

- 把核心逻辑从各个业务函数中抽取，使业务代码更清晰更易维护；
- 避免重复性代码多次编写，精简重复函数越多收益越大。

### 场景示例

冗余场景

```
// 发送审核员结算数据函数
public void sendAuditorSettleData() {
    List<WorkerSettleData> settleDataList = auditTaskDAO.statAuditorSettleData();
    for (WorkerSettleData settleData : settleDataList) {
        WorkerPushData pushData = new WorkerPushData();
        pushData.setId(settleData.getWorkerId());
        pushData.setType(WorkerPushDataType.AUDITOR);
        pushData.setData(settleData);
        pushService.push(pushData);
    }
}

// 发送验收员结算数据函数
public void sendCheckerSettleData() {
    List<WorkerSettleData> settleDataList = auditTaskDAO.statCheckerSettleData();
    for (WorkerSettleData settleData : settleDataList) {
        WorkerPushData pushData = new WorkerPushData();
        pushData.setId(settleData.getWorkerId());
        pushData.setType(WorkerPushDataType.CHECKER);
        pushData.setData(settleData);
        pushService.push(pushData);
    }
}
```

整洁方案

```
// 发送审核员结算数据函数
public void sendAuditorSettleData() {
    sendWorkerSettleData(WorkerPushDataType.AUDITOR, () -> auditTaskDAO.statAuditorSettleData());
}

// 发送验收员结算数据函数
public void sendCheckerSettleData() {
    sendWorkerSettleData(WorkerPushDataType.CHECKER, () -> auditTaskDAO.statCheckerSettleData());
}

// 发送作业员结算数据函数
public void sendWorkerSettleData(WorkerPushDataType dataType, WorkerSettleDataProvider dataProvider) {
    List<WorkerSettleData> settleDataList = dataProvider.statWorkerSettleData();
    for (WorkerSettleData settleData : settleDataList) {
        WorkerPushData pushData = new WorkerPushData();
        pushData.setId(settleData.getWorkerId());
        pushData.setType(dataType);
        pushData.setData(settleData);
        pushService.push(pushData);
    }
}

// 作业员结算数据提供者接口
private interface WorkerSettleDataProvider {
    // 统计作业员结算数据
    public List<WorkerSettleData> statWorkerSettleData();
}
```

## 减少函数代码层级

### 整洁理念

- 代码层级减少，代码缩进减少；
- 模块划分清晰，方便阅读维护。
- 过多的缩进会让函数难以阅读。
- 函数代码层级控制在1-4之间。

### 场景一：提前 `return` 返回函数

冗余场景

```
// 获取用户余额函数
public Double getUserBalance(Long userId) {
    User user = getUser(userId);
    if (Objects.nonNull(user)) {
        UserAccount account = user.getAccount();
        if (Objects.nonNull(account)) {
            return account.getBalance();
        }
    }
    return null;
}
```

整洁方案

```
// 获取用户余额函数
public Double getUserBalance(Long userId) {
    // 获取用户信息
    User user = getUser(userId);
    if (Objects.isNull(user)) {
        return null;
    }

    // 获取用户账户
    UserAccount account = user.getAccount();
    if (Objects.isNull(account)) {
        return null;
    }

    // 返回账户余额
    return account.getBalance();
}
```

### 场景二：提前 `continue` 结束循环

整洁建议:

- 在循环体中，建议最多使用一次continue。
- 需要多次 continue 时，把循环体封装为函数。

冗余场景

```
// 获取合计余额函数
public double getTotalBalance(List<User> userList) {
    // 初始合计余额
    double totalBalance = 0.0D;

    // 依次累加余额
    for (User user : userList) {
        // 获取用户账户
        UserAccount account = user.getAccount();
        if (Objects.nonNull(account)) {
            // 累加用户余额
            Double balance = account.getBalance();
            if (Objects.nonNull(balance)) {
                totalBalance += balance;
            }
        }
    }
    // 返回合计余额
    return totalBalance;
}
```

整洁方案

```
// 获取合计余额函数
public double getTotalBalance(List<User> userList) {
    // 初始合计余额
    double totalBalance = 0.0D;

    // 依次累加余额
    for (User user : userList) {
        // 获取用户账户
        UserAccount account = user.getAccount();
        if (Objects.isNull(account)) {
            continue;
        }

        // 累加用户余额
        Double balance = account.getBalance();
        if (Objects.nonNull(balance)) {
            totalBalance += balance;
        }
    }

    // 返回合计余额
    return totalBalance;
}
```

## 封装条件表达式函数

### 整洁理念

- 把条件表达式从业务函数中独立，使业务逻辑更清晰；
- 封装的条件表达式为独立函数，可以在代码中重复使用。

### 场景一：封装简单条件表达式为函数

冗余场景

```
// 获取门票价格函数
public double getTicketPrice(Date currDate) {
    if (Objects.nonNull(currDate) && currDate.after(DISCOUNT_BEGIN_DATE)
        && currDate.before(DISCOUNT_END_DATE)) {
        return TICKET_PRICE * DISCOUNT_RATE;
    }
    return TICKET_PRICE;
}
```

整洁方案

```
// 获取门票价格函数
public double getTicketPrice(Date currDate) {
    if (isDiscountDate(currDate)) {
        return TICKET_PRICE * DISCOUNT_RATE;
    }
    return TICKET_PRICE;
}

// 是否折扣日期函数
private static boolean isDiscountDate(Date currDate) {
    return Objects.nonNull(currDate) 
        && currDate.after(DISCOUNT_BEGIN_DATE)
        && currDate.before(DISCOUNT_END_DATE);
}
```

### 场景二：封装复杂条件表达式为函数

整洁建议: 也可以用流式(Stream)编程的过滤来实现。

冗余场景

```
// 获取土豪用户列表
public List<User> getRichUserList(List<User> userList) {
    // 初始土豪用户列表
    List<User> richUserList = new ArrayList<>();

    // 依次查找土豪用户
    for (User user : userList) {
        // 获取用户账户
        UserAccount account = user.getAccount();
        if (Objects.nonNull(account)) {
            // 判断用户余额
            Double balance = account.getBalance();
            if (Objects.nonNull(balance) && balance.compareTo(RICH_THRESHOLD) >= 0) {
                // 添加土豪用户
                richUserList.add(user);
            }
        }
    }

    // 返回土豪用户列表
    return richUserList;
}
```

整洁方案

```
// 获取土豪用户列表
public List<User> getRichUserList(List<User> userList) {
    // 初始土豪用户列表
    List<User> richUserList = new ArrayList<>();

    // 依次查找土豪用户
    for (User user : userList) {
        // 判断土豪用户
        if (isRichUser(user)) {
            // 添加土豪用户
            richUserList.add(user);
        }
    }

    // 返回土豪用户列表
    return richUserList;
}

// 是否土豪用户
private boolean isRichUser(User user) {
    // 获取用户账户
    UserAccount account = user.getAccount();
    if (Objects.isNull(account)) {
        return false;
    }

    // 获取用户余额
    Double balance = account.getBalance();
    if (Objects.isNull(balance)) {
        return false;
    }

    // 比较用户余额
    return balance.compareTo(RICH_THRESHOLD) >= 0;
}
```

## 避免不必要的空指针判断

### 整洁理念

- 避免不必要的空指针判断，精简业务代码处理逻辑，提高业务代码运行效率；
- 不必要的空指针判断，属于永远不执行的Death代码，删除有助于代码维护。

### 场景一：MyBatis 返回值

MyBatis是一款优秀的持久层框架，是在项目中使用的最广泛的数据库中间件之一。

通过对MyBatis源码进行分析，查询函数返回的列表和数据项都不为空，在代码中可以不用进行空指针判断。


## 参考/摘录

- [Java代码整洁之道](https://blog.csdn.net/qq_32447301/article/details/97042462)




































































































































































































































