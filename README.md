# 面向阅读资源发现的图书推荐与借阅管理系统

一个面向**本科毕业设计、课程设计与作品集展示**的图书服务系统项目。当前版本已经完成图书推荐、图书检索、用户认证、借阅流转与前端演示页面等核心能力；后续目标是在此基础上继续升级为一个面向**自然语言图书发现**的智能系统，逐步扩展**混合检索、证据驱动问答与可解释推荐**能力。

---

## 1. 项目简介

传统图书系统通常只能支持“按书名、作者、ISBN 搜索”的结构化查找，但很难处理类似下面这样的自然语言需求：

- 想找一本适合入门的心理学书，不要太学术
- 有没有像《三体》一样设定宏大、但更容易读的科幻书
- 我最近喜欢悬疑推理，推荐几本节奏快一点的书

本项目的目标，是把“图书管理系统”逐步升级为“图书发现系统”。

当前仓库已经完成一套可运行的 **Spring Boot + Spring Security + PostgreSQL** 图书推荐与借阅管理系统，支持用户、图书、借阅、预约、评分、推荐、前端页面展示等完整链路；后续将围绕毕业设计主线，向以下三个方向演进：

1. **混合检索**：支持精确检索、关键词检索与语义检索的融合。
2. **证据驱动问答**：围绕图书检索结果生成带来源依据的回答。
3. **可解释推荐**：不仅给出推荐结果，还说明“为什么推荐这本书”。

---

## 2. 项目定位

### 当前版本定位

当前版本更适合作为：

- 本科毕业设计的工程底座
- Java 后端课程设计 / 综合实训项目
- 图书推荐与借阅管理方向的作品集项目
- 后续扩展 AI 检索与推荐能力的基础系统

### 最终目标定位

本项目的毕业设计目标并不是做一个普通的图书管理系统，而是逐步实现一个：

> **面向阅读资源发现的自然语言混合检索、证据驱动问答与可解释推荐系统**

因此，借阅、归还、预约、后台管理等模块是系统闭环的重要组成部分；而论文与答辩主线，将重点围绕：

- 检索能力提升
- 自然语言图书发现
- 证据驱动回答
- 推荐可解释性
- 实验评测与工程可落地性

---

## 3. 当前已实现功能

### 3.1 用户与认证

- 用户注册、登录、退出登录
- Access Token / Refresh Token 认证流程
- 基于 Spring Security 的权限控制
- 默认管理员初始化引导
- 个人信息与基础用户状态管理

### 3.2 图书管理与检索

- 图书列表查询
- 多条件筛选
- 作者 / 分类 / 标签 / 出版社维度过滤
- 图书详情展示
- 图书评分
- 搜索日志与用户行为记录

### 3.3 推荐能力

- 热门图书推荐
- 基于偏好的推荐
- 基于评分和借阅行为的推荐
- 相似图书推荐
- 推荐总览书架
- 首页推荐预览与阅读看板

### 3.4 借阅流转

- 借阅
- 归还
- 续借
- 预约
- 预约排队
- 借阅状态展示
- 基础到期提醒展示

### 3.5 前端演示页面

项目内置静态前端页面，便于课程展示、毕设答辩与本地联调，当前已包含：

- 首页阅读看板
- 图书检索工作台
- 图书详情页
- 推荐书架页
- 登录页 / 注册页
- 个人中心
- 借阅记录页面

---

## 4. 毕设升级方向

在当前工程版本基础上，项目下一阶段将重点升级为更具研究价值和展示价值的系统，主要方向如下：

### 4.1 混合检索能力

计划引入：

- ISBN / 书名 / 作者等精确字段检索
- BM25 全文检索
- Dense Vector 语义检索
- 基于查询意图的混合召回与融合排序
- Reranker 精排

### 4.2 证据驱动问答能力

面向以下场景提供回答：

- 自然语言搜书
- 图书主题推荐
- 图书比较
- 阅读路径建议
- 检索结果摘要

目标是做到：

- 先检索，再生成
- 回答必须绑定图书来源
- 输出书单、理由与引用依据
- 尽量降低“自由发挥式幻觉”

### 4.3 可解释推荐能力

计划逐步扩展：

- 内容相似推荐
- 行为协同推荐
- 热门推荐
- 冷启动补全
- 推荐解释生成

推荐结果不只展示列表，还会说明：

- 因为你看过什么
- 因为你近期偏好什么类型
- 因为与你相似的读者喜欢这本书
- 因为该分类近期热度较高

---

## 5. 技术栈

### 后端

- Java 11
- Spring Boot 2.7.5
- Spring Web
- Spring Security
- Spring Data JPA
- Hibernate
- MapStruct
- Lombok
- JWT（`com.auth0:java-jwt`）
- springdoc-openapi-ui

