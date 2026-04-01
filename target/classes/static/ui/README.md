# Book UI Skeleton for henry-azer/book-recommendation-system

这是按你当前基础版目标做的一套 **8 个页面骨架**，默认适配 `henry-azer/book-recommendation-system` 公开仓库的 REST API。

## 页面清单

1. `login.html` 登录页
2. `register.html` 注册页
3. `index.html` 首页
4. `books.html` 图书列表/搜索页
5. `book-detail.html` 图书详情页
6. `rate-book.html` 评分页
7. `recommendations.html` 推荐页
8. `profile.html` 个人中心页

## 建议放置位置

把整个 `book-ui-skeleton` 目录复制到：

```text
src/main/resources/static/ui
```

然后启动 Spring Boot 后访问：

```text
http://localhost:8010/book-service/ui/login.html
```

## 当前对接的真实接口

### AuthenticationController
- `POST /api/auth/log-in`
- `GET /api/auth/current`
- `POST /api/auth/refresh-token`
- `GET /api/auth/log-out`

### BookController
- `GET /api/book/find-by-id/{bookId}`
- `GET /api/book/find-all-recommended`
- `GET /api/book/find-all-by-author-id/{authorId}`
- `GET /api/book/find-all-categories`
- `POST /api/book/find-all-paginated-filtered`
- `POST /api/book/rate`
- `POST /api/book`
- `PUT /api/book`

### UserController
- `POST /api/user`
- `PUT /api/user`
- `GET /api/user/find-reading-info`
- `POST /api/user/reading-info`
- `GET /api/user/find-is-email-exists/{email}`
- `GET /api/user/find-all-genders`
- `GET /api/user/find-all-martial-statuses`

### AuthorController
- `GET /api/author/find-by-id/{authorId}`
- `POST /api/author/find-all-paginated-filtered`

## 你现在最该做的两件事

### 1. 先确认后端能正常启动
仓库默认：
- 端口：`8010`
- context-path：`/book-service`

### 2. 先把页面跑起来再逐页修后端字段
目前前端已经尽量按仓库 DTO 写了，但你本地如果改过实体、DTO、鉴权逻辑，可能有 3 类接口要微调：
- 注册接口字段
- 评分接口 payload
- 阅读偏好 `reading-info` payload

## 已知需要你留意的点

1. 仓库本身没有现成前端，这套页面是新增的静态前端骨架。
2. `SecurityConfigurations` 里允许匿名访问的是 `/api/user/register`，但真正创建用户的控制器是 `POST /api/user`。如果你本地把安全策略改严了，注册页可能被拦住，需要把匿名放行路径改成 `/api/user`。
3. CORS 只放行了 `http://localhost:3000`。如果你把这些页面作为 Spring Boot 静态资源同源访问，一般没问题；如果单独用别的端口起前端，需要改后端 CORS。
4. 这套骨架目前重视“先跑通”，样式是故意压简的，方便你后面继续往 Vue 或 Element Plus 迁移。

## 后续最值得继续补的三个点

1. 把 `books.html` 的结果页继续改成你毕设要的“命中原因 / 来源标识 / 检索解释”版本。
2. 把 `recommendations.html` 的假解释改成真实“推荐来源绑定解释”。
3. 把 `profile.html` 的阅读偏好输入框改成真正的分类多选。
