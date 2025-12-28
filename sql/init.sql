-- 创建数据库
CREATE DATABASE IF NOT EXISTS wuye_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE wuye_system;

-- ============================================
-- 用户表：存储系统登录用户信息
-- ============================================
CREATE TABLE IF NOT EXISTS tb_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    real_name VARCHAR(50) COMMENT '真实姓名',
    phone VARCHAR(20) COMMENT '联系电话',
    role VARCHAR(20) DEFAULT 'user' COMMENT '用户角色：admin-管理员，user-普通用户',
    status INT DEFAULT 1 COMMENT '账号状态：0-禁用，1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ============================================
-- 房屋表：存储小区房屋信息
-- ============================================
CREATE TABLE IF NOT EXISTS tb_house (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '房屋ID',
    building_no VARCHAR(20) NOT NULL COMMENT '楼栋号',
    unit_no VARCHAR(20) NOT NULL COMMENT '单元号',
    room_no VARCHAR(20) NOT NULL COMMENT '房号',
    area DECIMAL(10,2) COMMENT '房屋面积（平方米）',
    house_type VARCHAR(50) DEFAULT '住宅' COMMENT '房屋类型：住宅、商铺、车库等',
    status VARCHAR(20) DEFAULT '空置' COMMENT '房屋状态：空置、自住、出租',
    remark VARCHAR(500) COMMENT '备注信息',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_house (building_no, unit_no, room_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='房屋表';

-- ============================================
-- 业主表：存储小区业主基本信息
-- ============================================
CREATE TABLE IF NOT EXISTS tb_owner (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '业主ID',
    name VARCHAR(50) NOT NULL COMMENT '业主姓名',
    gender VARCHAR(10) COMMENT '性别：男、女',
    phone VARCHAR(20) NOT NULL COMMENT '联系电话',
    id_card VARCHAR(18) COMMENT '身份证号',
    email VARCHAR(100) COMMENT '电子邮箱',
    house_id BIGINT COMMENT '房屋ID',
    remark VARCHAR(500) COMMENT '备注信息',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    KEY idx_house_id (house_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='业主表';

-- ============================================
-- 缴费记录表：存储业主物业费、水电费等缴费记录
-- ============================================
CREATE TABLE IF NOT EXISTS tb_payment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '缴费记录ID',
    owner_id BIGINT NOT NULL COMMENT '业主ID',
    house_id BIGINT NOT NULL COMMENT '房屋ID',
    payment_type VARCHAR(50) NOT NULL COMMENT '费用类型：物业费、水费、电费、燃气费、停车费',
    amount DECIMAL(10,2) NOT NULL COMMENT '缴费金额',
    status INT DEFAULT 0 COMMENT '缴费状态：0-未缴费，1-已缴费',
    payment_time DATETIME COMMENT '缴费时间',
    billing_month VARCHAR(7) COMMENT '账单月份，格式：2024-01',
    remark VARCHAR(500) COMMENT '备注信息',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    KEY idx_owner_id (owner_id),
    KEY idx_house_id (house_id),
    KEY idx_billing_month (billing_month)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='缴费记录表';

-- ============================================
-- 初始化数据：插入默认管理员账号
-- ============================================
INSERT INTO tb_user (username, password, real_name, phone, role, status) 
VALUES ('admin', '123456', '系统管理员', '13800138000', 'admin', 1);

-- ============================================
-- 初始化数据：插入示例房屋信息
-- ============================================
INSERT INTO tb_house (building_no, unit_no, room_no, area, house_type, status) VALUES
('1号楼', '1单元', '101', 89.50, '住宅', '自住'),
('1号楼', '1单元', '102', 95.30, '住宅', '出租'),
('1号楼', '1单元', '201', 89.50, '住宅', '空置'),
('1号楼', '2单元', '101', 120.00, '住宅', '自住'),
('2号楼', '1单元', '101', 85.00, '住宅', '自住');

-- ============================================
-- 初始化数据：插入示例业主信息
-- ============================================
INSERT INTO tb_owner (name, gender, phone, id_card, email, house_id) VALUES
('张三', '男', '13912345678', '310101199001011234', 'zhangsan@example.com', 1),
('李四', '女', '13923456789', '310101199102022345', 'lisi@example.com', 2),
('王五', '男', '13934567890', '310101199203033456', 'wangwu@example.com', 4),
('赵六', '女', '13945678901', '310101199304044567', 'zhaoliu@example.com', 5);

-- ============================================
-- 初始化数据：插入示例缴费记录
-- ============================================
INSERT INTO tb_payment (owner_id, house_id, payment_type, amount, status, payment_time, billing_month) VALUES
(1, 1, '物业费', 200.00, 1, '2024-12-05 10:30:00', '2024-12'),
(1, 1, '水费', 45.50, 1, '2024-12-05 10:30:00', '2024-12'),
(2, 2, '物业费', 220.00, 0, NULL, '2024-12'),
(3, 4, '物业费', 280.00, 1, '2024-12-03 14:20:00', '2024-12'),
(4, 5, '电费', 150.00, 0, NULL, '2024-12');
-- ============================================
-- 设备维修表：存储小区设备维修记录
-- ============================================
CREATE TABLE IF NOT EXISTS tb_maintenance (
                                              id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '维修记录ID',
                                              device_name VARCHAR(100) NOT NULL COMMENT '设备名称',
    device_location VARCHAR(200) NOT NULL COMMENT '设备位置',
    problem_description TEXT COMMENT '问题描述',
    repair_status VARCHAR(20) DEFAULT '待处理' COMMENT '维修状态：待处理、处理中、已完成、已取消',
    priority VARCHAR(20) DEFAULT '中' COMMENT '优先级：高、中、低',
    reporter VARCHAR(50) COMMENT '报告人',
    reporter_phone VARCHAR(20) COMMENT '报告人联系方式',
    repair_person VARCHAR(50) COMMENT '维修人员',
    repair_time DATETIME COMMENT '维修时间',
    repair_cost DECIMAL(10,2) COMMENT '维修费用',
    remark VARCHAR(500) COMMENT '备注信息',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    KEY idx_device_name (device_name),
    KEY idx_repair_status (repair_status),
    KEY idx_create_time (create_time)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备维修表';

-- ============================================
-- 初始化数据：插入示例设备维修记录
-- ============================================
INSERT INTO tb_maintenance (device_name, device_location, problem_description, repair_status, priority, reporter, reporter_phone, repair_person, repair_cost) VALUES
                                                                                                                                                                  ('楼道照明灯', '1号楼1单元', '1楼照明灯不亮', '已完成', '中', '张三', '13912345678', '李师傅', 80.00),
                                                                                                                                                                  ('电梯', '2号楼', '电梯运行时有异响', '处理中', '高', '物业管理员', '13800138000', '王师傅', 300.00),
                                                                                                                                                                  ('门禁系统', '小区大门', '门禁无法识别业主卡', '待处理', '高', '赵六', '13945678901', NULL, NULL),
                                                                                                                                                                  ('消防栓', '地下车库', '消防栓漏水', '已完成', '高', '保安', '13700137000', '张师傅', 150.00);
