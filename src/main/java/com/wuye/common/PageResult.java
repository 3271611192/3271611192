package com.wuye.common;

import lombok.Data;

import java.util.List;

/**
 * 分页工具类
 * 用于封装分页查询的结果数据
 * @param <T> 数据类型
 */
@Data
public class PageResult<T> {
    /**
     * 当前页码
     */
    private Integer currentPage;
    
    /**
     * 每页显示的数据条数
     */
    private Integer pageSize;
    
    /**
     * 总记录数
     */
    private Long total;
    
    /**
     * 总页数
     */
    private Integer totalPages;
    
    /**
     * 当前页的数据列表
     */
    private List<T> data;
    
    /**
     * 是否有上一页
     */
    private Boolean hasPrevious;
    
    /**
     * 是否有下一页
     */
    private Boolean hasNext;

    /**
     * 构造方法
     * @param currentPage 当前页码
     * @param pageSize 每页大小
     * @param total 总记录数
     * @param data 数据列表
     */
    public PageResult(Integer currentPage, Integer pageSize, Long total, List<T> data) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.total = total;
        this.data = data;
        
        // 计算总页数
        this.totalPages = (int) Math.ceil((double) total / pageSize);
        
        // 判断是否有上一页
        this.hasPrevious = currentPage > 1;
        
        // 判断是否有下一页
        this.hasNext = currentPage < totalPages;
    }

    /**
     * 无参构造方法
     */
    public PageResult() {
    }
}
