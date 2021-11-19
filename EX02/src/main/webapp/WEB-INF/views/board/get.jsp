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
                            Board View
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div class="form-group">
                           		<label>bNo</label> <input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly>
                           	</div>
                           	<div class="form-group">
                           		<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly>
                           	</div>
                           	<div class="form-group">
                           		<label>Content</label>
                           		<textarea rows="3" name="content" class="form-control" readonly><c:out value="${board.content }"/></textarea>
                           	</div>
                           	<div class="form-group">
                           		<label>Writer</label> <input class="form-control" name="writer" value="${board.writer }" readonly>
                           	</div>
                           	<!-- data-oper >> 사용자 정의 속성. 만들어서 쓰는거임. 앞에 접두어 data가 붙음  -->
                           	<%-- <button data-oper="modify" class="btn btn-default">
                           		<a href='/board/modify?bno=<c:out value="${board.bno }"/>'>modify</a>
                           	</button>
                           	<button data-oper="list" class="btn btn-default">
                           		<a href="/board/list">list</a>
                           	</button> --%>
                           	
                         	<%-- <a data-oper="modify" class="btn btn-primary" href='/board/modify?bno=<c:out value="${board.bno}"/>'>modify</a>
                        	<a data-oper="list" class="btn btn-default" href="/board/list">list</a> --%>
                        	
                        	<button data-oper="modify" class="btn btn-primary">modify</button>
                           	<button data-oper="list" class="btn btn-default">list</button>
                           	
                           	<form id="operForm" action="/board/modify" method="get">
                           		<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
                           		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
                           		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
                           		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                           		<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
                           	</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 이 jQuery 문은 수정 / 목록 기능을 버튼 태그로 구현했을 때 사용하는 query문이다. -->
            <script type="text/javascript">
            	$(document).ready(function(){
            		var operForm = $("#operForm");
            		
            		
            		$("button[data-oper='modify']").on("click", function(e){
            			operForm.attr("action", "/board/modify").submit();
            			
            		});
            		
            		$("button[data-oper='list']").on("click", function(e){
            			operForm.find("#bno").remove()
            			operForm.attr("action", "/board/list");
            			operForm.submit();
            			
            		});
            	});
            </script>
            
<%@ include file="../include/footer.jsp" %>