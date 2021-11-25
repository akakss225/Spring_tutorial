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
            <!-- 댓글 목록 ------------------------------------------------------------------------------------->
            <div class="row">
            	<div class = "col-lg-12">
            		<div class="panel panel-default">
	            		<div class="panel-heading">
	            			<i class="fa fa-comments fa-fw"></i> Reply
	            			<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>	            		
            			</div>
	            		<div class="panel-body">	
	            			<ul class="chat">
	            			
	            			</ul>
	            		</div>
	            		<div class="panel-footer">
	            		
	            		</div>
            		</div>
            	</div>
            </div>
            <!-------------------------------------------------------------------------------------- 댓글 목록 -->
            
            <!-- 댓글 등록 모달 ------------------------------------------------------------------------------------>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            	<div class="modal-dialog">
            		<div class="modal-content">
            			<div class="modal-header">
            				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            			</div>
            			<div class="modal-body">
            				<div class="form-group">
            					<label>Reply</label>
            					<input class="form-control" name="reply" value="New Reply">
            				</div>
            				<div class="form-group">
            					<label>Replyer</label>
            					<input class="form-control" name="replyer" value="Replyer">
            				</div>
            				<div class="form-group">
            					<label>Reply Date</label>
            					<input class="form-control" name="replyDate" value="">
            				</div>
            			</div>
            			<div class="modal-footer">
            				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
            				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
            				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
            				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			</div>
            		</div>
            	</div>
            </div>
            <!------------------------------------------------------------------------------------ 댓글 등록 모달 -->
            
            <script type = "text/javascript" src = "/resources/js/reply.js"></script>
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
            
            <script type="text/javascript">
            	$(document).ready(function(){
            		var bnoValue = '<c:out value="${board.bno}"/>';
            		var replyUL = $(".chat");
            		
            		showList(1);
            		
            		// 댓글 목록에서 pagination을 보이게 구문 추가.
            		function showList(page){
            			replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
            				
            				
            				// 등록 후 마지막 페이지로 이동하는 코드
            				if(page == -1){
            					pageNum = Math.ceil(replyCnt/ 10.0);
            					showList(pageNum);
            					return;
            				}
            				
            				var str = "";
            				
            				if(list == null || list.lenght == 0){
            					return;
            				}
            				for (var i = 0, len = list.length || 0; i < len; i++){
            					str += "<li class='left clearfix' data-rno='"+ list[i].rno +"'>";
            					str += "	<div><div class = 'header'><strong class='primary-font'>[" + list[i].replyer + "] " + list[i].replyer + "</strong>";
            					str += "	<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
            					str += "	<p>" + list[i].reply + "</p></div></li>";
            				}
            				replyUL.html(str);
            				// 댓글 페이지 보이게하는 코드
            				showReplyPage(replyCnt);
            			});
            		}
            		
            		// 댓글 pagenation구현.
            		var pageNum = 1;
            		var replyPageFooter = $(".panel-footer");
            		
            		function showReplyPage(replyCnt){
            			var endNum = Math.ceil(pageNum/10.0) * 10;
            			var startNum = endNum - 9;
            			
            			var prev = startNum != 1;
            			var next = false;
            			
            			if(endNum * 10 >= replyCnt){
            				endNum = Math.ceil(replyCnt/10.0);
            			}
            			if(endNum * 10 < replyCnt){
            				next = true;
            			}
            			
            			var str = "<ul class='pagination pull-right'>";
            			
            			if(prev){
            				str += "<li class='page-item'><a class='page-link' href='"+ (startNum - 1) +"'>Previous</a></li>";
            			}
            			
            			for(var i = startNum; i <= endNum; i++){
            				var active = pageNum == i? "active" : "";
            				
            				str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>" + i + "</a></li>";
            			}
            			if(next){
            				str += "<li class='page-item'><a class='page-link' href='" +(endNum + 1)+ "'>Next</a></li>";
            			}
            			
            			str += "</ul>";
            			
            			console.log(str);
            			
            			replyPageFooter.html(str);
            		} // showReplyPage()
            		
            		replyPageFooter.on("click", "li a", function(e){
            			e.preventDefault();
            			
            			console.log("page click");
            			
            			var targetPageNum = $(this).attr("href");
            			
            			console.log("targetPageNum : " + targetPageNum);
            			
            			pageNum = targetPageNum;
            			
            			showList(pageNum);
            			
            		});
            		
            		var modal = $(".modal");
            		var modalInputReply = modal.find("input[name='reply']");
            		var modalInputReplyer = modal.find("input[name='replyer']");
            		var modalInputReplyDate = modal.find("input[name='replyDate']");
            		
            		var modalModBtn = $("#modalModBtn");
            		var modalRemoveBtn = $("#modalRemoveBtn");
            		var modalRegisterBtn = $("#modalRegisterBtn");
            		
            		$("#addReplyBtn").on("click", function(){
            			
            			// input 태그를 우선 비워주기
            			modal.find("input").val("");
            			// 등록 할 때에는 등록과 닫기 버튼만 있으면 되기 때문에, 다른건 숨겨준다.
            			modalInputReplyDate.closest("div").hide(); // 부모중 가장 가까운 부모를 찾아서 숨겨줌 이 경우, replyDate의 form-group이 됨
            			modal.find("button[id != 'modalCloseBtn']").hide();
            			// register버튼 보여주게 하는코드
            			modalRegisterBtn.show();
            			
            			$(".modal").modal("show");
            			
            		});
            		
            		modalRegisterBtn.on("click", function(e){
            			var reply = {
            					reply : modalInputReply.val(),
            					replyer : modalInputReplyer.val(),
            					bno : bnoValue
            			};
            			replyService.add(reply, function(result){
            				alert(result);
            				
            				modal.find("input").val("");
            				modal.modal("hide");
            				
            				//showList(1);
            				showList(-1); // 댓글 등록시, 등록이 된 마지막 페이지로 이동을 의미함.
            			});
            		});
            		
            		$(".chat").on("click", "li", function(e){ // 위임 해주는 코드 >> delegate
            			var rno = $(this).data("rno");
            			
            			console.log(rno);
            			
            			replyService.get(rno, function(reply){
            				modalInputReply.val(reply.reply);
            				modalInputReplyer.val(reply.replyer);
            				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
            				modal.data("rno", reply.rno);
            				
            				modal.find("button[id != 'modalCloseBtn']").hide();
            				modalModBtn.show();
            				modalRemoveBtn.show();
            				
            				$(".modal").modal("show");
            			
            			});
            		});
            		
            		modalModBtn.on("click", function(e){
            			var reply = {rno : modal.data("rno"), reply : modalInputReply.val()};
            			
            			replyService.update(reply, function(result){
            				alert(result);
            				modal.modal("hide");
            				showList(pageNum);
            			});
            			
            		});
            		
            		modalRemoveBtn.on("click", function(e){
            			var rno = modal.data("rno");
            			
            			replyService.remove(rno, function(result){
            				alert(result);
            				modal.modal("hide");
            				showList(pageNum);
            			});
            		});
            		
            		
            	});
            </script>
            
<%@ include file="../include/footer.jsp" %>