### 数据层

- PostgreSQL
- Liquibase

### 前端

- 原生 HTML / CSS / JavaScript 静态页面

### 规划中的增强组件

- Redis
- Elasticsearch
- Python AI 服务层
- Embedding 服务
- Reranker 服务
- 本地 LLM 推理服务
- ECharts 数据看板
- Docker Compose

---

## 6. 系统目录结构

```text
new-book-recommendation-system/
├─ .mvn/
├─ list/
├─ scripts/
├─ src/
│  ├─ main/
│  │  ├─ java/com/weidonglang/NewBookRecommendationSystem/
│  │  │  ├─ config/          # 配置与启动初始化
│  │  │  ├─ controller/      # 控制层
│  │  │  ├─ dao/             # 数据访问实现
│  │  │  ├─ dto/             # 请求/响应 DTO
│  │  │  ├─ entity/          # 实体类
│  │  │  ├─ enums/           # 枚举定义
│  │  │  ├─ exception/       # 全局异常处理
│  │  │  ├─ manager/         # 基础管理器
│  │  │  ├─ recommender/     # 推荐实现
│  │  │  ├─ repository/      # JPA Repository
│  │  │  ├─ security/        # 安全配置与 JWT 过滤
│  │  │  ├─ service/         # 业务服务层
│  │  │  ├─ transformer/     # DTO / Entity 转换
│  │  │  └─ utils/           # 工具类
│  │  └─ resources/
│  │     ├─ application.properties
│  │     ├─ application-dev.properties
│  │     ├─ db/              # Liquibase 脚本
│  │     ├─ json/            # 初始化或导入数据
│  │     └─ static/ui/       # 前端页面
├─ mvnw
├─ mvnw.cmd
├─ mvnw-jdk11.cmd
├─ pom.xml
├─ switch-java.bat
├─ switch-java.ps1
└─ system.properties
```

---

## 7. 运行环境

建议环境：

- JDK 11
- Maven Wrapper（项目已内置）
- PostgreSQL 12+
- Windows + IntelliJ IDEA（推荐）
- 或任意支持 Maven 的 IDE / 终端环境

---

## 8. 快速启动

### 8.1 创建数据库

先在 PostgreSQL 中创建数据库：

```sql
CREATE DATABASE book_recommendation_system;
```

### 8.2 修改数据库连接

按本地环境修改 `src/main/resources/application.properties` 中的连接信息：

```properties
spring.datasource.url=jdbc:postgresql://localhost:5043/book_recommendation_system
spring.datasource.username=postgres
spring.datasource.password=your_password
```

### 8.3 使用 JDK 11 编译

如果本机默认 Java 版本不是 11，建议优先使用项目自带脚本：

```bash
mvnw-jdk11.cmd -DskipTests compile
```

如果你的环境已经切换到 JDK 11，也可以直接执行：

```bash
mvnw.cmd -DskipTests compile
```

### 8.4 启动项目

```bash
mvnw-jdk11.cmd spring-boot:run
```

或：

```bash
mvnw.cmd spring-boot:run
```

---

## 9. 默认配置与访问入口

当前默认配置以本地开发和答辩演示为主：

- 服务端口：`8010`
- 上下文路径：`/book-service`
- 默认数据库：`book_recommendation_system`
- 默认数据库地址：`jdbc:postgresql://localhost:5043/book_recommendation_system`

启动成功后，可访问以下入口：

- 后端根路径：`http://localhost:8010/book-service`
- Swagger 文档：`http://localhost:8010/book-service/swagger-ui/index.html`
- 前端登录页：`http://localhost:8010/book-service/ui/login.html`
- 前端首页：`http://localhost:8010/book-service/ui/index.html`

---

## 10. 开发环境默认管理员

开发环境下，可按当前初始化配置尝试默认管理员账号：

- 邮箱：`admin@booknook.local`
- 密码：`Admin123!`

> 注意：如果你准备把项目公开展示、部署上线或继续多人协作，建议立刻修改默认账号与敏感配置，并将数据库密码、JWT Secret 等信息迁移到环境变量或外部配置中。

---

## 11. 当前业务规则

当前系统内置了较明确的借阅与预约规则：

- 每位用户最多同时借阅 5 本书
- 默认借期 14 天
- 每笔借阅最多续借 1 次
- 每次续借延长 7 天
- 同一本未归还图书不能重复借阅
- 图书无库存时可进入预约队列
- 有预约队列时，通常由队首用户优先借阅

这些规则保证了项目不仅有“推荐展示”，还有完整的业务闭环，适合课程验收和毕业答辩演示。

---

## 12. 常用接口示例

### 12.1 登录

```http
POST /book-service/api/auth/log-in
Content-Type: application/json

{
  "email": "admin@booknook.local",
  "password": "Admin123!"
}
```

