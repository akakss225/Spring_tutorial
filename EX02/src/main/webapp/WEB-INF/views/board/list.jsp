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
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
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
                                		<td><c:out value="${board.title}" /></td>
                                		<td><c:out value="${board.writer}" /></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                                	</tr>
                                </c:forEach>
                            </table>
                            <!-- /.table-responsive -->
                            
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                           	Posting Successfully
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
                            		function checkModal(result){
                            			// 등록 후 목록으로 이동한 경우가 아니면 result 값이 없으므로 중지
                            			if(result === ''){
                            				return;
                            			}
                            			if(parseInt(result)>0){
                            				$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다." );
                            			}
                            			// 모달창이 보이게
                            			$("#myModal").modal("show");
                            			
                            		}
                            		// 글등록 버튼 클릭시 등록화면으로 이동.
                            		$("#regBtn").on("click", function(){
                        				self.location="/board/register";
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