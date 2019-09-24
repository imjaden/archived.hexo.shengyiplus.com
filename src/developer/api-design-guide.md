---
title: API 设计
type: API 设计
---

## RESTFul 理念

![](/images/RESTFul-API.gif)

> 我这篇文章的写作目的，就是想在符合架构原理的前提下，理解和评估以网络为基础的应用软件的架构设计，得到一个功能强、性能好、适宜通信的架构。REST指的是一组架构约束条件和原则。- 2000, Roy Fielding

REST(Representational State Transfer) 表征性状态转移，代表着分布式服务的架构风格。 首次出现在 2000年 Roy Fielding 的博士论文中，Roy Fielding是HTTP规范的主要编写者之一。


如果一个架构符合 REST 的约束条件和原则，我们就称它为 **RESTful架构**。

REST 本身并没有创造新的技术、组件或服务，而隐藏在RESTful背后的理念就是使用 Web  的现有特征和能力， 更好地使用现有 Web 标准中的一些准则和约束。

## REST 设计原则

- **客户端-服务器**：将用户UI与数据存储分开，简化服务器组件来提高跨多个平台的用户界面的可移植性并提高可伸缩性。理解为前后端分离的思想。
- **无状态**：从客户端到服务器的每个请求都包含理解请求所需的信息，并且不能利用服务器上存储的上下文。 尽可能的避免使用 session，由客户端自己标识会话状态（token）。
- **规范接口**：REST接口约束定义：资源识别; 请求动作; 响应信息; 通过 uri 标出你要操作的资源，通过请求动作（http method）标识要执行的操作，通过返回的状态码来表示这次请求的执行结果。
- **可缓存**： 缓存约束要求将对请求的响应中的数据隐式或显式标记为可缓存或不可缓存。如果响应是可缓存的，则客户端缓存有权重用该响应数据以用于以后的等效请求。 它表示get请求响应头中应该表示有是否可缓存的头（Cache-Control)

## URI 规范

- 请求动作(HttpMethod)
  - **GET**：查询操作
  - **POST**：新增操作
  - **PUT**：更新操作
  - **PATCH**：部分更新，推荐 PUT
  - **DELETE**：删除操作

- 使用连字符 `-` 而不是 `_` 来提高 URI 的可读性
- URI 中使用小写字母
- URI 结尾不要使用文件扩展名
- 不要在末尾使用 `/`
- 不要通过 URI 隐式传参(推荐显式传参 `?username=restful`)
- 使用 Http Status 定义 API 执行结果
  - 1xx：信息, 通信传输协议级信息。
  - 2xx：成功, 表示客户端的请求已成功接受。
  - 3xx：重定向, 表示客户端必须执行一些其他操作才能完成其请求。
  - 4xx：客户端错误, 此类错误状态代码指向客户端。
  - 5xx：服务器错误, 服务器端错误。

- API 版本定义
  - URI 版本控制（推荐）
  
    ```
    http://api.example.com/v1
    http://apiv1.example.com
    ```

  - 自定义请求标头进行版本控制

    ```
    Accept-version：v1
    Accept-version：v2
    ```

  - Accept header 进行版本控制

    ```
    Accept:application / vnd.example.v1 + json
    Accept:application / vnd.example + json; version = 1.0
    ```