### 12.2 图书评分

```http
POST /book-service/api/book/rate
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "book": { "id": 10 },
  "rate": 5
}
```

### 12.3 借阅图书

```http
POST /book-service/api/loan/borrow
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "bookId": 10
}
```

更多接口请直接查看 Swagger：

```text
http://localhost:8010/book-service/swagger-ui/index.html
```

---

## 13. 测试与验证建议

建议至少按下面顺序完成验证：

### 第一步：编译项目

```bash
mvnw-jdk11.cmd -DskipTests compile
```

### 第二步：启动项目

```bash
mvnw-jdk11.cmd spring-boot:run
```

### 第三步：验证认证流程

- 使用默认管理员登录
- 检查 Access Token / Refresh Token 是否正常
- 验证受保护接口是否需要鉴权

### 第四步：验证核心业务

- 检索图书
- 查看图书详情
- 给图书评分
- 借阅 / 归还 / 续借 / 预约
- 查看推荐页与首页看板

---

## 14. 毕设研究主线建议

如果你准备将这个项目继续打磨为毕业设计，建议将论文与答辩主线统一为：

### 主线题目方向

**面向阅读资源发现的自然语言混合检索、证据驱动问答与可解释推荐关键技术研究与系统实现**

### 为什么这个方向更强

因为它能明显区别于普通图书管理系统：

- 不是只做 CRUD
- 不是只做借阅归还
- 不是简单接入大模型聊天框
- 而是围绕“自然语言图书发现”构建完整的方法、系统与实验闭环

### 论文可重点回答的问题

- 混合检索是否优于单一检索方式？
- 证据驱动的 RAG 是否能提升图书问答的可信度？
- 可解释推荐是否能提升系统展示价值与说服力？

---

## 15. 推荐的升级路线

### 阶段一：夯实当前工程底座

- 完善统一返回结构
- 完善异常处理
- 清理敏感配置
- 补充单元测试 / 集成测试
- 优化 README、接口文档与部署文档

### 阶段二：增强推荐系统

- 梳理当前推荐模块的策略边界
- 加入更清晰的热门推荐 / 行为推荐 / 内容推荐分层
- 引入协同过滤或混合推荐策略
- 增加推荐理由展示

### 阶段三：引入缓存与可视化

- 接入 Redis 缓存热门数据与推荐结果
- 增加用户行为统计
- 加入 ECharts 看板
- 展示借阅热度、分类分布、推荐点击情况

### 阶段四：升级为图书发现系统

- 接入 Elasticsearch
- 实现 BM25 + 向量混合检索
- 接入 Reranker
- 搭建自然语言搜书入口

### 阶段五：接入证据驱动问答

- 构建检索证据片段
- 实现 RAG 问答链路
- 给回答绑定图书来源与引用依据
- 做检索、问答、推荐三类实验评测

---

## 16. 二次开发建议

如果你准备继续把它做强，建议优先从下面这些方向入手：

- 把敏感配置从 `application.properties` 中移出
- 为认证流程补充更严格的安全策略
- 完善统一响应结构与错误码体系
- 为推荐服务增加策略分层与解释能力
- 引入 Redis 做缓存和防重复控制
- 为前端页面补充更完整的状态提示与交互反馈
- 增加 Docker 化部署能力
- 为后续 Elasticsearch / RAG 升级预留模块边界

---

## 17. 贡献说明

本项目基于开源项目进行二次开发，并在原有图书推荐能力基础上，进一步扩展和完善了：

- 借阅
- 归还
- 续借
- 预约排队
- 权限认证
- 项目文档
- 部署与演示能力

欢迎任何形式的贡献，包括但不限于：

- 提交 Issue
- 修复 Bug
- 补充文档
- 优化前端交互
- 增强推荐算法
- 增加测试
- 提交 Pull Request
- 基于此项目继续二次开发

---

## 18. 开源许可

本项目采用 **MIT License**。

这意味着你可以在保留原始许可声明的前提下，自由地：

- 使用
- 下载
- 复制
- 修改
- 二次开发
- 分发
- 商用

详细内容请查看仓库中的 `LICENSE` 文件。

---

## 19. 总结

这个项目当前已经具备：

- 可运行的 Java 后端系统
- 完整的用户认证与图书借阅闭环
- 基础推荐能力
- 适合答辩展示的前端页面
- 继续升级为高质量毕业设计的良好底座

下一步的核心，不是把它继续做成“更大的管理系统”，而是把它提升为：

> **一个真正面向自然语言图书发现的智能阅读资源服务系统。**

如果这个方向继续打磨到位，它会同时具备：

- 工程完整性
- 研究主线
- 展示效果
- 简历价值
- 毕设答辩说服力

