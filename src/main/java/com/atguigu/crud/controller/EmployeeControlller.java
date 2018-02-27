package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.service.EmployeeSerivce;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Controller
public class EmployeeControlller {
/*处理crud请求*/
	@Autowired
	//自动装配service层逻辑组件
	EmployeeSerivce employeeSerivce;
	/*查询员工数据（分页）*/
	@RequestMapping("/emps")
	public String getemps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model){
		
	//引入分页插件
	//查询之前只需要调用，插入页码，以及每页的大小
	PageHelper.startPage(pn,5);
	//startpage紧跟的查询就是一个分页查询
	List<Employee> emps=employeeSerivce.getAll();	
	//使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行了
	//封装了详细信息
	PageInfo page = new PageInfo(emps,5);
	model.addAttribute("pageInfo",page);
	
	
	return "list";
	}
	
	
}
