package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.junit.runner.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.filter.HttpPutFormContentFilter;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeSerivce;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Controller
public class EmployeeControlller {
/*处理crud请求*/
	@Autowired
	//自动装配service层逻辑组件
	EmployeeSerivce employeeSerivce;
	
	/**
	 * 
	 * 删除
	 * @param employee
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids ){
		if(ids.contains("-")){
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids=ids.split("-");
			for(String string:str_ids){
				del_ids.add(Integer.parseInt(string));
			}
			employeeSerivce.deleteBath(del_ids);
		}else{
			Integer id=Integer.parseInt(ids);
			employeeSerivce.deleteEmp(id);
		}
		
		return Msg.success();
		
	}
	
	
	
	
	
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		
		employeeSerivce.updateEmp(employee);
		return Msg.success();
		
	}
	
	
	
	
	
	
	/**
	 * genjuid查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee=employeeSerivce.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*查询员工数据（分页）*/
	
	/*导入jackson包*/
	
	//检查用户名是否可用
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否合法
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或2-5位中文");
		}
		//数据库用户名重复校验
		boolean b=employeeSerivce.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
			
		}
		
	}
	/*保存员工
	 * 
	 * js303校验
	 * 1、导入hibernate-validator
	 * */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			
			//在modal中显示错误信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors =result.getFieldErrors();
			for(FieldError fieldError:errors){
				System.out.println("错误的字段名"+fieldError.getField());
				System.out.println("错误信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
			
		}else{
			
		}
		employeeSerivce.saveEmp(employee);
		return Msg.success();
	}
	
	
	//将返回的对象转换为jspn字符串
	@RequestMapping("/emps")
	@ResponseBody 
	public  Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		//引入分页插件
		//查询之前只需要调用，插入页码，以及每页的大小
		PageHelper.startPage(pn,5);
		//startpage紧跟的查询就是一个分页查询
		List<Employee> emps=employeeSerivce.getAll();	
		//使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行了
		//封装了详细信息
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	//
	/*public String getemps(@RequestParam(value="pn",defaultValue="1")Integer pn,
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
	}*/
	
	
}
