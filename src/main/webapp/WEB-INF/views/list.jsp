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
		<!--搭建页面  -->
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
					<button class="btn btn-primary">新增</button>
					<button class="btn btn-danger">删除</button>
				</div>
			</div>
			<!-- 表格数据 -->

			<div class="row">
				<div class="col-md-12">
					<table class="table table-hover">
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>

						</tr>
						<%-- <c:forEach var="每个变量名字"   items="要迭代的list"   varStatus="每个对象的状态"

                           begin="循环从哪儿开始"    end="循环到哪儿结束"    step="循环的步长">

                              循环要输出的东西

                  </c:forEach> --%>
						<c:forEach items="${pageInfo.list}" var="emp">
							<tr>
								<th>${emp.empId}</th>
								<th>${emp.empName}</th>
								<th>${emp.gender=="M"?"男":"女"}</th>
								<th>${emp.email}</th>
								<th>${emp.department.deptName}</th>
								<th>
									<button class="btn btn-primary">编辑</button>
									<button class="btn btn-danger">删除</button>
								</th>

							</tr>
						</c:forEach>

					</table>
				</div>
			</div>
			<!-- 分页 -->
			<div class="row">
				<!--分页信息  -->
				<div class="col-md-6">
					当前记录数：${pageInfo.pageNum}页，总${pageInfo.pages}页，总${pageInfo.total}条数据
				</div>

				<!-- 分页条 -->
				<div>
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<li>
								<a href="${APP_PATH}/emps?pn=1">首页</a>
							</li>

							<c:if test="${pageInfo.hasPreviousPage}">
								<li>
									<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>

							<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
								<c:if test="${page_Num==pageInfo.pageNum}">
									<li class="active">
										<a href="#">${page_Num}</a>
									</li>
								</c:if>
								<c:if test="${page_Num!=pageInfo.pageNum}">
									<li>
										<a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a>
									</li>
								</c:if>

							</c:forEach>
							<c:if test="${pageInfo.hasNextPage}">
							<li>
								<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
							</c:if>
							<li>
								<a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a>
							</li>
						</ul>
					</nav>
				</div>

			</div>

		</div>

	</body>

</html>