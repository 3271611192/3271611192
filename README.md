# 智慧物业管理系统

## 项目简介
基于SSM(Spring + Spring MVC + MyBatis)架构开发的智慧物业管理系统，实现了完整的增删改查、登录退出登录功能，支持分页展示和一键返回上一页功能，界面简洁柔和。

## 技术栈
- **后端框架**: Spring 5.3.20, Spring MVC 5.3.20, MyBatis 3.5.10
- **数据库**: MySQL 8.0
- **连接池**: Druid 1.2.8
- **前端技术**: JSP, JSTL, HTML5, CSS3, JavaScript
- **构建工具**: Maven
- **服务器**: Tomcat 7+
- **JDK版本**: 1.8

## 项目结构
```
wuyecontrol_system/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/wuye/
│   │   │       ├── common/          # 通用工具类(分页、结果封装)
│   │   │       ├── controller/      # 控制器层(处理HTTP请求)
│   │   │       ├── entity/          # 实体类(对应数据库表)
│   │   │       ├── interceptor/     # 拦截器(登录验证)
│   │   │       ├── mapper/          # Mapper接口(数据库操作)
│   │   │       └── service/         # 服务层(业务逻辑)
│   │   ├── resources/
│   │   │   ├── mapper/              # MyBatis XML映射文件
│   │   │   ├── jdbc.properties      # 数据库配置
│   │   │   ├── logback.xml          # 日志配置
│   │   │   ├── mybatis-config.xml   # MyBatis配置
│   │   │   ├── spring-mybatis.xml   # Spring整合MyBatis配置
│   │   │   └── spring-mvc.xml       # Spring MVC配置
│   │   └── webapp/
│   │       ├── static/              # 静态资源(CSS)
│   │       └── WEB-INF/
│   │           ├── views/           # JSP页面
│   │           └── web.xml          # Web应用配置
│   └── test/                        # 测试代码
├── sql/
│   └── init.sql                     # 数据库初始化脚本
└── pom.xml                          # Maven项目配置
```

## 功能模块

### 1. 用户管理
- 用户登录/退出登录
- 用户列表查询(分页)
- 用户信息的增删改查
- 用户角色管理(管理员/普通用户)
- 用户状态管理(启用/禁用)

### 2. 业主管理
- 业主信息的增删改查
- 业主列表查询(分页)
- 业主基本信息维护

### 3. 房屋管理
- 房屋信息的增删改查
- 房屋列表查询(分页)
- 房屋状态管理(空置/自住/出租)

### 4. 缴费管理
- 缴费记录的增删改查
- 缴费记录列表查询(分页)
- 缴费状态管理(已缴费/未缴费)
- 支持多种费用类型(物业费、水费、电费、燃气费、停车费)

## 核心功能说明

### 分页功能
- 每页显示10条数据
- 支持上一页、下一页、首页跳转
- 显示当前页码、总页数、总记录数
- 自动计算是否有上一页/下一页

### 一键返回功能
- 每个页面都有"返回上一页"按钮(使用`javascript:history.back()`)
- 每个页面都有"返回首页"按钮
- 支持浏览器后退按钮

### 登录拦截功能
- 使用Spring MVC拦截器实现
- 未登录用户自动跳转到登录页面
- 登录成功后信息存储在Session中
- 排除登录页面和静态资源的拦截

## 部署说明

### 1. 数据库配置
```bash
# 1. 创建数据库并导入初始化脚本
mysql -u root -p
source sql/init.sql

# 2. 修改数据库连接配置(src/main/resources/jdbc.properties)
jdbc.username=root
jdbc.password=你的密码
```

### 2. 项目启动
```bash
# 方式1: 使用Maven命令启动
mvn clean package
mvn tomcat7:run

# 方式2: 部署到Tomcat服务器
# 将项目打包成war文件后,复制到Tomcat的webapps目录下
mvn clean package
# 将target/wuyecontrol_system.war复制到Tomcat/webapps目录
```

### 3. 访问系统
- 访问地址: http://localhost:8080
- 默认管理员账号: admin
- 默认密码: 123456

## 界面效果
- 采用渐变色背景,简洁柔和
- 使用圆角设计,视觉更加友好
- 按钮悬停有阴影和位移效果
- 表格列表清晰易读
- 响应式设计,支持移动端访问

## 代码注释
每个功能模块都添加了详细的中文注释,包括:
- 类级别注释:说明类的作用
- 方法级别注释:说明方法的功能、参数、返回值
- 关键代码注释:解释重要逻辑的实现原理

## 开发者
智慧物业管理系统开发团队

## 版本
v1.0.0

## 许可
MIT License
