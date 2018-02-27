package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/*测试dao层工作*/


	 /* spring项目可以使用spring的单元测试，可以自动诸如我们需要的组件
	 * 1.通过maven导入springtest模块
	 * 2.@ContextConfiguration指定spring配置文件的位置
	 * 3.直接autowired要使用的组件
	 * */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlsession;
	 
	
	/*
	 * 测试departmentMapper
	 */
	@Test
	public void testCRUD(){
		
/*	传统方法	
 * 1.创建IOC容器
		2.从容器中获取mapper
*/		
		
		System.out.println(departmentMapper);
		
	//1.插入几个部门
		/*departmentMapper.insertSelective(new Department(null,"开发部"));
		departmentMapper.insertSelective(new Department(null,"测试部"));*/
	//2.插入员工
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
//	  3.批量插入多个员工，使用可以执行批量操作的sqlsession
		EmployeeMapper mapper= sqlsession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++){
			String uid =UUID.randomUUID().toString().substring(0,5);
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@atguigu", 1));
		}
		System.out.println("批量生产完成");
		
		
	}
	
	
}
