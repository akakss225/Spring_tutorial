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
                            Board List Page
                            <button id="regBtn" type="button" class="btn btn-primary btn-xs pull-right">posting</button>
                            
                            <div class="dropdown pull-right">
								  <button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown">Amount
								  <span class="caret"></span></button>
								  <ul class="dropdown-menu">
									<li><a href="10">10</a></li>
									<li><a href="15">15</a></li>
									<li><a href="20">20</a></li>
								  </ul>
							</div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-  body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#No</th>
                                        <th width="500">Title</th>
                                        <th>Writer</th>
                                        <th>Write Date</th>
                                        <th>Update Date</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}" /></td>
                                		<td>
                                			<a class="move" href='<c:out value="${board.bno}"/>'>
                                				<c:out value="${board.title}" /> <b><c:out value="${board.replycnt == 0 ? '' : [board.replycnt] }"/></b>
                                			</a>
                                		</td>
                                		<td><c:out value="${board.writer}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                                	</tr>
                                </c:forEach>
                            </table>
                            <!-- /.table-responsive -->
                            
							<div class="row">
	                            <div class="col-lg-12">
		                            <form id="searchForm" action="/board/list" method="get">
		                            	<select name="type">
		                            		<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>---</option>
		                            		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>??????</option>
		                            		<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>??????</option>
		                            		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>?????????</option>
		                            		<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>??????&amp;??????</option>
		                            	</select>
		                            	<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>'/>
		                            	<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
		                            	<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
		                            	<button class="btn btn-primary btn-xs">search</button>
		                            </form>
	                            </div>
                            </div>
                            
                            <form id="actionForm" action="/board/list" method="get">
                            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                            	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                            	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>'>
                            	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.type }"/>'>
                            </form>
		                            
                            <div class="pull-right">
                            	<ul class="pagination">
                            		<c:if test="${pageMaker.prev }">
                            			<li class="pageinate_button previous"><a href="${pageMaker.startPage - 1 }">Previous</a></li>
                            		</c:if>
	                            	<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	                            		<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : "" }"><a href="${num }">${num }</a></li>
	                            	</c:forEach>
	                            	
	                            	<c:if test="${pageMaker.next }">
	                            		<li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
	                            	</c:if>
	                            </ul>
                            </div>
                            <!-- end Pagination -->

                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                           	Successfully
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                            <script type="text/javascript">
                            	$(document).ready(function(){
                            		var result = '<c:out value="${result}"/>';
                            		checkModal(result);
                            		
                            		// ???????????? ????????? ??? ???????????? ?????? ??????????????? ????????? 1.
                            		// history.state ?????????.
                            		history.replaceState({}, null, null);
                            		
                            		function checkModal(result){
                            			// ?????? ??? ???????????? ????????? ????????? ????????? result ?????? ???????????? ??????
                            			// ???????????? ????????? ??? ???????????? ?????? ??????????????? ????????? 2.
                            			if(result === '' || history.state){
                            				return;
                            			}
                            			if(parseInt(result)>0){
                            				$(".modal-body").html("?????????" + parseInt(result) + "?????? ?????????????????????." );
                            			}
                            			// ???????????? ?????????
                            			$("#myModal").modal("show");
                            			
                            		}
                            		// ????????? ?????? ????????? ?????????????????? ??????.
                            		$("#regBtn").on("click", function(){
                        				self.location="/board/register";
                        			});
                            		
                            		var actionForm = $("#actionForm");
                            		
                            		$(".paginate_button a").on("click", function(e){
                            			e.preventDefault();
                            			
                            			console.log("click");
                            			// ???????????? ????????? , ?????? list????????? ????????? ?????? ??????
                            			actionForm.attr("action", "/board/list");
                                		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
                                		actionForm.submit();
                            		});
                            		// ?????? ????????? ??????????????? ??????
                            		$(".move").on("click", function(e){
                            			e.preventDefault();
                            			// hidden?????? ??????
                            			$(".bnoValue").remove();
                            			actionForm.append("<input class='bnoValue' type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
                            			actionForm.attr("action", "/board/get");
                            			actionForm.submit();
                            		});
                            		
                            		var searchForm = $("#searchForm");
                            		$("#searchForm button").on("click", function(e){
                            			
                            			if(!searchForm.find("option : selected").val()){
                            				alert("??????????????? ???????????????");
                            				return false;
                            			}
                            			if(!searchForm.find("input[name='keyword']").val()){
                            				alert("???????????? ???????????????");
                            				return false;
                            			}
                            			searchForm.find("input[name='pageNum']").val("1");
                            			e.preventDefault();
                            			searchForm.submit();
                            		});
                            		
                            		
                            		$(".dropdown a").on("click", function(e){
                            			e.preventDefault();
                            			actionForm.find("input[name='amount']").val($(this).attr("href"));
                            			actionForm.submit();
                            			
                            		});
                            		
                            		
                            	});
                            </script>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
<%@ include file="../include/footer.jsp" %>