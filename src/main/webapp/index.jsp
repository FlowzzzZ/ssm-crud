<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--引入标签库，给这个标签名字 取名为c，一般按照规范命名  -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>员工列表</title>
		<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());

%>
		<!--web路径
	不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
	以/开始的相对路径，找资源，以服务器为标准，（http：//localhost:3306），需要加上项目名称
	 （http：//localhost:3306/crud） -->
		<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
		<!-- jquery -->
		<script src="${APP_PATH}/static/js/jquery-3.2.1.js"></script>
		<!-- bootstrap -->
		<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js" type="text/javascript"></script>
	</head>

	<body>
		<!--员工添加模态框  -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">

<form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-2 control-label">empName</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="empName_add_input" placeholder="empName" name="empName">
      <span  class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">email</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="email_add_input" placeholder="email@guigu.com" name="email">
      <span  class="help-block"></span>	
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">gender</label>
    <div class="col-sm-10">
      <div class="radio">
  <label>
    <input type="radio" name="gender" id="gender1_add_input" value="M" checked>
    男
  </label>
</div>
<div class="radio">
  <label>
    <input type="radio" name="gender" id="gender2_add_input" value="F">
    女
  </label>
</div>
    </div>
  </div>
    <div class="form-group">
    <label  class="col-sm-2 control-label">deptName</label>
    <div class="col-sm-4">
    	<!--部门提交  -->
      <select  class="form-control" name="dId">
  
</select>
    </div>
  </div>
  
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>


<!--修改  -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
      </div>
      <div class="modal-body">

<form class="form-horizontal">
  <div class="form-group">
    <label  class="col-sm-2 control-label">empName</label>
    <div class="col-sm-10">
       <p class="form-control-static" id="empName_update_static"></p>
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">email</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="email_update_input" placeholder="email@guigu.com" name="email">
      <span  class="help-block"></span>	
    </div>
  </div>
  <div class="form-group">
    <label  class="col-sm-2 control-label">gender</label>
    <div class="col-sm-10">
      <div class="radio">
  <label>
    <input type="radio" name="gender" id="gender1_update_input" value="M" checked>
    男
  </label>
</div>
<div class="radio">
  <label>
    <input type="radio" name="gender" id="gender2_update_input" value="F">
    女
  </label>
</div>
    </div>
  </div>
    <div class="form-group">
    <label  class="col-sm-2 control-label">deptName</label>
    <div class="col-sm-4">
    	<!--部门提交  -->
      <select  class="form-control" name="dId">
  
</select>
    </div>
  </div>
  
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>

