---
layout: partial
---

## 交付规范

### 思维脑图

![培训交付规范](/images/培训总结交付规范-01.png)

*注: attachments/xmind/培训总结交付规范.xmind*

### 注意事项

1. 明确交付主题，创建**主题名称的目录**
2. 图片文件命名以**主题为前缀**，以**序号为后缀**
2. 创建 `images` 目录，并把相关图片放在该目录
3. `markdown` 原稿中使用**相对路径**引用图片
4. `markdown` 原稿与导出的 PDF 文档放在主题目录
5. 打包 `zip` 压缩文档作为交付文档

### 交付示例

1. *示例文档*目录结构

  ```
  $ tree Desktop/

  Desktop/
  ├── 交付文档示例
  │   ├── images
  │   │   ├── 交付文档示例-01.jpeg
  │   │   └── 交付文档示例-02.png
  │   ├── 交付文档示例.md
  │   └── 交付文档示例.pdf
  └── 交付文档示例.zip // 交付文档
  ```

2. 图片引用示例

```
## 交付文档示例

![交付文档示例-01](images/交付文档示例-01.jpeg)
![交付文档示例-02](images/交付文档示例-02.png)
```

2. 配置 `.md` 文档默认使用 MacDown 软件打开

  ![培训总结交付规范](/images/培训总结交付规范-02.png)