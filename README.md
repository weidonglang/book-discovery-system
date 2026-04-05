# 新书推荐系统

一个面向图书推荐与图书流通管理的后端系统，基于 Spring Boot、Spring Security、JPA/Hibernate、PostgreSQL 和 Liquibase 构建。

## 项目定位

本项目主要用于本科毕业设计 / 课程设计展示，重点放在：

- 图书推荐与个性化展示
- 图书借阅、归还、续借、预约
- 用户注册、登录、评分、行为记录
- 数据库版本管理与基础后台能力

当前实现以本地开发、论文答辩演示、功能验证为主，不以生产环境直接部署为目标。

主包名：

```text
com.weidonglang.NewBookRecommendationSystem
```

## 技术栈

- Java 11
- Spring Boot 2.7.5
- Spring Web
- Spring Security
- Spring Data JPA
- Hibernate
- PostgreSQL
- Liquibase
- Lombok
- MapStruct
- JWT (`com.auth0:java-jwt`)
- springdoc-openapi-ui

## 目录结构

```text
new-book-recommendation-system/
├─ src/main/java/com/weidonglang/NewBookRecommendationSystem/
│  ├─ config/
│  ├─ controller/
│  ├─ dao/
│  ├─ dto/
│  ├─ entity/
│  ├─ enums/
│  ├─ exception/
│  ├─ manager/
│  ├─ recommender/
│  ├─ repository/
│  ├─ security/
│  ├─ service/
│  ├─ transformer/
│  └─ utils/
├─ src/main/resources/
│  ├─ application.properties
│  ├─ application-dev.properties
│  └─ db/
├─ src/test/java/com/weidonglang/NewBookRecommendationSystem/
├─ scripts/
├─ pom.xml
├─ mvnw.cmd
└─ mvnw-jdk11.cmd
```

## 默认运行配置

默认配置位于 [application.properties](/F:/code/java/new-book-recommendation-system/src/main/resources/application.properties)：

- 端口：`8010`
- 上下文路径：`/book-service`
- 数据库：`book_recommendation_system`
- PostgreSQL：`localhost:5043`

默认管理员账号：

- Email: `admin@booknook.local`
- Password: `Admin123!`

## 使用 JDK 11 运行

如果本机默认 Java 不是 11，优先使用项目内脚本：

```bat
mvnw-jdk11.cmd -DskipTests compile
mvnw-jdk11.cmd spring-boot:run
```

这个脚本会临时指定：

```text
C:\Program Files\Java\jdk-11.0.30+7
```

## 快速启动

### 1. 创建 PostgreSQL 数据库

```sql
CREATE DATABASE book_recommendation_system;
```

### 2. 按需修改数据库连接

```properties
spring.datasource.url=jdbc:postgresql://localhost:5043/book_recommendation_system
spring.datasource.username=postgres
spring.datasource.password=your_password
```

### 3. 编译并启动

```bat
mvnw-jdk11.cmd -DskipTests compile
mvnw-jdk11.cmd spring-boot:run
```

### 4. 访问地址

```text
http://localhost:8010/book-service
http://localhost:8010/book-service/swagger-ui/index.html
```

## 功能概览

当前已实现的核心功能包括：

- 用户注册、登录、刷新令牌、退出登录
- 图书、作者、分类、标签、出版社管理
- 图书评分
- 推荐书架与相似图书推荐
- 图书借阅、归还、续借
- 图书预约与排队
- 搜索与行为日志记录
- Liquibase 数据库版本管理

## 推荐能力

系统当前包含以下推荐能力：

- 热门图书推荐
- 基于阅读偏好的推荐
- 基于评分与借阅行为的推荐
- 相似图书推荐
- 保留协同过滤推荐器实现，便于后续扩展

## 借阅与预约规则

- 每位用户最多同时借阅 5 本书
- 默认借期 14 天
- 每笔借阅最多续借 1 次
- 每次续借延长 7 天
- 同一本未归还图书不能重复借阅
- 有预约队列时，仅队首用户可优先借阅

## 项目说明

这个项目当前更适合作为毕业设计演示系统使用。

也就是说：

- 当前配置更偏向本地快速启动
- 重点是功能完整、可演示、可答辩说明
- 一些安全强化和生产化治理可以作为后续扩展点写进论文或答辩说明

如果后续继续向生产级项目推进，可以进一步补充：

- Refresh Token 哈希存储
- 更严格的数据库约束
- 配置外置化和密钥管理
- 更完整的审计、限流和日志脱敏

## API 示例

### 登录

```http
POST /book-service/api/auth/log-in
Content-Type: application/json
```

```json
{
  "email": "wei@example.com",
  "password": "123456"
}
```

### 图书评分

```http
POST /book-service/api/book/rate
Authorization: Bearer <access_token>
Content-Type: application/json
```

```json
{
  "book": { "id": 10 },
  "rate": 5
}
```

### 借书

```http
POST /book-service/api/loan/borrow
Authorization: Bearer <access_token>
Content-Type: application/json
```

```json
{
  "bookId": 10
}
```

## 这次如何测试

### 1. 直接编译

```bat
mvnw-jdk11.cmd -DskipTests compile
```

如果通过，说明配置已经恢复成“开箱可跑”的状态。

### 2. 直接启动

```bat
mvnw-jdk11.cmd spring-boot:run
```

### 3. 登录测试

如果数据库里还没有管理员，项目启动时会自动创建默认管理员。

然后你可以用下面账号登录：

- 邮箱：`admin@booknook.local`
- 密码：`Admin123!`

登录接口：

```http
POST /book-service/api/auth/log-in
```

请求体：

```json
{
  "email": "admin@booknook.local",
  "password": "Admin123!"
}
```
