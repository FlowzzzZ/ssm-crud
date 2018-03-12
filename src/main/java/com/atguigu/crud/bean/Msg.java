package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

//通用返回类
	//状态码
	private int code;
	
	//提示信息
	private String msg;
	
	//用户要返回的浏览器数据
	private Map<String,Object> extend= new HashMap<String, Object>();

	public Msg add(String key,Object value){
		this.getExtend().put(key, value);
		return this;
	};
	
	public static Msg success(){
		 Msg result=new Msg();
		 result.setCode(100);
		 result.setMsg("处理成功");
		 return result;	
	}
	
	public static Msg fail(){
		 Msg result=new Msg();
		 result.setCode(200);
		 result.setMsg("处理失败");
		 return result;	
	}
	
	public int getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public void setCode(int code) {
		this.code = code;
	}

	

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extent) {
		this.extend = extend;
	}

	
	
	
}