<!-- /.modal --><!--搭建页面  -->
		<div class="container">
			<!--标题  -->
			<div class="row">
				<div class="col-md-12">
					<h1>SSM-CRUD</h1>
				</div>
			</div>
			<!-- 按钮 -->
			<div class="row">
				<div class="col-md-4 col-md-offset-8">
					<button class="btn btn-primary" id="emp_add_modal_btn" >新增</button>
					<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
				</div>
			</div>
			<!-- 表格数据 -->

			<div class="row">
				<div class="col-md-12">
					<table class="table table-hover" id="emps_table">
						<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>

						</tr>
						</thead>
						<tbody>
						
						
						
						</tbody>
						

					</table>
				</div>
			</div>
			<!-- 分页 -->
			<div class="row">
				<!--分页信息  -->
				<div class="col-md-6" id="page_info_area">
					
				</div>

				<!-- 分页条 -->
				<div class="col-md-6" id="page_nav_area">
					
				</div>

			</div>

		</div>
		
		<script type="text/javascript">
			var totalRecord,currentPage;
			//1.页面加载完成，发送ajax数据
			$(function(){
				//去首页
				to_page(1);
				
			});
			function to_page(pn){
				$.ajax({
					url:"${APP_PATH}/emps",
					data:"pn="+pn,
					type:"GET",
					success:function(result){
						console.log(result);
						//1.解析并显示员工数据
						build_emps_table(result);
						
						//2.解析并显示分页信息
						build_page_info(result);
						build_page_nav(result);
					}
				});
			}
			function build_emps_table(result){
				//清空
				$("#emps_table tbody").empty();
				var emps=result.extend.pageInfo.list;
				
				$.each(emps,function(index,item){
					//alert(item.empName);
					var checkboxTd=$("<td><input type='checkbox' class='check_item'/></td>")
					var empIdTd= $("<td></td>").append(item.empId);
					var empNameTd= $("<td></td>").append(item.empName);
					var genderTd= $("<td></td>").append(item.gender=='M'?"男":"女");
					var emailTd= $("<td></td>").append(item.email);
					var daptNameTd=$("<td></td>").append(item.department.deptName);
					/*构建button按钮  */
					var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil ")).append("编辑");
					//给编辑按钮添加自定义属性，来表示当前员工id
					editBtn.attr("edit-id",item.empId);
					var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
					delBtn.attr("del-id",item.empId);
					var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
					$("<tr></tr>").append(checkboxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(daptNameTd)
					.append(btnTd)
					
					.appendTo("#emps_table tbody")
				}) ;
			}
			
			function build_page_info(result){
				$("#page_info_area").empty();
				$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages+"页"+
						"，总"+result.extend.pageInfo.total+"条数据");
				totalRecord=result.extend.pageInfo.total;
				currentPage=result.extend.pageInfo.pageNum;
				
			}
			function build_page_nav(result){
				$("#page_nav_area").empty();
				var ul=$("<ul></ul>").addClass("pagination");
				
				//构建元素
				var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
				var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
				if(result.extend.pageInfo.hasPreviousPage==false){
					firstPageLi.addClass("disabled");
					prePageLi.addClass("disabled");
					
				}else{
					//为元素添加翻页事件
					firstPageLi.click(function(){
						to_page(1);
					});
					prePageLi.click(function(){
						to_page(result.extend.pageInfo.pageNum-1);
					});
				}
				
				
				var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
				var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
				
				if(result.extend.pageInfo.hasNextPage==false){
					nextPageLi.addClass("disabled");
					lastPageLi.addClass("disabled");
					
				}else{
					nextPageLi.click(function(){
						to_page(result.extend.pageInfo.pageNum+1);
					});
					lastPageLi.click(function(){
						to_page(result.extend.pageInfo.pages);
					});
					
				}
				//添加前一页后一页提示
				ul.append(firstPageLi).append(prePageLi);
				//123遍历给ul
				
				$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
					
					
					
					var numLi =$("<li></li>").append($("<a></a>").append(item));
					if(result.extend.pageInfo.pageNum==item){
						numLi.addClass("active");
					}
					numLi.click(function(){
						to_page(item);
					});
					ul.append(numLi);
				})
				ul.append(nextPageLi).append(lastPageLi);
				var navEle=$("<nav></nav>").append(ul);
				navEle.appendTo("#page_nav_area");
				 
			}
			
			//校验用户名是否可用
			$("#empName_add_input").change(function(){
				//发送ajax请求校验用户名是否可用
				var empName=this.value;
				$.ajax({
					url:"${APP_PATH}/checkuser",
					data:"empName="+empName,
					type:"POST",
					success:function(result){
						if(result.code==100){
							show_validate_msg("#empName_add_input","success","用户名可用");
							$("#emp_save_btn").attr("ajax-va","success");
						}else{
							var errorMsg=result.extend.va_msg;
							show_validate_msg("#empName_add_input","error",result.extend.va_msg);
							$("#emp_save_btn").attr("ajax-va","error");
						}
					}
					
				});
			});
			
			//重置表单
			function reset_form(ele){
				//内容
				$(ele)[0].reset();
				//样式
				$(ele).find("*").removeClass("has-error has-success");
				//提示信息
				$(ele).find(".help-block").text("");
			}
			
			
			$("#emp_add_modal_btn").click(function(){
				//重置
				//$("#empAddModal form")[0].reset();
				reset_form("#empAddModal form");
				getDepts("#empAddModal select");
				
				$("#empAddModal").modal({
					 backdrop:"static"
				 }
				 
				 );
				$("#empName_add_input,#email_add_input ").parent().removeClass("has-error has-success");
				 
			});
			
			//动态加载部门信息
			function getDepts(ele){
				$(ele).empty();
				$.ajax({
					url:"${APP_PATH}/depts",
					
					type:"GET",
					success:function(result){
						console.log(result);
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId)
						optionEle.appendTo(ele);
					})	
					}
				})
			}
			//校验信息
			function validate_add_form(){
				var empName =$("#empName_add_input").val();
				var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				//用户名校验
				if(!regName.test(empName)){
					//alert("用户名为2-5位中文，或6-16位英文和数字的组合");
					show_validate_msg("#empName_add_input","error","用户名为2-5位中文，或6-16位英文和数字的组合")
					
					
				}else{
					show_validate_msg("#empName_add_input","success","")
					
				}
				//emai校验
				var email =$("#email_add_input").val();
				var regmail=/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
				if(!regmail.test(email)){
					//alert("邮箱格式不正确");
					//清空之前的样式
					show_validate_msg("#email_add_input","error","邮箱格式不正确");
					
					return false;
				}else{
					show_validate_msg("#email_add_input","success","")
				}
				return true;
			};
			
			function show_validate_msg(ele,status,msg){
				//清除当前元素状态
				$(ele).parent().removeClass("has-error has-success");
				if("error"==status){
					$(ele).parent().addClass("has-error");
					$(ele).next("span").text(msg);
				}else if("success"==status){
					$(ele).parent().addClass("has-success");
					$(ele).next("span").text(msg);
				}
				
			}
			
			
			$("#emp_save_btn").click(function(){
				//1.模态框中填写的表单数据提交给服务器保存。
				//2.校验
				//
				
				 if(!validate_add_form()){
					
					return false;
				}else if(validate_add_form()){
					
					if($(this).attr("ajax-va")=="error"){
						$("#empName_add_input").parent().removeClass("has-success");
						$("#empName_add_input").parent().addClass("has-error");
						$("#empName_add_input").next("span").text("用户名不可用");
						
					}
					
				}
				//3.判断之前的ajax用户名校验是否成功，如果成功
				
				if(($(this).attr("ajax-va")=="error")){
					
					return false;
				}
				
				
				//3.发送ajax
				$.ajax({
					url:"${APP_PATH}/emp",
					
					type:"POST",
					data:$("#empAddModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						if(result.code==100){
							$('#empAddModal').modal('hide')
							to_page(totalRecord);
						}else{
							//显示失败信息
							//console.log(result);
							
							 if(undefined!=result.extend.errorFields.email){
								//显示邮箱错误信息
								show_validate_msg("#email_add_input","error","邮箱格式不正确");	
							}
							if(undefined!=result.extend.errorFields.empName){
								//显示员工名字的错误信息
								show_validate_msg("#empName_add_input","error","用户名为2-5位中文，或6-16位英文和数字的组合")
							} 
						}
						
					}
					
				});
			});
			//在文档加载后 绑定事件
			$(document).on("click",".edit_btn",function(){
				//1.查出部门信息
				getDepts("#empUpdateModal select")
				//2.查出员工信息
			getEmp($(this).attr("edit-id"));
			
			//3.把员工id传递给更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
			$("#empUpdateModal").modal({
					 backdrop:"static"
				 })
			});
			
			function getEmp(id){
				$.ajax({
					url:"${APP_PATH}/emp/"+id,
					type:"GET",
					success:function(result){
						console.log(result);
						var empData=result.extend.emp;
						$("#empName_update_static").text(empData.empName);
						$("#email_update_input").val(empData.email);
						$("#empUpdateModal input[name=gender]").val([empData.gender]);
						
						
						$("#empUpdateModal select").val([empData.dId]);
					}
				})
			}
			$("#emp_update_btn").click(function(){
				//验证邮箱
				var email =$("#email_update_input").val();
				var regmail=/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
				if(!regmail.test(email)){
					
					show_validate_msg("#email_update_input","error","邮箱格式不正确");
					
					return false;
				}else{
					show_validate_msg("#email_update_input","success","")
				}
				
				//2.发送put请求
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
					type:"PUT",
					data:$("#empUpdateModal form").serialize(),
					success:function(result){
						//alert();
						//1.关闭modal
						$("#empUpdateModal").modal("hide");
						//2.回到本页面
						to_page(currentPage);
						
					}
				})
			})
			//在文档加载后 绑定事件
			$(document).on("click",".delete_btn",function(){
				//1.弹窗
				var empName=$(this).parents("tr").find("td:eq(2)").text();
				var empId=$(this).attr("del-id");
				/*alert($(this).parents("tr").find("td:eq(1)").text()) */
				if(confirm("确认删除【"+empName+"】吗？")){
					$.ajax({
						url:"${APP_PATH}/emp/"+empId,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							//回到本页
							to_page(currentPage);
						}
					})
				}
			
			
			});
			
			//全选/全不选
			$("#check_all").click(function(){
				//attr获取checked是undefined；
				//原生属性用prop，自定义用attr
				$(this).prop("checked");
				$(".check_item").prop("checked",$(this).prop("checked"));
			
			})
			$(document).on("click",".check_item",function(){
				var flag =$(".check_item:checked").length==$(".check_item").length;
				$("#check_all").prop("checked",flag)
			});
			
			//批量删除
			$("#emp_delete_all_btn").click(function(){
				var empNames="";
				var del_idstr="";
				$.each($(".check_item:checked"),function(){
					//this
					empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
					//id 字符串
					del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				
				})
				
				//去除empNames多余的，
				empNames=empNames.substring(0,empNames.length-1);
				del_idstr=del_idstr.substring(0,del_idstr.length-1);
				if(confirm("确认删除【"+empNames+"】吗？")){
						$.ajax({
							url:"${APP_PATH}/emp/"+del_idstr,
							type:"DELETE",
							success:function(result){
								alert(result.msg);
								//回到本页
								to_page(currentPage);
							}
						})
						
				}
			
			})
		</script>

	</body>

</html>