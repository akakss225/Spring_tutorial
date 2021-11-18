<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/board/modify" method="post">
                            	<div class="form-group">
                            		<label>bNo</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly>
                            	</div>
                            	<div class="form-group">
                            		<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>'>
                            	</div>
                            	<div class="form-group">
                            		<label>Content</label>
                            		<textarea rows="3" name="content" class="form-control"><c:out value="${board.content }"/></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly>
                            	</div>
                            	<div class="form-group">
                            		<label>RegDate</label> <input class="form-control" name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>' readonly>
                            	</div>
                            	<div class="form-group">
                            		<label>UpdateDate</label> <input class="form-control" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate }"/>' readonly>
                            	</div>
                            	<button type="submit" data-oper="modify" class="btn btn-primary">mod</button>
                           		<button type="submit" data-oper="remove" class="btn btn-danger">del</button>
                           		<button type="submit" data-oper="list" class="btn btn-default">list</button>
                            </form>
                            <!-- /.form -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <script type="text/javascript">
				$(document).ready(function(){
					var formObj = $("form");
					
					$("button").on("click", function(e){
						e.preventDefault();
						
						var operation = $(this).data("oper");
						
						console.log(operation);
						
						if(operation === "remove"){
							formObj.attr("action", "/board/remove");
						}
						else if(operation === "list"){
							// 수정 전
							// 글 목록으로 이동
							// self.location = "/board/list";
							// formObj.submit()을 실행하지 않고 중지.
							// return;
							// 수정 후
							formObj.attr("action", "/board/list").attr("methid", "get");
							formObj.empty(); // form내용을 비우기. >> 자식 태그들 지우기.
							
						}
						formObj.submit();
					});
				});
			</script>
            
            
<%@ include file="../include/footer.jsp" %>