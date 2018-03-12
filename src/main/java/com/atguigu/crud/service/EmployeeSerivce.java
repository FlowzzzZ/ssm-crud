package com.atguigu.crud.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;
@Service
public class EmployeeSerivce {
	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		 
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
		
	}

	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		//这个我相信学过Hibernate 的同学都知道这个用法 不难 你可以理解为在where 加入条件
		Criteria criteria = example.createCriteria();
		//andEmpNameEqualTo根据词意来理解这个相当于 传入的这个empName与数据库的empName进行对比 不存在返回 0 ，存在返回其他
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
		
		
		 																																								
		
	}

	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**员工删除
	 * 
	 * @param id
	 */
	
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBath(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria criteria = example.createCriteria();
		
		criteria.andEmpIdIn(ids);
		
		employeeMapper.deleteByExample(example);
		
	}

}
